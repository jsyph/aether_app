import 'models.dart';

/// Contains the record information for a source from a MangaDatabaseItem
class MangaDatabaseItemFilterResult {
  MangaDatabaseItemFilterResult({
    required this.altTitles,
    required this.author,
    required this.contentType,
    required this.coverImage,
    required this.description,
    required this.genres,
    required this.id,
    required this.postedOn,
    required this.rating,
    required this.releaseStatus,
    required this.sourceName,
    required this.title,
    required this.url,
  });

  final List<String>? altTitles;
  final String? author;
  final MangaDatabaseItemMangaType? contentType;
  final String coverImage;
  final String description;
  final List<String> genres;
  // id should never change
  final String id;

  final DateTime postedOn;
  final double rating;
  final MangaDatabaseReleaseStatus releaseStatus;
  final String sourceName;
  final String title;
  final String url;
}
