// Has methods tht are only database specific
import 'package:manga_database/manga_database.dart';
import 'package:manga_sources/manga_sources.dart';

import 'models/models.dart';

class DatabaseFunctions {
  DatabaseFunctions(this.mangaDb);

  final LocalMangaDatabase mangaDb;

  Future<List<MangaSearchResult>> fuzzySearch(String query) async {
    final fuzzySearchResults = await mangaDb.fuzzyTitleSearch(query);

    List<MangaSearchResult> searchResults = [];
    for (final fuzzySearchResult in fuzzySearchResults) {
      searchResults.add(
        MangaSearchResult(
          // currently it sets the first title added to record as the title returned
          fuzzySearchResult.titles,
          fuzzySearchResult.coverImages,
          fuzzySearchResult.rating,
          fuzzySearchResult.altTitles,
        ),
      );
    }

    return searchResults;
  }

  Stream<MangaInformation> download() async* {
    final allMangaStream = AllMangaSources.getAllManga();

    await for (final mangaData in allMangaStream) {
      final mangaInformation = MangaInformation(
        altTitles: mangaData.info.altTitles,
        author: mangaData.info.author,
        contentType:
            MangaContentType.parse(mangaData.info.contentType.toString()),
        coverImageUrl: mangaData.info.coverImageUrl,
        datePostedOn: mangaData.info.datePostedOn,
        description: mangaData.info.description,
        genres: mangaData.info.genres,
        rating: mangaData.info.rating,
        releaseStatus:
            MangaReleaseStatus.parse(mangaData.info.releaseStatus.toString()),
        sourceName: mangaData.sourceName,
        title: mangaData.info.title,
        url: mangaData.info.url,
      );

      await mangaDb.addManga(
        sourceName: mangaInformation.sourceName,
        title: mangaInformation.title,
        altTitles: mangaInformation.altTitles,
        description: mangaInformation.description,
        genres: mangaInformation.genres,
        rating: mangaInformation.rating,
        url: mangaInformation.url,
        coverImageUrl: mangaInformation.coverImageUrl,
        contentType: mangaInformation.contentType.toString(),
        author: mangaInformation.author,
        datePostedOn: mangaInformation.datePostedOn,
        releaseStatus: mangaInformation.releaseStatus.toString(),
      );

      yield mangaInformation;
    }
  }

  Stream<MangaInformation> update() async* {
    for (final source in AllMangaSources.allSources) {
      final recentlyAddedMangaStream = source.getRecentlyAddedManga();

      await for (final recentlyManga in recentlyAddedMangaStream) {
        // check if the manga is already in the database
        final allTitles = [recentlyManga.title, ...?recentlyManga.altTitles];
        for (final title in allTitles) {
          final searchResult = await mangaDb.exactTitleSearch(title);

          // if manga is not found then add it
          if (searchResult == null) {
            mangaDb.addManga(
              sourceName: source.toString(),
              title: recentlyManga.title,
              altTitles: recentlyManga.altTitles,
              description: recentlyManga.description,
              genres: recentlyManga.genres,
              rating: recentlyManga.rating,
              url: recentlyManga.url,
              coverImageUrl: recentlyManga.coverImageUrl,
              contentType: recentlyManga.contentType?.toString(),
              author: recentlyManga.author,
              datePostedOn: recentlyManga.datePostedOn,
              releaseStatus: recentlyManga.releaseStatus.toString(),
            );

            yield MangaInformation(
              altTitles: recentlyManga.altTitles,
              author: recentlyManga.author,
              contentType:
                  MangaContentType.parse(recentlyManga.contentType.toString()),
              coverImageUrl: recentlyManga.coverImageUrl,
              datePostedOn: recentlyManga.datePostedOn,
              description: recentlyManga.description,
              genres: recentlyManga.genres,
              rating: recentlyManga.rating,
              releaseStatus: MangaReleaseStatus.parse(
                  recentlyManga.releaseStatus.toString()),
              sourceName: source.toString(),
              title: title,
              url: recentlyManga.url,
            );
          }

          // if manga is in database already, then break
          break;
        }
        // break to exit loop
        break;
      }
    }
  }

  // TODO: CREATE EXPORT AS JSON FUNCTION
  Future<void> exportAsJson(String path) async {}

// TODO: CREATE LOAD FROM REMOTE FUNCTION
  Future<void> loadFromRemote() async {}
}
