import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_robonomics/polkawallet_plugin_robonomics.dart';
import 'package:polkawallet_ui/components/txButton.dart';

class LaunchPage extends StatefulWidget {
  static const String route = '/robonomics/launch';

  LaunchPage(this.pluginRobonomics, {Key? key}) : super(key: key);

  final PluginRobonomics pluginRobonomics;

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
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
                txTitle: 'Launch some shit',
                module: 'Launch',
                call: 'launch',
                params: [
                  // params.robot
                  '4DRbjJ6eJVrh13z2P3Us5Mwn6UAGp8ri48PXxrdL5yRwy8mE',
                  // params.param
                  true
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
