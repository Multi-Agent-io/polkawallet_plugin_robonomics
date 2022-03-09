import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_robonomics/polkawallet_plugin_robonomics.dart';
import 'package:polkawallet_sdk/api/api.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:polkawallet_ui/components/txButton.dart';
import 'package:polkawallet_ui/components/v3/addressFormItem.dart';
import 'package:polkawallet_ui/components/v3/addressTextFormField.dart';
import 'package:polkawallet_ui/components/v3/back.dart';
import 'package:polkawallet_ui/components/v3/cupertinoSwitch.dart';
import 'package:polkawallet_ui/utils/format.dart';
import 'package:polkawallet_ui/utils/index.dart';

class LaunchPage extends StatefulWidget {
  static const String route = '/robonomics/launch';

  LaunchPage(this.pluginRobonomics, {Key? key}) : super(key: key);

  final PluginRobonomics pluginRobonomics;

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  KeyPairData? _account;
  bool launchValue = false;

  PolkawalletApi get api => widget.pluginRobonomics.sdk.api;
  List<KeyPairData> get accounts {
    final keyring = widget.pluginRobonomics.service.staking.keyring;
    keyring.setSS58(widget.pluginRobonomics.service.plugin.basic.ss58);
    return keyring.allWithContacts;
  }

  void setAccount(KeyPairData? account) {
    setState(() {
      _account = account;
    });
  }

  void toggleLaunchValue(bool value) {
    setState(() {
      launchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Launch'),
        centerTitle: true,
        leading: BackBtn(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AddressTextFormField(
              api,
              accounts,
              initialValue: _account,
              onChanged: setAccount,
              labelText: 'Address',
            ),
            const SizedBox(height: 16),
            ListTile(
              trailing: CupertinoSwitch(
                value: launchValue,
                onChanged: toggleLaunchValue,
              ),
              title: Text('Launch param'),
            ),
            const SizedBox(height: 16),
            TxButton(
              text: 'Submit transaction',
              onFinish: (res) {
                print(res);
              },
              getTxParams: () async {
                return TxConfirmParams(
                  txTitle: 'Launch',
                  module: 'launch',
                  call: 'launch',
                  params: [
                    // params.robot
                    _account?.address,
                    // params.param
                    launchValue
                        ? '0x0000000000000000000000000000000000000000000000000000000000000001'
                        : '0x0000000000000000000000000000000000000000000000000000000000000000',
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
