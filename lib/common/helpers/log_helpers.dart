/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2024-12-22 08:28:54
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';

class LogHelper {
  static const String _prefix = "";

  /// ANSI color codes for better log readability
  static const String _colorDebug = "\x1B[36m"; // Cyan
  static const String _colorInfo = "\x1B[34m"; // Blue
  static const String _colorWarning = "\x1B[33m"; // Yellow
  static const String _colorError = "\x1B[31m"; // Red
  static const String _colorReset = "\x1B[0m"; // Reset color

  static void debug({String tag = "DEBUG", required dynamic message}) =>
      _log("DEBUG", tag, message, _colorDebug);

  static void info({String tag = "INFO", required dynamic message}) =>
      _log("ℹINFO", tag, message, _colorInfo);

  static void warning({String tag = "WARNING", required dynamic message}) =>
      _log("WARNING", tag, message, _colorWarning);

  static void error({
    required String tag,
    required dynamic message,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _log("ERROR", tag, message, _colorError);
    if (kDebugMode && error != null) {
      print("$_colorError$_prefix [ERROR] $tag: $error$_colorReset");
    }
    if (kDebugMode && stackTrace != null) {
      print("$_colorError$_prefix [STACKTRACE] $tag:\n$stackTrace$_colorReset");
    }
  }

  static void _log(String level, String tag, dynamic message, String color) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      print(
        "$color$_prefix [$level] [$timestamp] $tag: ${message.toString()}$_colorReset",
      );
    }
  }
}
