import 'dart:io';
import 'package:hive/hive.dart';
import 'package:manga_database_local_storage/manga_database_local_storage.dart';
import 'package:test/test.dart';

void main() async {
  initHive();
  registerHiveAdapters();
  final mangaDb = await LocalMangaDatabase.initialize();

  final newMangaRecord = await mangaDb.addManga(
    sourceName: 'Asura Scans',
    titles: ['Solo Leveling', 'Na Honjaman Lebel-eob', 'Only I Level Up'],
    description:
        '''10 years ago, after “the Gate” that connected the real world with the monster world opened, some of the ordinary, everyday people received the power to hunt monsters within the Gate.
            They are known as “Hunters”. However, not all Hunters are powerful. My name is Sung Jin-Woo, an E-rank Hunter.
              I’m someone who has to risk his life in the lowliest of dungeons, the “World’s Weakest”. Having no skills whatsoever to display,
              I barely earned the required money by fighting in low-leveled dungeons… at least until I found a hidden dungeon with the hardest difficulty within the D-rank dungeons! 
              In the end, as I was accepting death, I suddenly received a strange power, a quest log that only I could see, a secret to leveling up that only I know about!
                If I trained in accordance with my quests and hunted monsters, my level would rise. Changing from the weakest Hunter to the strongest S-rank Hunter!''',
    genres: ['Action', 'Adventure', 'Fantasy', 'Shounen'],
    rating: 10,
    url: 'https://www.asurascans.com/manga/1672760368-solo-leveling/',
    coverImageUrl:
        'https://www.asurascans.com/wp-content/uploads/2021/03/soloLevelingCover02.png',
  );

  group(
    'Test local manga database',
    () {

      test(
        'Test fuzzyTitleSearch',
        () async {
          final searchResults = await mangaDb.fuzzyTitleSearch('Solo');

          // expect that search results have length 1
          expect(searchResults.length, equals(1));
        },
      );

      test(
        'Test getMangaById',
        () async {
          final retrievedMangaRecord =
              await mangaDb.getMangaById(newMangaRecord.id);

          // check that both record have same id
          expect(newMangaRecord.id, equals(retrievedMangaRecord.id));
        },
      );

      test(
        'Test exactTitleSearch',
        () async {
          final searchResult = await mangaDb.exactTitleSearch('Solo Leveling');

          expect(searchResult, isNotNull);
          expect(
              searchResult!.allTitles,
              equals([
                'Solo Leveling',
                'Na Honjaman Lebel-eob',
                'Only I Level Up'
              ]));
        },
      );

      test(
        'Test addManga',
        () async {
          final secondDatabaseItem = await mangaDb.addManga(
            sourceName: 'Flame Scans',
            titles: [
              'Solo Leveling',
              'Na Honjaman Lebel-eob',
              'Only I Level Up'
            ],
            description:
                '''10 years ago, after “the Gate” that connected the real world with the monster world opened, some of the ordinary, everyday people received the power to hunt monsters within the Gate.
            They are known as “Hunters”. However, not all Hunters are powerful. My name is Sung Jin-Woo, an E-rank Hunter.
              I’m someone who has to risk his life in the lowliest of dungeons, the “World’s Weakest”. Having no skills whatsoever to display,
              I barely earned the required money by fighting in low-leveled dungeons… at least until I found a hidden dungeon with the hardest difficulty within the D-rank dungeons! 
              In the end, as I was accepting death, I suddenly received a strange power, a quest log that only I could see, a secret to leveling up that only I know about!
                If I trained in accordance with my quests and hunted monsters, my level would rise. Changing from the weakest Hunter to the strongest S-rank Hunter!''',
            genres: ['Action', 'Adventure', 'Fantasy', 'Shounen'],
            rating: 10,
            url: 'https://flamescans.org/series/1678014121-solo-leveling/',
            coverImageUrl:
                'https://flamescans.org/wp-content/uploads/2021/01/image.png',
          );

          // Check if both items have same id
          expect(newMangaRecord.id, equals(secondDatabaseItem.id));
        },
      );

      test(
        'Test deleteManga',
        () async {
          await mangaDb.deleteManga(newMangaRecord.id);

          final allManga = await mangaDb.allManga();

          // expect that the length of manga database is 0
          expect(allManga.length, equals(0));
        },
      );
    },
  );

  tearDownAll(() => Hive.deleteBoxFromDisk('manga_database'));
}

void initHive() {
  var path = Directory.current.path;
  Hive.init('$path/test/hive_test');
}
