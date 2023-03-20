import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:app_logging/app_logging.dart';
import 'package:hive/hive.dart';
import 'package:manga_database/manga_database.dart';
import 'package:manga_repository/manga_repository.dart';
import 'package:test/test.dart';

void main() async {
  initHive();
  LocalMangaDatabase.registerHiveAdapters();

  final app = Alfred();

  /// Note the wildcard (*) this is very important!!
  app.get('/*', (req, res) => Directory('./test/test_manga_template/'));

  await app.listen();

  final testSites = [
    'http://localhost:3000/manga_stream/manga_information/test_site_1.html',
    'http://localhost:3000/manga_stream/manga_information/test_site_2.html',
    'http://localhost:3000/manga_stream/manga_information/test_site_3.html',
    'http://localhost:3000/manga_stream/manga_information/test_site_4.html',
    'http://localhost:3000/manga_stream/manga_information/test_site_5.html',
    'http://localhost:3000/manga_stream/manga_information/test_site_6.html',
    'http://localhost:3000/manga_stream/manga_information/test_site_7.html',
    'http://localhost:3000/manga_stream/manga_information/test_site_8.html',
  ];

  final mangaRepo = await MangaRepository.initialize();
  final mangaDb = await LocalMangaDatabase.initialize();

  test(
    'Test Fuzzy Search',
    () {},
  );

  test(
    'Test get manga information',
    () async {
      // create test entries
      final newRecord = await mangaDb.addManga(
        sourceName: 'AsuraScans',
        title: 'Solo Leveling',
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
        contentType: MangaDatabaseItemMangaType.manhwa,
        author: '추공 (Chugong)',
        datePostedOn: DateTime.parse('2021-03-03T14:36:02+00:00'),
        releaseStatus: ReleaseStatus.onGoing,
        altTitles: ['Na Honjaman Lebel-eob', 'Only I Level Up'],
      );

      final mangaInformationPage =
          await mangaRepo.getMangaInformationPage(newRecord.id);
      AppLogger().d(mangaInformationPage);
    },
  );
}

void initHive() {
  var path = Directory.current.path;
  Hive.init('$path/test/hive_test');
}
