import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_robonomics/polkawallet_plugin_robonomics.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:polkawallet_ui/components/txButton.dart';
import 'package:polkawallet_ui/components/v3/addressFormItem.dart';
import 'package:polkawallet_ui/components/v3/addressTextFormField.dart';
import 'package:polkawallet_ui/components/v3/back.dart';

class DatalogPage extends StatefulWidget {
  static const String route = '/robonomics/datalog';

  DatalogPage(this.pluginRobonomics, {Key? key}) : super(key: key);

  final PluginRobonomics pluginRobonomics;

  @override
  State<DatalogPage> createState() => _DatalogPageState();
}

class _DatalogPageState extends State<DatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datalog'),
        centerTitle: true,
        leading: BackBtn(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
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
                  params: ['qwerty'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
