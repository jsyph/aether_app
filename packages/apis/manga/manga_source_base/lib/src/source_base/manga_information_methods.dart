import 'package:html/dom.dart';

import 'models/models.dart';

/// This mixin houses the code required to extract manga information. It exists to decrease the length on the MangaSourceBase abstract class
abstract class MangaInformationAbstractMethods {
  /// should return null if not supported
  List<String>? mangaInfoExtractAltTitles(Document parsedDocument);

  String? mangaInfoExtractAuthor(Document parsedDocument);

  MangaContentType? mangaInfoExtractContentType(Document parsedDocument);

  String mangaInfoExtractCoverImageUrl(Document parsedDocument);

  /// returns null if not supported
  DateTime? mangaInfoExtractDateReleasedOn(Document parsedDocument);

  String mangaInfoExtractDescription(Document parsedDocument);

  List<String> mangaInfoExtractGenres(Document parsedDocument);

  double mangaInfoExtractRating(Document parsedDocument);

  MangaReleaseStatus mangaInfoExtractStatus(Document parsedDocument);

  String mangaInfoExtractTitle(Document parsedDocument);
}
