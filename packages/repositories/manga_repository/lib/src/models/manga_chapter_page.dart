import 'models.dart';

class MangaChapterPage {
  MangaChapterPage(
    this.nextChapterIndex,
    this.previousChapterIndex,
    this.imageUrls,
    this.currentSourceChapterData,
    this.otherSourceCurrentChapters,
  );

  /// the current chapter data for a specific source
  final MangaChapter currentSourceChapterData;

  /// List of chapter images
  final List<String> imageUrls;

  /// The index of the next chapter
  final int? nextChapterIndex;

  /// list of manga chapters for same chapter but other sources
  final List<MangaChapter> otherSourceCurrentChapters;

  /// index of previous chapter
  final int? previousChapterIndex;
}
