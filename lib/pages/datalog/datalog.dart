import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_robonomics/polkawallet_plugin_robonomics.dart';
import 'package:polkawallet_ui/components/txButton.dart';
import 'package:polkawallet_ui/components/v3/back.dart';

class DatalogPage extends StatefulWidget {
  static const String route = '/robonomics/datalog';

  DatalogPage(this.pluginRobonomics, {Key? key}) : super(key: key);

  final PluginRobonomics pluginRobonomics;

  @override
  State<DatalogPage> createState() => _DatalogPageState();
}

class _DatalogPageState extends State<DatalogPage> {
  String _recordValue = '';
  bool hasError = false;

  String? get _errorValue => hasError ? 'Record is empty' : null;

  @override
  void initState() {
    super.initState();
  }

  void onRecordChanged(String value) {
    _recordValue = value;
    validate();
  }

  void onFocusChanged(bool hasFocus) {
    if (!hasFocus) {
      validate();
    }
  }

  void validate() {
    setState(() {
      hasError = _recordValue.isEmpty;
    });
  }

  Future<void> read() async {
    final address =
        widget.pluginRobonomics.service.staking.keyring.current.address;
    final dynamic indexInRing =
        await widget.pluginRobonomics.sdk.api.service.webView!.evalJavascript(
      'api.query.datalog.datalogIndex($address)',
    );
//=> {start, end}
// {
//   start: 31
//   end: 30
// }

    final index = 1;
    final dynamic datalogItem =
        await widget.pluginRobonomics.sdk.api.service.webView!.evalJavascript(
      'api.query.datalog.datalogItem($address,$index)',
    );
//=> [timestamp(int),data(json)]
// [
//   1642583340411
//   {'type': 'KEEP_ALIVE', 'state': 'COMPLETE', 'power': {'activeW': 17, 'activeDeltaW': 0, 'reactiveVar': 14, 'reactiveDeltaVar': 0, 'apparentVa': 27}, 'currentA': 0.118, 'voltageV': 227.735, 'phaseDeg': 40.7, 'energyConsumptionWh': 1096329, 'energyConsumptionDeltaWh': 0, 'timestamp': '2022-01-19T08:56:34Z', 'eventId': 1050068, 'protocolVersion': 2, 'activePowerProd': 17, 'energyProd': 1094726, 'energyProdDelta': 0, 'activePowerCons': 0, 'energyCons': 1602, 'energyConsDelta': 0}
// ]
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datalog'),
        centerTitle: true,
        leading: BackBtn(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Focus(
          onFocusChange: onFocusChanged,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CupertinoTextField(
                placeholder: 'Record',
                onChanged: onRecordChanged,
              ),
              const SizedBox(height: 4),
              Text(
                _errorValue ?? '',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Theme.of(context).errorColor),
              ),
              const SizedBox(height: 16),
              TxButton(
                getTxParams: () async {
                  validate();
                  if (hasError) {
                    return null;
                  }
                  return TxConfirmParams(
                    txTitle: 'Datalog',
                    module: 'datalog',
                    call: 'record',
                    params: [_recordValue],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
