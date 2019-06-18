import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:javascript_engine/javascript_engine.dart';

void main() {
  const MethodChannel channel = MethodChannel('javascript_engine');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await JavascriptEngine.platformVersion, '42');
  });
}
