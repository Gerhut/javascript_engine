import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:javascript_engine/javascript_engine.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String DEFAULT_INPUT = 'she sells seashells by the seashore.';

  String _output = '';

  @override
  void initState() {
    super.initState();
    initNlpEngine();
  }

  Future<void> initNlpEngine() async {
    await JavascriptEngine.run(await rootBundle.loadString('assets/compromise.min.js'));
    await nlp(DEFAULT_INPUT);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> nlp(String text) async {
    setState(() { _output = 'Processing'; });

    String script = 'nlp(' + jsonEncode(text) + ').sentences().toFutureTense().out("text")';
    String output = (await JavascriptEngine.get(script)).toString();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _output = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Future Tense of ...'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: DEFAULT_INPUT,
              onFieldSubmitted: nlp,
            ),
            Text(_output),
          ],
        ),
      ),
    );
  }
}
