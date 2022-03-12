import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_robonomics/polkawallet_plugin_robonomics.dart';
import 'package:polkawallet_ui/components/txButton.dart';

class DatalogPage extends StatefulWidget {
  static const String route = '/robonomics/datalog';

  DatalogPage(this.pluginRobonomics, {Key? key}) : super(key: key);

  final PluginRobonomics pluginRobonomics;

  @override
  State<DatalogPage> createState() => _DatalogPageState();
}

class _DatalogPageState extends State<DatalogPage> {
  Future<void> read() async {
    final dynamic res =
        await widget.pluginRobonomics.sdk.api.service.webView!.evalJavascript(
      'api.query.datalog.datalog(${widget.pluginRobonomics.service.staking.keyring.current.address})',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TxButton(
            text: 'sign',
            onFinish: (res) {
              print(res);
            },
            getTxParams: () async {
              return TxConfirmParams(
                txTitle: 'Datalog some record',
                module: 'datalog',
                call: 'record',
                params: [
                  // params.record
                  'some some some',
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
