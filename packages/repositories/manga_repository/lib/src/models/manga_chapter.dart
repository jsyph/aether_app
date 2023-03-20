class MangaChapter {
  MangaChapter(
    this.title,
    this.url,
    this.number,
    this.dateReleased,
    this.sourceName,
  );

  final DateTime dateReleased;
  final double? number;
  final String sourceName;
  final String title;
  final String url;

  @override
  String toString() {
    return '''
MangaChapter(
  title: $title,
  url: $url,
  number: $number,
  dateReleased: $dateReleased,
  sourceName: $sourceName,
),''';
  }
}
