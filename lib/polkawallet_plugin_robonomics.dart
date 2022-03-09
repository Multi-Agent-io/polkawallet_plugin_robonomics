library polkawallet_plugin_robonomics;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_robonomics/common/constants.dart';
import 'package:polkawallet_plugin_robonomics/service/index.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/plugin/homeNavItem.dart';
import 'package:polkawallet_sdk/plugin/index.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:polkawallet_ui/pages/dAppWrapperPage.dart';
import 'package:polkawallet_ui/pages/v3/txConfirmPage.dart';
import 'package:polkawallet_ui/pages/walletExtensionSignPage.dart';

class PluginRobonomics extends PolkawalletPlugin {
  /// the robonomics plugin support two networks: robonomics & polkadot,
  /// so we need to identify the active network to connect & display UI.
  PluginRobonomics()
      : basic = PluginBasicData(
          name: 'Robonomics',
          // genesisHash: genesis_hash_robonomics,
          ss58: 32,
          primaryColor: robonomics_black,
          gradientColor: Color(0xFF555555),
          backgroundImage: AssetImage(
              'packages/polkawallet_plugin_robonomics/assets/images/public/bg_robonomics.png'),
          icon: Image.asset(
              'packages/polkawallet_plugin_robonomics/assets/images/public/robonomics.png'),
          iconDisabled: Image.asset(
              'packages/polkawallet_plugin_robonomics/assets/images/public/robonomics_gray.png'),
          jsCodeVersion: 31501,
          isTestNet: false,
          isXCMSupport: true,
        ),
        recoveryEnabled = true;

  @override
  final PluginBasicData basic;

  @override
  final bool recoveryEnabled;

  @override
  List<NetworkParams> get nodeList {
    return node_list_robonomics.map((e) => NetworkParams.fromJson(e)).toList();
  }

  @override
  final Map<String, Widget> tokenIcons = {
    'KSM': Image.asset(
        'packages/polkawallet_plugin_robonomics/assets/images/tokens/KSM.png'),
    'DOT': Image.asset(
        'packages/polkawallet_plugin_robonomics/assets/images/tokens/DOT.png'),
  };

  @override
  List<HomeNavItem> getNavItems(BuildContext context, Keyring keyring) {
    return home_nav_items.map((e) {
      return HomeNavItem(
          text: e,
          icon: Container(),
          iconActive: Container(),
          content: Container(),
          onTap: () {
            Navigator.of(context).pushNamed('/$e/index');
          });
    }).toList();
  }

  @override
  Map<String, WidgetBuilder> getRoutes(Keyring keyring) {
    return {
      TxConfirmPage.route: (_) => TxConfirmPage(
          this,
          keyring,
          _service.getPassword as Future<String> Function(
              BuildContext, KeyPairData)),

//

      DAppWrapperPage.route: (_) => DAppWrapperPage(this, keyring),
      WalletExtensionSignPage.route: (_) => WalletExtensionSignPage(
          this,
          keyring,
          _service.getPassword as Future<String> Function(
              BuildContext, KeyPairData)),
    };
  }

  @override
  Future<String>? loadJSCode() => null;

  late PluginApi _service;
  PluginApi get service => _service;

  @override
  Future<void> onWillStart(Keyring keyring) async {
    try {
      loadBalances(keyring.current);
      print('robonomics plugin cache data loaded');
    } catch (err) {
      print(err);
      print('load robonomics cache data failed');
    }

    _service = PluginApi(this, keyring);
  }

  // @override
  // Future<void> onStarted(Keyring keyring) async {
  //   _service.staking.queryElectedInfo();
  // }

  @override
  Future<void> onAccountChanged(KeyPairData acc) async {
//
  }
}
