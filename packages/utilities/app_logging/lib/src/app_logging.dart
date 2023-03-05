import 'package:logger/logger.dart';

/// App wide logger
class AppLogger extends Logger {
  static final AppLogger _singleton = AppLogger._internal();

  factory AppLogger() {
    return _singleton;
  }

  AppLogger._internal();

  void setLogLevel(Level level) {
    Logger.level = level;
  }
}
