#import "JavascriptEnginePlugin.h"

#import <JavaScriptCore/JSContext.h>
#import <JavaScriptCore/JSVirtualMachine.h>
#import <JavaScriptCore/JSValue.h>

@implementation JavascriptEnginePlugin {
  JSVirtualMachine* _virtualMachine;
  JSContext* _context;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"javascript_engine"
            binaryMessenger:[registrar messenger]];
  JavascriptEnginePlugin* instance = [[JavascriptEnginePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _virtualMachine = [[JSVirtualMachine alloc] init];
    _context = [[JSContext alloc] initWithVirtualMachine:_virtualMachine];
  }
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"run" isEqualToString:call.method]) {
    [_context evaluateScript:call.arguments];
    result(nil);
  } else if ([@"get" isEqualToString:call.method]) {
    JSValue* value = [_context evaluateScript:call.arguments];
    if ([value isNull] || [value isUndefined]) {
      result(nil);
    } else if ([value isBoolean]) {
      result([NSNumber numberWithBool:[value toBool]]);
    } else if ([value isNumber]) {
      result([value toNumber]);
    } else if ([value isString]) {
      result([value toString]);
    } else if ([value isObject]) {
      result([value toObject]);
    } else {
      result([FlutterError errorWithCode:@"UNSUPPORTED_TYPE" message:@"Upsupported type" details:value]);
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
