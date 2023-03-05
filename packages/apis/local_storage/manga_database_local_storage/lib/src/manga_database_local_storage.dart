import 'package:hive/hive.dart';
import 'package:woozy_search/woozy_search.dart';
import 'package:app_logging/app_logging.dart';

import 'models/models.dart';

const _databaseName = 'manga_database';

/// Class where all the manga database ✨MAGIC happens
class LocalMangaDatabase {
  LocalMangaDatabase._initialize();

  static LazyBox<MangaDatabaseItem>? _lazyDatabase;
  static final _logger = AppLogger();

  /// Public factory
  static Future<LocalMangaDatabase> initialize() async {
    _logger
        .i('Does manga database exist: ${await Hive.boxExists(_databaseName)}');
    _lazyDatabase = await Hive.openLazyBox(_databaseName);

    return LocalMangaDatabase._initialize();
  }

  /// Gets manga by id
  Future<MangaDatabaseItem> getMangaById(String id) async {
    // all keys in database
    final allKeys = _lazyDatabase!.keys;

    for (final key in allKeys) {
      // parse key into class
      final parsedKey = _MangaDatabaseItemKey.parse(key);

      if (parsedKey.id == id) {
        final associatedMangaDatabaseItem = await _lazyDatabase!.get(key);
        return associatedMangaDatabaseItem!;
      }
    }

    _logger.wtf('$id in not found in database');
    throw MangaDatabaseError('$id is not found in database');
  }

  /// Add manga to database, if it exists then append to it, else creates a new entry
  Future<MangaDatabaseItem> addManga(
    String sourceName,
    List<String> titles,
    String description,
    List<String> genres,
    double rating,
    String url,
    String coverImageUrl,
  ) async {
    _logger.d(titles);
    // Check if manga already in database
    for (final title in titles) {
      _logger.d(title);
      final possibleMangaEntry = await exactTitleSearch(title);

      _logger.i('addManga: possibleMangaEntry=$possibleMangaEntry');
      // if a possible manga entry is found, then add to it and save
      if (possibleMangaEntry != null) {
        // old manga entry key
        final oldMangaEntryKey = _MangaDatabaseItemKey(
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
        await _lazyDatabase!.delete(
          oldMangaEntryKey,
        );

        // create new record, with new key
        final newEntryKey = _MangaDatabaseItemKey(
          possibleMangaEntry.id,
          possibleMangaEntry.allTitles,
        ).toString();

        await _lazyDatabase!.put(newEntryKey, possibleMangaEntry);

        _logger.d('$possibleMangaEntry');

        return possibleMangaEntry;
      }
    }

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
        _MangaDatabaseItemKey(newMangaDatabaseItem.id, titles).toString();
    await _lazyDatabase!.put(
      entryKey,
      newMangaDatabaseItem,
    );

    _logger.d('${await _lazyDatabase!.get(entryKey)}');

    return newMangaDatabaseItem;
  }

  /// Gets MangaDatabaseItem that belongs to title, if not found then returns null
  Future<MangaDatabaseItem?> exactTitleSearch(String title) async {
    // all keys in database
    final allKeys = _lazyDatabase!.keys;
    _logger.d(allKeys);

    for (final key in allKeys) {
      // parse key into class
      final parsedKey = _MangaDatabaseItemKey.parse(key);
      // if title is in the parsed keys titles, then return the the value from database
      _logger.d(
        'parsedKey.titles.contains(title)=${parsedKey.titles.contains(title)}',
      );
      if (parsedKey.titles.contains(title)) {
        _logger
            .d('Does the key, $key, exist? ${_lazyDatabase!.containsKey(key)}');
        final associatedMangaDatabaseItem = await _lazyDatabase!.get(key);
        return associatedMangaDatabaseItem!;
      }
    }

    return null;
  }

  /// Search for title in database using a fuzzy search algorithm
  Future<List<MangaDatabaseItem>> fuzzyTitleSearch(String title) async {
    // all keys in database
    final allKeys = _lazyDatabase!.keys;

    final woozy = Woozy<String>();

    for (final key in allKeys) {
      // parse key into class
      final parsedKey = _MangaDatabaseItemKey.parse(key);

      // add all titles one by one into woozy for the current parsed key
      for (int k = 0; k < parsedKey.titles.length; k++) {
        final currentTitle = parsedKey.titles[k];
        // add title with the current key as their value
        woozy.addEntry(currentTitle, value: key);
      }
    }

    final fuzzySearchResults = woozy.search(title);

    // get all manga database items from their keys
    List<MangaDatabaseItem> searchResults = [];

    for (final fuzzySearchResult in fuzzySearchResults) {
      final fuzzySearchResultValue = fuzzySearchResult.value!;
      final associatedMangaDatabaseItem =
          await _lazyDatabase!.get(fuzzySearchResultValue);
      searchResults.add(associatedMangaDatabaseItem!);
    }

    // remove duplicates search results
    // https://stackoverflow.com/a/51446910/14928208
    searchResults = searchResults.toSet().toList();

    return searchResults;
  }

  // Future<MangaDatabaseItem> getById(String id) {}
}

/// How a manga database item key looks:
///
/// `4a67344c-3264-4fa1-a5a6-a673793536bd|Solo Leveling_Na Honjaman Lebel-eob_Only I Level Up`
///
/// `+----------------------------------+` `+-------------------------------------------------+`
///
///                   id ⬆                                      titles ⬆
class _MangaDatabaseItemKey {
  _MangaDatabaseItemKey(this.id, this.titles);

  factory _MangaDatabaseItemKey.parse(String rawString) {
    final splitRawString = rawString.split('|');
    final id = splitRawString.first;
    final titles = splitRawString.last.split('_');
    return _MangaDatabaseItemKey(id, titles);
  }

  final String id;
  final List<String> titles;

  @override
  String toString() {
    return '$id|${titles.join('_')}';
  }
}

class MangaDatabaseError extends Error {
  MangaDatabaseError(this.error);

  final String error;
}
