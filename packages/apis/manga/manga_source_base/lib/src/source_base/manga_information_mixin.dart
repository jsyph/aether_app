import 'package:html/dom.dart';

import 'models/models.dart';

/// This mixin houses the code required to extract manga information. It exists to decrease the length on the MangaSourceBase abstract class
mixin MangaInformationMixin {
  MangaInformation extractMangaInformation(Document parsedDocument) {
    // ─────────────────────────────────────────────────────────────

    // title element should not be null
    final title = mangaInfoExtractTitle(parsedDocument).trim();

    // ─────────────────────────────────────────────────────────────

    List<String>? unTrimmedAltTitles =
        mangaInfoExtractAltTitles(parsedDocument);

    late final List<String>? altTitles;
    if (unTrimmedAltTitles != null) {
      altTitles = unTrimmedAltTitles.map((e) => e.trim()).toList();
    } else {
      altTitles = null;
    }

    // ─────────────────────────────────────────────────────────────

    final rating = mangaInfoExtractRating(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    final status = mangaInfoExtractStatus(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    final genres = mangaInfoExtractGenres(parsedDocument)
        .map(
          (e) => e.trim(),
        )
        .toList();

    // ─────────────────────────────────────────────────────────────

    final description = mangaInfoExtractDescription(parsedDocument).trim();

    // ─────────────────────────────────────────────────────────────

    final coverImageUrl = mangaInfoExtractCoverImageUrl(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    final unTrimmedAuthor = mangaInfoExtractAuthor(parsedDocument);
    late final String? author;
    if (unTrimmedAuthor != null) {
      author = unTrimmedAuthor.trim();
    } else {
      author = null;
    }
    // ─────────────────────────────────────────────────────────────

    final dateReleasedOn = mangaInfoExtractDateReleasedOn(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    final contentType = mangaInfoExtractContentType(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    return MangaInformation(
      title: title,
      altTitles: altTitles,
      description: description,
      genres: genres,
      rating: rating,
      coverImageUrl: coverImageUrl,
      releaseStatus: status,
      contentType: contentType,
      author: author,
      dateReleasedOn: dateReleasedOn,
    );
  }

  String mangaInfoExtractTitle(Document parsedDocument);

  /// should return null if not supported
  List<String>? mangaInfoExtractAltTitles(Document parsedDocument);

  double mangaInfoExtractRating(Document parsedDocument);

  MangaReleaseStatus mangaInfoExtractStatus(Document parsedDocument);

  List<String> mangaInfoExtractGenres(Document parsedDocument);

  String mangaInfoExtractDescription(Document parsedDocument);

  String mangaInfoExtractCoverImageUrl(Document parsedDocument);

  MangaContentType? mangaInfoExtractContentType(Document parsedDocument);

  String? mangaInfoExtractAuthor(Document parsedDocument);

  /// returns null if not supported
  DateTime? mangaInfoExtractDateReleasedOn(Document parsedDocument);
}
