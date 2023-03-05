# Local manga database to store manga from multiple sources

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
    'Asura Scans',
    ['Solo Leveling', 'Na Honjaman Lebel-eob', 'Only I Level Up'],
    '''...''',
    ['Action', 'Adventure', 'Fantasy', 'Shounen'],
    10,
    'https://www.asurascans.com/manga/1672760368-solo-leveling/',
    'https://www.asurascans.com.../soloLevelingCover02.png',
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
