import 'package:cln_plugin_api/cln_plugin.dart';

class KrakenPlugin extends Plugin {
  /// Here we extend the base Plugin class of our API. This is the
  /// backbone of our plugin. All interactions with and by the plugin
  /// are done here.
  Future<Map<String, Object>> rpcMethod(
      Plugin plugin, Map<String, Object> request) {
    log(level: "info", message: "RPC Method call.");
    return Future.value({
      "greeting": "Hello ${options["name"]!.value.toString()}!",
    });
  }

  Future<Map<String, Object>> notifyMethod(
      Plugin plugin, Map<String, Object> request) {
    log(level: 'debug', message: 'Notification received!');
    return Future.value({});
  }

  Future<Map<String, Object>> hookMethod(
      Plugin plugin, Map<String, Object> request) {
    log(level: "info", message: "Hook message.");
    return Future(() => {"result": "continue"});
  }

  /// The important step is to register methods pertaining to our plugin for differed use cases.
  /// The following template demonstrates the standard way of defining a RPC Method, option, hook
  /// and a notification subscription.
  @override
  void configurePlugin() {
    /// The configurePlugin() override allows developing plugins by simply calling the functions
    /// required for handling the core plugin functionality. These methods allow callbacks that
    /// handle core logic behind the plugins.
    registerRPCMethod(
        name: "hello",
        usage: "",
        description:
            "This method will greet you and serves as an example of how to register a RPC method.",
        callback: rpcMethod);

    registerOption(
        name: "name",
        type: "string",
        def: "World",
        description: "This is your name and it will be used to greet you.",
        deprecated: false);

    registerHook(name: 'rpc_command', callback: hookMethod);

    registerSubscriptions(event: 'connect', callback: notifyMethod);
  }
}
