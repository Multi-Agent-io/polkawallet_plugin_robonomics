import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_robonomics/polkawallet_plugin_robonomics.dart';

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
    return Container();
  }
}
