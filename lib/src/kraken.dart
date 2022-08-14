import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:clightning_rpc/clightning_rpc.dart';
import 'package:cln_common/cln_common.dart';
import 'package:kraken/src/model/model.dart';
import 'package:cln_plugin_api/cln_plugin.dart';

class KrakenPlugin extends Plugin {
  LightningClient? rpc;

  KrakenPlugin({this.rpc});

  /// This is the Kraken doctor RPC method. This method allows for
  /// analyzing the failure of invoice payments.
  Future<Map<String, Object>> krakenDoctor(
      Plugin plugin, Map<String, Object> request) async {
    log(level: "info", message: "This is the kraken doctor output.");
    var params = DoctorRequest.fromJson(request);
    Map<String, dynamic> response = {};
    try {
      // TODO make sure that this will trow an exception
      Map<String, dynamic>? listPays;
      if (request.containsKey("bolt11")) {
        listPays = await rpc!
            .call(method: "paystatus", params: params.toPaysStatusRequest());
        response["listpays"] = listPays;
      }
      Map<String, dynamic> listFunds = await rpc!
          .call(method: "listfunds", params: params.toListFundsRequest());

      response.addAll({
        "channels": listFunds["channels"],
        "raw_reason": request["raw_reason"] ?? "unknown",
        "raw_error_code": request["raw_error_code"] ?? "unknown",
        "raw_data": request["raw_data"] ?? "unknown"
      });
      return Future.value(response.cast<String, Object>());
    } on LNClientException catch (ex, stacktrace) {
      plugin.log(level: "broken", message: "error received: ${ex.message}");
      plugin.log(level: "broken", message: stacktrace.toString());
      rethrow;
    }
  }

  Future<String> handleBolt12(Plugin plugin,
      {required FetchInvoiceRequest offer}) async {
    var fetchInvoice = await rpc!.call<FetchInvoiceRequest,
            FetchInvoiceResponse>(
        method: "fetchinvoice",
        params: offer,
        onDecode: (json) =>
            FetchInvoiceResponse.fromJson(json as HashMap<String, dynamic>));
    log(level: "info", message: "fetch invoice: ${fetchInvoice.toJSON()}");
    return fetchInvoice.invoice;
  }

  /// This is the Kraken pay RPC method. This method allows for
  /// an alternate method to pay invoices in Core Lightning and
  /// return payment failure analysis reports.
  ///
  /// For more info on what command we are wrapping, check the cln pay command
  // https://lightning.readthedocs.io/lightning-pay.7.html
  Future<Map<String, Object>> krakenPay(
      Plugin plugin, Map<String, Object> request) async {
    log(
        level: "info",
        message: "This is the kraken pay cmd with request: $request");
    try {
      String invoice = request["invoice"]! as String;
      // The human-readable prefix for BOLT 12 offers is lno.
      if (invoice.startsWith("lno")) {
        request["bolt11"] = invoice;
        // Modify request with the correct bolt 12!
        // FIXME: we should remove the msatoshi amount from the request? or the pay command
        // us smart enough to handle it?
        var amountMsat = request["amount_msat"] == null
            ? null
            : int.parse(request["amount_msat"].toString());

        request["bolt11"] = await handleBolt12(plugin,
            offer: FetchInvoiceRequest(
                offer: invoice,
                msatoshi: request["msatoshi"]?.toString(),
                amountMsat: amountMsat));
      } else {
        request["bolt11"] = invoice;
      }
      PayResponse result = await rpc!.call<PayRequest, PayResponse>(
          method: "pay",
          params: PayRequest.fromJson(request),
          onDecode: (jsonPayload) =>
              PayResponse.fromJson(jsonDecode(jsonEncode(jsonPayload))));
      return result.toJSON() as Map<String, Object>;
    } on LNClientException catch (ex, stacktrace) {
      request["raw_reason"] = ex.message;
      request["raw_error_code"] = ex.code;
      if (ex.data != null) {
        request["raw_data"] = ex.data!;
      }
      plugin.log(
          level: "broken",
          message:
              "error received: msg=${ex.message} code: ${ex.code} data: ${ex.data}");
      plugin.log(level: "broken", message: stacktrace.toString());
      return krakenDoctor(plugin, request);
    } catch (ex, stacktrace) {
      plugin.log(level: "broken", message: "error received: ${ex.toString()}");
      plugin.log(level: "broken", message: stacktrace.toString());
      rethrow;
    }
  }

  @override
  void configurePlugin() {
    registerRPCMethod(
        name: "kraken_doctor",
        usage: "",
        description:
            "Statically analyze a payment and provide insights in the case of a failure.",
        callback: krakenDoctor);
    registerRPCMethod(
        name: "kraken_pay",
        usage: "[bolt11]",
        description:
            "Wrap all the complexity to pay an invoice under one single command, and produce a failure report if the command fails.",
        callback: krakenPay);
  }

  @override
  Future<Map<String, Object>> init(Plugin plugin, Map<String, Object> request) {
    var response = super.init(plugin, request);

    var rpcPath = configuration["lightning-dir"]!.toString();
    var rpcName = configuration["rpc-file"]!.toString();
    rpc = RPCClient().connect("$rpcPath/$rpcName") as RPCClient;
    log(level: "info", message: "kraken payment configured");
    log(level: "info", message: "Configuration payload $configuration");
    return response;
  }
}
