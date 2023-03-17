import 'dart:io';
import 'package:hive/hive.dart';
import 'package:manga_database/manga_database.dart';
import 'package:test/test.dart';

void main() async {
  initHive();
  registerHiveAdapters();
  final mangaDb = await LocalMangaDatabase.initialize();

  final newMangaRecord = await mangaDb.addManga(
    sourceName: 'Asura Scans',
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
            url: 'https://flamescans.org/series/1678014121-solo-leveling/',
            coverImageUrl:
                'https://flamescans.org/wp-content/uploads/2021/01/image.png',
            contentType: MangaDatabaseItemMangaType.manhwa,
            author: '추공 (Chugong)',
            datePostedOn: DateTime.parse('2021-03-03T14:36:02+00:00'),
            releaseStatus: ReleaseStatus.onGoing,
            altTitles: ['Na Honjaman Lebel-eob', 'Only I Level Up'],
          );

          // Check if both items have same id
          expect(newMangaRecord.id, equals(secondDatabaseItem.id));
        },
      );

      test(
        'Test Export manga as json',
        () async {
          await mangaDb.addManga(
            sourceName: 'Flame Scans',
            title: 'Dr. Player',
            description:
                '''[By the studio that brought you <My School Life Pretending To Be a Worthless Person> and <Damn Reincarnation>!]
Raymond was the illegitimate son of the king.
After being shamed and scorned, he ran away and became a healer… only to end up being ridiculed for getting an F rank.
Then, one day, a miracle came upon him.
[You have awakened as a player!]
[Job: Surgeon (SSS-rank)]
Raymond gained medical knowledge that had not existed in this world. The great legend of Raymond, the first surgeon, begins now!''',
            genres: ['Action', 'Adventure', 'Fantasy', 'System'],
            rating: 9.7,
            url: 'https://www.asurascans.com/manga/1672760368-dr-player/',
            coverImageUrl:
                'https://www.asurascans.com/wp-content/uploads/2022/12/drPlayerCover02.png',
            contentType: MangaDatabaseItemMangaType.manhwa,
            author: 'Yooin',
            datePostedOn: DateTime.parse('2022-12-02T13:38:13+00:00'),
            releaseStatus: ReleaseStatus.onGoing,
            altTitles: null,
          );

          final exportedDatabase = await mangaDb.exportAsJson();

          expect(
            exportedDatabase.length,
            equals(2),
          );
        },
      );

      test(
        'Test loadFromJson',
        () async {
          final mangaToBeAdded = [
            {
              'author': '',
              'content_type': 'manhwa',
              'cover_images': [
                {
                  'source_name': 'AsuraScans',
                  'url':
                      'https://www.asurascans.com/wp-content/uploads/2022/11/DemonLordCover02.png',
                },
              ],
              'descriptions': [
                {
                  'source_name': 'AsuraScans',
                  'text':
                      '''“Demon Lord.”\nThat’s…\nWhat they used to call me in my past life, before I became human.''',
                },
              ],
              'genres': [
                {
                  'source_name': 'AsuraScans',
                  'genres': [
                    'Action',
                    'Adventure',
                    'Demon',
                    'Fantasy',
                    'Martial Arts',
                  ],
                }
              ],
              'id': '21b0b9ae-d682-40f7-bfa5-b08fc8740804',
              'posted_on': [
                {
                  'source_name': 'AsuraScans',
                  'posted_on': '2022-11-18T13:10:14+00:00',
                },
              ],
              'rating': [
                {
                  'source_name': 'AsuraScans',
                  'rating': 9.7,
                }
              ],
              'release_status': [
                {
                  'source_name': 'AsuraScans',
                  'status': 'on_going',
                }
              ],
              'titles': [
                {
                  'source_name': 'AsuraScans',
                  'title': 'Demon Lord’s Martial Arts Ascension'
                },
              ],
              'alt_titles': null,
              'urls': [
                {
                  'source_name': 'AsuraScans',
                  'url':
                      'https://www.asurascans.com/manga/1672760368-demon-lords-martial-arts-ascension/',
                }
              ],
            },
          ];

          await mangaDb.loadFromJson(mangaToBeAdded);

          final searchResult = await mangaDb
              .exactTitleSearch('Demon Lord’s Martial Arts Ascension');

          expect(searchResult, isNotNull);
        },
      );

      test(
        'Test deleteManga',
        () async {
          await mangaDb.deleteManga(newMangaRecord.id);

          final allManga = await mangaDb.allManga();

          // expect that the length of manga database is 2
          expect(allManga.length, equals(2));
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
