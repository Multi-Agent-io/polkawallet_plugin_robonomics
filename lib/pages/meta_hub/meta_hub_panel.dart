import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polkawallet_plugin_robonomics/pages/datalog/datalog.dart';
import 'package:polkawallet_plugin_robonomics/pages/launch/launch.dart';
import 'package:polkawallet_plugin_robonomics/polkawallet_plugin_robonomics.dart';
import 'package:polkawallet_ui/components/v3/plugin/pluginItemCard.dart';

class MetaHubPanel extends StatelessWidget {
  MetaHubPanel(this.plugin);

  final PluginRobonomics plugin;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        child: Column(
          children: [
            GestureDetector(
              child: PluginItemCard(
                margin: EdgeInsets.only(bottom: 16),
                title: 'launch',
                describe: 'some some some, launch launch launch',
              ),
              onTap: () {
                Navigator.of(context).pushNamed(LaunchPage.route);
              },
            ),
            GestureDetector(
              child: PluginItemCard(
                margin: EdgeInsets.only(bottom: 16),
                title: 'datalog',
                describe: 'some some some, datalog datalog datalog',
              ),
              onTap: () {
                Navigator.of(context).pushNamed(DatalogPage.route);
              },
            ),
          ],
        ),
      );
    });
  }
}
