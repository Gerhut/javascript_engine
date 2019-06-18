package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import cn.org.sya.javascript_engine.JavascriptEnginePlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    JavascriptEnginePlugin.registerWith(registry.registrarFor("cn.org.sya.javascript_engine.JavascriptEnginePlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
