import 'dart:collection';
import 'dart:io';

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
    try {
      // TODO make sure that this will trow an exception
      Map<String, dynamic> listPays = await rpc!
          .call(method: "listpays", params: params.toListPaysRequest());
      Map<String, dynamic> listFunds = await rpc!
          .call(method: "listfunds", params: params.toListFundsRequest());

      /// Make a call to listfunds like the prev one, and take only the channels
      return Future.value(
          {"listpays": listPays, "channels": listFunds["channels"]});
    } catch (ex, stacktrace) {
      plugin.log(level: "broken", message: "error received: ${ex.toString()}");
      stderr.write(stacktrace);
      rethrow;
    }
  }

  /// This is the Kraken pay RPC method. This method allows for
  /// an alternate method to pay invoices in Core Lightning and
  /// return payment failure analysis reports.
  Future<Map<String, Object>> krakenPay(
      Plugin plugin, Map<String, Object> request) async {
    log(level: "info", message: "This is the kraken pay output.");
    try {
      // TODO: rpc should return an exception if any error occurs, and if we have the error returned run the doctor command
      HashMap<String, Object> result =
          await rpc!.call(method: "pay", params: PayRequest.fromJson(request));
      return Future.value(result);
    } catch (ex, stacktrace) {
      plugin.log(level: "broken", message: "error received: ${ex.toString()}");
      stderr.write(stacktrace);
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
        usage: "",
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

    return response;
  }
}
