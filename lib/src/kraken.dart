import 'package:cln_plugin_api/cln_plugin.dart';

class KrakenPlugin extends Plugin {
  Future<Map<String, Object>> krakenDoctor(
      Plugin plugin, Map<String, Object> request) {
    log(level: "info", message: "RPC Method call.");
    return Future.value({
      "greeting": "Hello ${options["name"]!.value.toString()}!",
    });
  }

  Future<Map<String, Object>> krakenPay(
      Plugin plugin, Map<String, Object> request) {
    log(level: "info", message: "RPC Method call.");
    return Future.value({
      "greeting": "Hello ${options["name"]!.value.toString()}!",
    });
  }
  @override
  void configurePlugin() {
    registerRPCMethod(
        name: "kraken_pay",
        usage: "",
        description:
            "This method will greet you and serves as an example of how to register a RPC method.",
        callback: krakenPay);
    registerRPCMethod(
        name: "kraken_doctor",
        usage: "",
        description: "This method will analyze invoice ",
        callback: krakenDoctor);
  }
}
