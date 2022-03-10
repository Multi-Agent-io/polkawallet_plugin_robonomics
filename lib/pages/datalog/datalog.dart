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
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).errorColor),
              ),
              const SizedBox(height: 16),
              TxButton(
                onFinish: (res) {
                  print(res);
                },
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
