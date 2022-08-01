import 'package:cln_plugin/kraken.dart';

void main() {
  /// To create a plugin in dart we need to extend the Plugin
  /// class and create an instance of the extended class. This
  /// instance will be used for any interaction with our plugin.
  var kraken = KrakenPlugin();

  /// The plugin start method reads for incoming requests on the
  /// stdin and outputs on the stdout over the JSON-RPCv2.0.
  kraken.start();
}
