import 'package:app_logging/app_logging.dart';
import 'package:html/dom.dart';

import '../html_extension.dart';
import '../source_base/source_base.dart';

abstract class MangaStreamTemplate extends MangaSourceBase {
  @override
  List<String>? mangaInfoExtractAltTitles(Document parsedDocument) {
    final element =
        parsedDocument.querySelector('div.infox > div.wd-full > span');

    if (element == null) {
      return null;
    }

    if (element.querySelector('a') != null) {
      return null;
    }
    
    final altTitlesText = element.text;
    return altTitlesText
        .split(',')
        .map(
          (e) => e.trim(),
        )
        .toList();
  }

  @override
  String? mangaInfoExtractAuthor(Document parsedDocument) {
    final authorElement =
        parsedDocument.querySelectorAll('div.flex-wrap > div > span')[1];

    if (authorElement.text == ' - ') {
      return null;
    }

    return authorElement.text;
  }

  @override
  MangaContentType? mangaInfoExtractContentType(Document parsedDocument) {
    final contentTypeElement = parsedDocument.querySelector('div.imptdt > a');

    if (contentTypeElement == null) {
      return null;
    }

    return MangaContentType.parse(contentTypeElement.text);
  }

  @override
  String mangaInfoExtractCoverImageUrl(Document parsedDocument) {
    final coverUrlElement =
        parsedDocument.querySelector('img.attachment-.size-.wp-post-image');

    return coverUrlElement!.attributes['src']!;
  }

  @override
  DateTime? mangaInfoExtractDateReleasedOn(Document parsedDocument) {
    final dateReleasedText = parsedDocument.getQueryAttribute(
      'div > div > span > time',
      'datetime',
    );

    return DateTime.parse(dateReleasedText!);
  }

  @override
  String mangaInfoExtractDescription(Document parsedDocument) {
    final descriptionElement =
        parsedDocument.querySelector('div.entry-content.entry-content-single');

    return descriptionElement!.text;
  }

  @override
  List<String> mangaInfoExtractGenres(Document parsedDocument) {
    final genres = parsedDocument.querySelectorAll('span.mgen > a');

    return genres.map((element) => element.text).toList();
  }

  @override
  double mangaInfoExtractRating(Document parsedDocument) {
    final ratingElement = parsedDocument.querySelector('div.num');

    final ratingAsString = ratingElement!.text;

    final unDividedDouble = double.parse(ratingAsString);

    final unFormattedDouble = unDividedDouble / 10.0;

    final formattedDouble = double.parse(unFormattedDouble.toStringAsFixed(1));

    return formattedDouble;
  }

  @override
  MangaReleaseStatus mangaInfoExtractStatus(Document parsedDocument) {
    final statusElement = parsedDocument.querySelector('div.imptdt > i');

    return MangaReleaseStatus.parse(statusElement!.text);
  }

  @override
  String mangaInfoExtractTitle(Document parsedDocument) {
    final titleElement = parsedDocument.querySelector('div.infox > h1');

    return titleElement!.text;
  }
}
