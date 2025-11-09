import 'package:logger/logger.dart';

/// Convenience Mixin allowing a class to access a logger instance.
mixin Loggable {
  Logger logger = Logger();
}
