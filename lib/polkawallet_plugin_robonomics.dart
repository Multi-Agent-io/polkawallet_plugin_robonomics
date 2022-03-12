library polkawallet_plugin_robonomics;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_robonomics/common/constants.dart';
import 'package:polkawallet_plugin_robonomics/pages/launch/launch.dart';
import 'package:polkawallet_plugin_robonomics/pages/meta_hub/meta_hub_panel.dart';
import 'package:polkawallet_plugin_robonomics/pages/read_datalog/read_datalog.dart';
import 'package:polkawallet_plugin_robonomics/pages/write_datalog/write_datalog.dart';
import 'package:polkawallet_plugin_robonomics/service/index.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/plugin/homeNavItem.dart';
import 'package:polkawallet_sdk/plugin/index.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';

class PluginRobonomics extends PolkawalletPlugin {
  /// the robonomics plugin support two networks: robonomics & polkadot,
  /// so we need to identify the active network to connect & display UI.
  PluginRobonomics()
      : basic = PluginBasicData(
          name: 'Robonomics',
          // genesisHash: genesis_hash_robonomics,
          ss58: 32,
          primaryColor: robonomics_black,
          gradientColor: Color(0xFF2948d3),
          backgroundImage: AssetImage('packages/polkawallet_plugin_robonomics/assets/images/public/bg_robonomics.png'),
          icon: Image.asset('packages/polkawallet_plugin_robonomics/assets/images/public/robonomics.png'),
          iconDisabled: Image.asset('packages/polkawallet_plugin_robonomics/assets/images/public/robonomics_gray.png'),
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
    'KSM': Image.asset('packages/polkawallet_plugin_robonomics/assets/images/tokens/KSM.png'),
    'DOT': Image.asset('packages/polkawallet_plugin_robonomics/assets/images/tokens/DOT.png'),
  };

  @override
  List<HomeNavItem> getNavItems(BuildContext context, Keyring keyring) {
    return [
      HomeNavItem(
        text: basic.name!.toUpperCase(),
        icon: Container(),
        iconActive: Container(),
        isAdapter: true,
        content: MetaHubPanel(this),
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getRoutes(Keyring keyring) {
    return {
      LaunchPage.route: (context) => LaunchPage(this),
      ReadDatalogPage.route: (context) => ReadDatalogPage(this),
      WriteDatalogPage.route: (context) => WriteDatalogPage(this),
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

  @override
  Future<void> onStarted(Keyring keyring) async {
    _service.staking.queryElectedInfo();
  }

  @override
  Future<void> onAccountChanged(KeyPairData acc) async {
//
  }
}
