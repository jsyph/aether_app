import 'package:app_logging/app_logging.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../html_extension.dart';
import '../source_base/source_base.dart';

abstract class MangaStreamTemplate extends MangaSourceBase {
  @override
  Future<List<String>> getAllMangaUrls() async {
    final response =
        await dioClient.getUri(baseUri.resolve('/manga/list-mode/'));

    final document = parse(response.data);

    final allAElements = document.querySelectorAll('li > a.series');

    final allLinks = allAElements
        .map(
          (e) => e.attributes['href']!,
        )
        .toList();
    return allLinks;
  }

  @override
  Stream<MangaInformation> getRecentlyAddedManga() async* {
    int pageCount = 1;
    while (true) {
      final response = await dioClient.getUri(
        baseUri.resolve(
          '/manga/?status=&type=&order=latest&page=$pageCount',
        ),
      );

      final parsedDocument = parse(response.data);

      final allUrlElements = parsedDocument.querySelectorAll('div.bsx > a');

      final allUrls = allUrlElements.map((e) => e.attributes['href']!);

      for (final url in allUrls) {
        AppLogger().d('getting info on $url');
        final urlResponse = await dioClient.get(url);

        final urlParsedDocuments = parse(urlResponse.data);

        yield processMangaInformation(urlParsedDocuments, url);
      }

      // check if has next button
      final nextButton = parsedDocument.querySelector('div.hpage > a.r');

      // the next button is not found
      if (nextButton == null) {
        break;
      }

      pageCount++;
    }
  }

  @override
  DateFormat get mangaChapterDateFormat => DateFormat('MMMM MM, yyyy');

  @override
  String get mangaChapterDateSelector =>
      'div#chapterlist > ul > li > div > div > a > span.chapterdate';

  @override
  String mangaChapterExtractChapterDate(Element element) => element.text;

  @override
  String? mangaChapterExtractChapterNumber(Element element) {
    final dataNum = element.attributes['data-num'];
    if (dataNum == null) {
      return null;
    }

    // check if data-num contains `-`
    if (dataNum.contains('-')) {
      final splitDataNum = dataNum.split(' - ');
      return splitDataNum.first.trim();
    }

    return dataNum;
  }

  @override
  String get mangaChapterNumberSelector => 'div#chapterlist > ul > li';

  @override
  String get mangaChapterTitleSelector =>
      'div#chapterlist > ul > li > div > div > a > span.chapternum';

  @override
  String get mangaChapterUrlSelector =>
      'div#chapterlist > ul > li > div > div > a';

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

    // because rating is out of 10 and should be out of 5
    final unFormattedDouble = unDividedDouble / 2.0;

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
