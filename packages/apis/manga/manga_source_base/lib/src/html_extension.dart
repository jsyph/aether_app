import 'package:app_logging/app_logging.dart';
import 'package:html/dom.dart';

extension HtmlDocumentUtilities on Document {
  /// Get element using query, and get a specific attribute
  String? getQueryAttribute(String query, String attribute) {
    final element = querySelector(query);

    if (element == null) {
      return null;
    }

    final requestedAttribute = element.attributes[attribute];

    if (requestedAttribute == null) {
      return null;
    }

    return requestedAttribute;
  }
}
