import 'package:app_logging/app_logging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:manga_database/manga_database.dart';
import 'package:manga_repository/manga_repository.dart';

void main() async {
  await Hive.initFlutter();
  LocalMangaDatabase.registerHiveAdapters();
  await Hive.deleteBoxFromDisk('manga_database');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.toString(),
                softWrap: true,
              );
            }
            return const CircularProgressIndicator();
          },
          future: createTestRecord(),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<dynamic> createTestRecord() async {
  final mangaDb = await LocalMangaDatabase.initialize();
  final mangaRepo = await MangaRepository.initialize();
  // create test entries
  final newRecord = await mangaDb.addManga(
    sourceName: 'VoidScans',
    title: 'Lookism',
    description:
        '''Daniel is an unattractive loner who wakes up in a different body. Now tall, handsome, and cooler than ever in his new form, 
        Daniel aims to achieve everything he couldn’t before. How far will he go to keep his body… and his secrets?

[metaslider id=”33262″]
''',
    genres: [
      'Action ',
      'Comedy',
      'Drama',
      'School',
      'Life',
      'Shounen',
      'Supernatural'
    ],
    rating: 10,
    url: 'https://void-scans.com/manga/lookism/',
    coverImageUrl:
        'https://void-scans.com/wp-content/uploads/2022/05/k372635749_1.jpg',
    contentType: MangaDatabaseItemMangaType.manhwa,
    author: 'Park Tae Jun',
    datePostedOn: DateTime.parse('2022-05-31T07:18:45+05:30'),
    releaseStatus: ReleaseStatus.onGoing,
    altTitles: [
      'Apari3ncias,' 'Görünüşçülük, ' 'Дискриминация по внешности, ' 'Лукизм, ',
      '外見至上主義,' '外貌至上主義, ',
      '看脸时代, ',
      '看臉時代,',
      '외모지상주의',
    ],
  );

  await mangaDb.addManga(
    sourceName: 'CosmicScans',
    title: 'Lookism',
    description:
        '''Daniel is an unattractive loner who wakes up in a different body. Now tall, handsome, and cooler than ever in his new form, 
        Daniel aims to achieve everything he couldn’t before. How far will he go to keep his body… and his secrets?

[metaslider id=”33262″]
''',
    genres: [
      'Action ',
      'Comedy',
      'Drama',
      'School',
      'Life',
      'Shounen',
      'Supernatural'
    ],
    rating: 10,
    url: 'https://cosmicscans.com/manga/lookism/',
    coverImageUrl:
        'https://i1.wp.com/cosmicscans.com/wp-content/uploads/2022/11/lookismCUnetnoiseLevel3.png',
    contentType: MangaDatabaseItemMangaType.manhwa,
    author: 'Park Tae Jun',
    datePostedOn: DateTime.parse('2022-05-31T07:18:45+05:30'),
    releaseStatus: ReleaseStatus.onGoing,
    altTitles: [
      'Apari3ncias,' 'Görünüşçülük, ' 'Дискриминация по внешности, ' 'Лукизм, ',
      '外見至上主義,' '外貌至上主義, ',
      '看脸时代, ',
      '看臉時代,',
      '외모지상주의',
    ],
  );

  final mangaInformationPage =
      await mangaRepo.getMangaInformationPage(newRecord.id);

  AppLogger().d(mangaInformationPage);
  return mangaInformationPage;
}
