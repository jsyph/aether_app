import 'models.dart';

class MangaInformation {
  MangaInformation({
    required this.altTitles,
    required this.author,
    required this.contentType,
    required this.coverImageUrl,
    required this.datePostedOn,
    required this.description,
    required this.genres,
    required this.rating,
    required this.releaseStatus,
    required this.sourceName,
    required this.title,
    required this.url,
  });

  final List<String>? altTitles;
  final String? author;
  final MangaContentType? contentType;
  final String coverImageUrl;
  final DateTime? datePostedOn;
  final String description;
  final List<String> genres;
  final double rating;
  final MangaReleaseStatus releaseStatus;
  final String sourceName;
  final String title;
  final String url;

  @override
  String toString() {
    return '''
MangaInformation(
  altTitles: $altTitles,
  author: $author,
  contentType: $contentType,
  coverImageUrl: $coverImageUrl,
  datePostedOn: $datePostedOn,
  description: $description,
  genres: $genres,
  rating: $rating,
  releaseStatus: $releaseStatus,
  sourceName: $sourceName,
  title: $title,
  url: $url,
),
''';
  }
}
