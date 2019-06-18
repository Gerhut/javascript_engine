package cn.org.sya.javascript_engine;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.content.Context;
import android.webkit.ValueCallback;
import android.webkit.WebView;

/** JavascriptEnginePlugin */
public class JavascriptEnginePlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "javascript_engine");
    channel.setMethodCallHandler(new JavascriptEnginePlugin(registrar.context()));
  }

  private WebView webView;

  private JavascriptEnginePlugin(Context context) {
    super();
    this.webView = new WebView(context);
    this.webView.getSettings().setJavaScriptEnabled(true);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("run")) {
      this.webView.evaluateJavascript((String)call.arguments, new VoidCallback(result));
    } else if (call.method.equals("get")) {
      this.webView.evaluateJavascript((String)call.arguments, new StringCallback(result));
    } else {
      result.notImplemented();
    }
  }

  class VoidCallback implements ValueCallback<String> {
    private Result result;
    private VoidCallback(Result result) {
      this.result = result;
    }

    @Override
    public void onReceiveValue(String value) {
      result.success(null);
    }
  }

  class StringCallback implements ValueCallback<String> {
    private Result result;
    private StringCallback(Result result) {
      this.result = result;
    }

    @Override
    public void onReceiveValue(String value) {
      result.success(value);
    }
  }
}
