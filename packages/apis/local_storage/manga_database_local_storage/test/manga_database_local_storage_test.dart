import 'dart:io';

import 'package:hive/hive.dart';
import 'package:manga_database_local_storage/manga_database_local_storage.dart';
import 'package:test/test.dart';

void main() async {
  initHive();
  registerHiveAdapters();
  final mangaDb = await LocalMangaDatabase.initialize();

  group(
    'Test local manga database',
    () {
      test(
        'Test getMangaById',
        () {},
      );

      test(
        'Test deleteManga',
        () {},
      );

      test(
        'Test exactTitleSearch',
        () {},
      );

      test(
        'Test addManga',
        () async {
          final firstDatabaseItem = await mangaDb.addManga(
            'Asura Scans',
            ['Solo Leveling', 'Na Honjaman Lebel-eob', 'Only I Level Up'],
            '''10 years ago, after “the Gate” that connected the real world with the monster world opened, some of the ordinary, everyday people received the power to hunt monsters within the Gate.
            They are known as “Hunters”. However, not all Hunters are powerful. My name is Sung Jin-Woo, an E-rank Hunter.
              I’m someone who has to risk his life in the lowliest of dungeons, the “World’s Weakest”. Having no skills whatsoever to display,
              I barely earned the required money by fighting in low-leveled dungeons… at least until I found a hidden dungeon with the hardest difficulty within the D-rank dungeons! 
              In the end, as I was accepting death, I suddenly received a strange power, a quest log that only I could see, a secret to leveling up that only I know about!
                If I trained in accordance with my quests and hunted monsters, my level would rise. Changing from the weakest Hunter to the strongest S-rank Hunter!''',
            ['Action', 'Adventure', 'Fantasy', 'Shounen'],
            10,
            'https://www.asurascans.com/manga/1672760368-solo-leveling/',
            'https://www.asurascans.com/wp-content/uploads/2021/03/soloLevelingCover02.png',
          );

          final secondDatabaseItem = await mangaDb.addManga(
            'Flame Scans',
            ['Solo Leveling', 'Na Honjaman Lebel-eob', 'Only I Level Up'],
            '''10 years ago, after “the Gate” that connected the real world with the monster world opened, some of the ordinary, everyday people received the power to hunt monsters within the Gate.
            They are known as “Hunters”. However, not all Hunters are powerful. My name is Sung Jin-Woo, an E-rank Hunter.
              I’m someone who has to risk his life in the lowliest of dungeons, the “World’s Weakest”. Having no skills whatsoever to display,
              I barely earned the required money by fighting in low-leveled dungeons… at least until I found a hidden dungeon with the hardest difficulty within the D-rank dungeons! 
              In the end, as I was accepting death, I suddenly received a strange power, a quest log that only I could see, a secret to leveling up that only I know about!
                If I trained in accordance with my quests and hunted monsters, my level would rise. Changing from the weakest Hunter to the strongest S-rank Hunter!''',
            ['Action', 'Adventure', 'Fantasy', 'Shounen'],
            10,
            'https://flamescans.org/series/1678014121-solo-leveling/',
            'https://flamescans.org/wp-content/uploads/2021/01/image.png',
          );

          // Check if both items have same id
          expect(firstDatabaseItem.id, equals(secondDatabaseItem.id));
        },
      );

      test(
        'Test fuzzyTitleSearch',
        () {},
      );
    },
  );

  tearDownAll(() => Hive.deleteBoxFromDisk('manga_database'));
}

void initHive() {
  var path = Directory.current.path;
  Hive.init('$path/test/hive_test');
}
