import 'package:html/dom.dart';
import 'package:intl/intl.dart';

abstract class MangaChapterAbstractMethods {
  String? mangaChapterExtractChapterNumber(Element element);

  String get mangaChapterNumberSelector;

  String get mangaChapterUrlSelector;

  String get mangaChapterTitleSelector;

  String get mangaChapterDateSelector;

  String mangaChapterExtractChapterDate(Element element);

  DateFormat get mangaChapterDateFormat;
}
