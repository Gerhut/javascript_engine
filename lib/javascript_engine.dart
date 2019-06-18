import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class JavascriptEngine {
  static const MethodChannel _channel = const MethodChannel('javascript_engine');

  static Future<void> run(String script) async {
    await _channel.invokeMethod('run', script);
  }

  static Future<dynamic> get(String script) async {
    if (Platform.isIOS) {
      return _channel.invokeMethod('get', script);
    }
    if (Platform.isAndroid) {
      String jsonString = await _channel.invokeMethod('get', script);
      return jsonDecode(jsonString);
    }
    throw UnsupportedError('Unsupported system: ' + Platform.operatingSystem);
  }
}
