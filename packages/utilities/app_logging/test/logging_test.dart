import 'package:app_logging/app_logging.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Test Logging',
    () {
      test(
        'Check that logging instances are the same',
        () {
          final firstInstance = AppLogger();
          final secondInstance = AppLogger();
          expect(identical(firstInstance, secondInstance), isTrue);
        },
      );
    },
  );
}
