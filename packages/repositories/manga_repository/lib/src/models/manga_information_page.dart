import 'models.dart';

/// houses the data for manga information page
/// contains manga information and all chapters
class MangaInformationPage {
  MangaInformationPage({
    required this.chapters,
    required this.information,
  });

  /// ```dart
  /// [
  ///   [
  ///     MangaChapter(String title, String url),
  ///     MangaChapter(String title, String url),
  ///   ],
  ///   [
  ///     MangaChapter(String title, String url),
  ///     MangaChapter(String title, String url),
  ///     MangaChapter(String title, String url),
  ///   ],
  /// ]
  /// ```
  final List<List<MangaChapter>> chapters;

  final List<MangaInformation> information;
}
