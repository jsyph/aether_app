import 'dart:convert';
import 'dart:developer';

import 'package:web_scraper/web_scraper.dart';

extension WebScraperUtils on WebScraper {
  /// Get `Map<String, dynamic>` from script variable
  Map<String, dynamic>? getMapFromScriptVariable(String variableName) {
    final elements = getScriptVariables([variableName]);

    if (elements[variableName] == null) {
      return null;
    }

    final scrapedString =
        elements[variableName].first.replaceAll('$variableName = ', '');
    final response = scrapedString.substring(0, scrapedString.length - 1);
    return jsonDecode(response);
  }

  String? getStringFromScriptVariable(String variableName) {
    final elements = getScriptVariables([variableName]);

    if (elements[variableName] == null) {
      return null;
    }

    final scrapedString =
        elements[variableName].first.replaceAll('$variableName = ', '');
    return scrapedString.substring(1, scrapedString.length - 2);
  }

  /// Get `List<Map<String, dynamic>>` from script variable
  List<Map<String, dynamic>>? getListOfMapFromScriptVariable(
      String variableName) {
    // if script fariable is not found, return null
    final scriptVariable = getScriptVariables([variableName]);

    if (scriptVariable[variableName] == null) {
      return null;
    }

    final scriptVariableAsString =
        scriptVariable[variableName].first.replaceAll('$variableName = ', '');
    final formattedScriptVariableAsString =
        scriptVariableAsString.substring(0, scriptVariableAsString.length - 1);

    log(formattedScriptVariableAsString.runtimeType.toString());

    return List<Map<String, dynamic>>.from(
      jsonDecode(formattedScriptVariableAsString),
    );
  }
}
