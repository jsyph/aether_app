import 'dart:async';

import 'package:dio/dio.dart';
import 'package:app_logging/app_logging.dart';

/// Limits the number of requests sent by the dio client
/// `allowedRequests` is the number of requests per `perTime` in seconds
class RateInterceptor extends Interceptor {
  RateInterceptor(this.duration);

  /// The number of requests allowed
  final Duration duration;

  // The value of milliSecondsSinceEpoch of the previous request
  // persists across all instances created
  static int? _previousRequestTimeTag;

  final _logger = AppLogger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // if _previousRequestTimeTag is null, assign it, then leave interceptor
    if (_previousRequestTimeTag == null) {
      _logger.v('_previousRequestTimeTag is null');
      _previousRequestTimeTag = DateTime.now().millisecondsSinceEpoch;
      return handler.next(options);
    }

    final currentTimeTag = DateTime.now().millisecondsSinceEpoch;
    _logger.d('currentTimeTag=$currentTimeTag');

    _logger.d('_previousRequestTimeTag=$_previousRequestTimeTag');

    // Calculate time elapsed between the 2 time tags
    final timeElapsed = currentTimeTag - _previousRequestTimeTag!;
    _logger.d('timeElapsed=$timeElapsed');

    final timeBetweenRequestsInMilliSeconds = duration.inMilliseconds;

    // If timeElapsed is greater than the timeBetweenRequestsInMilliSeconds, then exit Interceptor,
    if (timeElapsed > timeBetweenRequestsInMilliSeconds) {
      _logger
          .d('timeElapsed is greater than timeBetweenRequestsInMilliSeconds');

      // set _previousRequestTimeTag to now
      _previousRequestTimeTag = DateTime.now().millisecondsSinceEpoch;

      return handler.next(options);

      // else then wait until sufficient time has passed
    } else {
      // get difference between timeBetweenRequestsInMilliSeconds and timeElapsed, to get the time to wait in milliseconds
      final timeDifference = timeBetweenRequestsInMilliSeconds - timeElapsed;
      _logger.d('timeDifference=$timeDifference milliseconds');

      // wait timeDifference then exit Interceptor
      _logger.v('Starting timer');

      Timer(
        Duration(milliseconds: timeDifference),
        () {
          // set _previousRequestTimeTag to now, after future has been waited
          _previousRequestTimeTag = DateTime.now().millisecondsSinceEpoch;

          _logger.v('Timer finished');
          return handler.next(options);
        },
      );
    }
  }
}
