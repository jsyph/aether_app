import 'ui/root_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:manga_repository/manga_repository.dart';

import 'ui/root_widget.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  MangaRepository.registerDatabaseAdapters();

  runApp(
    MyApp(
      await MangaRepository.initialize(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(this._mangaRepository, {super.key});

  final MangaRepository _mangaRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: ChangeNotifierProvider<RootBottomNavigationProvider>(
        create: (context) => RootBottomNavigationProvider(),
        builder: (context, child) => const RootWidget(),
      ),
    );
  }
}
