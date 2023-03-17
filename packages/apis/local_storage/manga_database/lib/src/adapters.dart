import 'package:hive/hive.dart';

import 'models/models.dart';

void registerHiveAdapters() {
  Hive.registerAdapter<MangaDatabaseItemMangaType>(
    MangaDatabaseItemMangaTypeAdapter(),
  );

  Hive.registerAdapter<ReleaseStatus>(
    ReleaseStatusAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItem>(
    MangaDatabaseItemAdapter(),
  );
}
