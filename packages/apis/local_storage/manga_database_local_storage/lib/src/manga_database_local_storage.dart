import 'package:hive/hive.dart';
import 'package:woozy_search/woozy_search.dart';
import 'package:app_logging/app_logging.dart';

import 'manga_database_error.dart';
import 'manga_database_item_key.dart';
import 'models/models.dart';

const _databaseName = 'manga_database';

/// Class where all the manga database ✨MAGIC happens
class LocalMangaDatabase {
  LocalMangaDatabase._initialize();

  static final _logger = AppLogger();
  // _nullableLazyDatabase is null if accessed without the class being initialized
  static LazyBox<MangaDatabaseItem>? _nullableLazyDatabase;

  /// Public factory
  static Future<LocalMangaDatabase> initialize() async {
    _logger
        .i('Does manga database exist: ${await Hive.boxExists(_databaseName)}');
    _nullableLazyDatabase = await Hive.openLazyBox(_databaseName);

    return LocalMangaDatabase._initialize();
  }

  /// Gets manga by id
  Future<MangaDatabaseItem> getMangaById(String id) async {
    // all keys in database
    final allKeys = _database.keys;

    for (final key in allKeys) {
      // parse key into class
      final parsedKey = MangaDatabaseItemKey.parse(key);

      if (parsedKey.id == id) {
        final associatedMangaDatabaseItem = await _database.get(key);
        return associatedMangaDatabaseItem!;
      }
    }

    _logger.wtf('$id in not found in database');
    throw MangaDatabaseError('$id is not found in database');
  }

  /// Delete manga record using id
  Future<void> deleteManga(String id) async {
    final allKeys = _database.keys;

    for (final key in allKeys) {
      final parsedKey = MangaDatabaseItemKey.parse(key);

      if (parsedKey.id == id) {
        return await _database.delete(key);
      }
    }
  }

  /// Add manga to database, if it exists then append to it, else creates a new entry
  Future<MangaDatabaseItem> addManga({
    required String sourceName,
    required List<String> titles,
    required String description,
    required List<String> genres,
    required double rating,
    required String url,
    required String coverImageUrl,
  }) async {
    // Check if manga already in database
    for (final title in titles) {
      final possibleMangaEntry = await exactTitleSearch(title);

      // if a possible manga entry is found, then add to it and save
      if (possibleMangaEntry != null) {
        // old manga entry key
        final oldMangaEntryKey = MangaDatabaseItemKey(
          possibleMangaEntry.id,
          possibleMangaEntry.allTitles,
        ).toString();

        possibleMangaEntry.addData(
          sourceName,
          coverImageUrl,
          description,
          genres,
          rating,
          titles,
          url,
        );

        // delete old record
        _logger.i('Deleting old record');
        await _database.delete(
          oldMangaEntryKey,
        );

        // create new record, with new key
        final newEntryKey = MangaDatabaseItemKey(
          possibleMangaEntry.id,
          possibleMangaEntry.allTitles,
        ).toString();

        _logger.i('Updated Manga Entry: $possibleMangaEntry');

        await _database.put(newEntryKey, possibleMangaEntry);

        return possibleMangaEntry;
      }
    }

    // if manga is not found, then create a new record

    final newMangaDatabaseItem = MangaDatabaseItem.empty()
      ..addData(
        sourceName,
        coverImageUrl,
        description,
        genres,
        rating,
        titles,
        url,
      );

    _logger.i('Created new manga entry: $newMangaDatabaseItem');

    // Put data at key
    final entryKey =
        MangaDatabaseItemKey(newMangaDatabaseItem.id, titles).toString();
    await _database.put(
      entryKey,
      newMangaDatabaseItem,
    );

    return newMangaDatabaseItem;
  }

  /// Gets MangaDatabaseItem that belongs to title, if not found then returns null
  Future<MangaDatabaseItem?> exactTitleSearch(String title) async {
    // all keys in database
    final allKeys = _database.keys;

    for (final key in allKeys) {
      // parse key into class
      final parsedKey = MangaDatabaseItemKey.parse(key);
      // if title is in the parsed keys titles, then return the the value from database

      if (parsedKey.titles.contains(title)) {
        final associatedMangaDatabaseItem = await _database.get(key);
        return associatedMangaDatabaseItem!;
      }
    }

    return null;
  }

  /// Search for title in database using a fuzzy search algorithm
  Future<List<MangaDatabaseItem>> fuzzyTitleSearch(String title) async {
    // all keys in database
    final allKeys = _database.keys;

    final woozy = Woozy<String>();

    // add all keys into woozy entries
    for (final key in allKeys) {
      // parse key into class
      final parsedKey = MangaDatabaseItemKey.parse(key);

      // add all titles one by one into woozy for the current parsed key
      for (final title in parsedKey.titles) {
        // add title with the current key as their value
        woozy.addEntry(title, value: key);
      }
    }

    final fuzzySearchResults = woozy.search(title);

    // get all manga database items from their keys
    List<MangaDatabaseItem> searchResults = [];

    for (final fuzzySearchResult in fuzzySearchResults) {
      final fuzzySearchResultValue = fuzzySearchResult.value!;
      final associatedMangaDatabaseItem =
          await _database.get(fuzzySearchResultValue);
      searchResults.add(associatedMangaDatabaseItem!);
    }

    // remove duplicates search results
    // inspired by https://stackoverflow.com/a/58167140/14928208
    final ids = <dynamic>{};
    final uniqueSearchResults = searchResults
        .where(
          (element) => ids.add(element.id),
        )
        .toList();

    _logger.d(uniqueSearchResults);

    return uniqueSearchResults;
  }

  /// Returns all manga in database
  Future<List<MangaDatabaseItem>> allManga() async {
    final allKeys = _database.keys;

    List<MangaDatabaseItem> allManga = [];

    for (final key in allKeys) {
      final associatedMangaDatabaseItem = await _database.get(key);
      allManga.add(associatedMangaDatabaseItem!);
    }

    return allManga;
  }

  LazyBox<MangaDatabaseItem> get _database => _nullableLazyDatabase!;
}
