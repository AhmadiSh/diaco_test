import 'package:logger/logger.dart';

class LoggerHelper {
  static final Logger logger = Logger(
    printer: PrefixPrinter(
      PrettyPrinter(
        methodCount: 10,
        printTime: true,
        printEmojis: true,
      ),
    ),
  );
  static void errorLog(dynamic exception, StackTrace stack) {
    logger.e(exception);

  }
}
