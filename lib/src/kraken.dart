import 'package:cln_plugin_api/cln_plugin.dart';

class KrakenPlugin extends Plugin {
  /// This is the Kraken doctor RPC method. This method allows for
  /// analyzing the failure of invoice payments.
  Future<Map<String, Object>> krakenDoctor(
      Plugin plugin, Map<String, Object> request) {
    log(level: "info", message: "This is the kraken doctor output.");
    var params = HashMap<String, dynamic>{
       "invoice": request["invoice"],
    };
    let listpays = rpc.call(method: "listpays", params: params);
    /// Make a call to listfunds like the prev one, and take only the channels
    return Future.value({
          "listpays": listpays
          "channels": channels
    });
  }

  /// This is the Kraken pay RPC method. This method allows for
  /// an alternate method to pay invoices in Core Lightning and
  /// return payment failure analysis reports.
  Future<Map<String, Object>> krakenPay(
      Plugin plugin, Map<String, Object> request) {
    log(level: "info", message: "This is the kraken pay output.");
// TODO: rpc should return an exception if any error occurs, and if we have the error returned run the doctor command
   HashMap<String, dynamic> result = await rpc.call(method: "pay", params: PayInput.from(request));
    return Future.value(result);
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
}
