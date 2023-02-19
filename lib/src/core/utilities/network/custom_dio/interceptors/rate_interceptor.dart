import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Limits the number of requests sent by the dio client
/// `allowedRequests` is the number of requests per `perTime` in seconds
class RateInterceptor extends Interceptor {
  RateInterceptor(this.timeBetweenRequestsInSeconds);

  final logger = Logger();
  /// The number of requests allowed
  final int timeBetweenRequestsInSeconds;

  // The value of milliSecondsSinceEpoch of the previous request
  // persists accross all instances created
  static int? _previousRequestTimeTag;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if _previousRequestTimeTag is null, asign it, then leave intercepter
    if (_previousRequestTimeTag == null) {
      logger.v('_previousRequestTimeTag is null');
      _previousRequestTimeTag = DateTime.now().millisecondsSinceEpoch;
      return handler.next(options);
    }

    final currentTimeTag = DateTime.now().millisecondsSinceEpoch;
    logger.d('currentTimeTag=$currentTimeTag');

    logger.d('_previousRequestTimeTag=$_previousRequestTimeTag');

    // Calculate time epased between the 2 time tags
    final timeElapsed = currentTimeTag - _previousRequestTimeTag!;
    logger.d('timeElapsed=$timeElapsed');

    // Multiply timeBetweenRequestsInSeconds to convert it to milliseconds
    final timeBetweenRequestsInMilliSeconds =
        timeBetweenRequestsInSeconds * 1000;
    logger.d('timeBetweenRequestsInMilliSeconds=$timeBetweenRequestsInMilliSeconds');

    // If timeElapsed is greater than the timeBetweenRequestsInMilliSeconds, then exit Interceptor,
    if (timeElapsed > timeBetweenRequestsInMilliSeconds) {
      logger.d('timeElapsed is greater than timeBetweenRequestsInMilliSeconds');

      // set _previousRequestTimeTag to now
      _previousRequestTimeTag = DateTime.now().millisecondsSinceEpoch;

      return handler.next(options);

      // else then wait until sufficnt time has passed
    } else {
      // get diffrence between timeBetweenRequestsInMilliSeconds and timeElapsed, to get the time to wait in milliseconds
      final timeDiffrence = timeBetweenRequestsInMilliSeconds - timeElapsed;
      logger.d('timeDiffrence=$timeDiffrence');

      // wait timeDiffrence then exit Interceptor
      logger.v('Waiting for future to complete');
      return await Future.delayed(
        Duration(milliseconds: timeDiffrence),
        () {
          // set _previousRequestTimeTag to now, after future has been waited
          _previousRequestTimeTag = DateTime.now().millisecondsSinceEpoch;

          return handler.next(options);
        },
      );
    }
  }
}
