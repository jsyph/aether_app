import 'models.dart';

/// houses the data for manga information page
/// contains manga information and all chapters
class MangaInformationPage {
  MangaInformationPage({
    required this.chapters,
    required this.information,
  });

  /// Is A matrix whose structure looks like this:
  /// ```dart
  /// [
  ///   ['mangaChapter1a', 'mangaChapter1b'],
  ///   ['mangaChapter2a', 'mangaChapter2b'],
  ///   ['mangaChapter3a', 'mangaChapter3b'],
  ///   ['mangaChapter4a', 'mangaChapter4b']
  /// ]
  /// ```
  final List<List<MangaChapter>> chapters;

  final List<MangaInformation> information;

  @override
  String toString() {
    return '''
MangaInformationPage(
  chapters: $chapters,
  information: $information,
),''';
  }
}
