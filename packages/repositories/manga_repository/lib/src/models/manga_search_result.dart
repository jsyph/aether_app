class MangaSearchResult {
  MangaSearchResult(
    this.title,
    this.coverUrl,
    this.rating,
    this.altTitles,
  );

  final List<String>? altTitles;
  final List<String> coverUrl;
  final List<double> rating;
  final String title;
}
