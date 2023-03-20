import 'package:manga_source_base/manga_source_base.dart';

/// Contains manga info and source name
class MangaData {
  MangaData(this.sourceName, this.info);

  final MangaInformation info;
  final String sourceName;
}
