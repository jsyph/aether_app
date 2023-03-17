import 'package:manga_database/manga_database.dart';

import 'models/models.dart';

class MangaRepository {
  static LocalMangaDatabase? _nullableMangaDb;

  Future<void> exportAsJson(String path) async {}

  Future<void> loadFromRemote() async {}

  Future<List<MangaSearchResult>> fuzzySearch(String query) async {
    final fuzzySearchResults = await _mangaDb.fuzzyTitleSearch(query);

    List<MangaSearchResult> searchResults = [];
    for (final fuzzySearchResult in fuzzySearchResults) {
      searchResults.add(
        MangaSearchResult(
          // currently it sets the first title added to record as the title returned
          fuzzySearchResult.titles.first.title,
          fuzzySearchResult.coverImages.map((e) => e.url).toList(),
          fuzzySearchResult.rating.map((e) => e.rating).toList(),
          fuzzySearchResult.altTitles,
        ),
      );
    }

    return searchResults;
  }

  Future<MangaInformationPage> getMangaInformationPage(String mangaId) async {
    final searchResult = await _mangaDb.getMangaById(mangaId);

    List<MangaInformation> allMangaInformation = [];

    for (int i = 0; i < searchResult.titles.length; i++) {
      final mangaInformation = MangaInformation(
        altTitles: searchResult.altTitles,
        author: searchResult.author,
        contentType: MangaContentType.parse(
          searchResult.contentType.toString(),
        ),
        coverImageUrl: searchResult.coverImages[i].url,
        datePostedOn: searchResult.postedOn[i].postedOn,
        description: searchResult.descriptions[i].text,
        genres: searchResult.genres[i].genres,
        rating: searchResult.rating[i].rating,
        releaseStatus: MangaReleaseStatus.parse(
          searchResult.releaseStatus[i].status.toString(),
        ),
        sourceName: searchResult.titles[i].sourceName,
        title: searchResult.titles[i].title,
        url: searchResult.urls[i].url,
      );

      allMangaInformation.add(mangaInformation);

      
    }


  }

  static Future<MangaRepository> initialize() async {
    _nullableMangaDb = await LocalMangaDatabase.initialize();
    return MangaRepository();
  }

  static LocalMangaDatabase get _mangaDb => _nullableMangaDb!;
}
