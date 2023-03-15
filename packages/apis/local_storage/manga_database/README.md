# Local manga database to store manga from multiple sources

## TODO:
- add manga releasedOn

## Docs
```dart
// Initialize using:
final mangaDb = await LocalMangaDatabase.initialize();
```

```dart
// Get manga by id
await mangaDb.getMangaById('4a67344c-3264-4fa1-a5a6-a673793536bd');
```

```dart
// Delete Manga
await mangaDb.deleteManga('4a67344c-3264-4fa1-a5a6-a673793536bd');
```

```dart
// Add Manga
await mangaDb.addManga(
            sourceName: 'Asura Scans',
            titles: [
              'Solo Leveling',
              'Na Honjaman Lebel-eob',
              'Only I Level Up'
            ],
            description:
                '''...''',
            genres: ['Action', 'Adventure', 'Fantasy', 'Shounen'],
            rating: 10,
            url: 'https://www.asurascans.com/manga/1672760368-solo-leveling/',
            coverImageUrl:
                'https://www.asurascans.com/.../soloLevelingCover02.png',
          );
```

```dart
// Search for exact title
await mangaDb.exactTitleSearch('Solo Leveling');
```

```dart
// Fuzzy Search for titles
await mangaDb.fuzzyTitleSearch('Solo');
```

```dart
// Returns a manga dump of all manga in database
await mangaDb.allManga();
```
