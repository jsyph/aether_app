import 'package:hive/hive.dart';
import 'package:manga_database_local_storage/src/models/models.dart';

final List<TypeAdapter<MangaDatabaseItemProperty>> _hiveAdapters = [
  MangaDatabaseItemPropertyAdapter(),
  MangaDatabaseItemDescriptionAdapter(),
  MangaDatabaseItemGenresAdapter(),
  MangaDatabaseItemCoverImageAdapter(),
  MangaDatabaseItemRatingAdapter(),
  MangaDatabaseItemTitlesAdapter(),
  MangaDatabaseItemUriAdapter(),
];

void registerHiveAdapters() {
  for (int i = 0; i < _hiveAdapters.length; i++) {
    Hive.registerAdapter<MangaDatabaseItemProperty>(_hiveAdapters[i]);
  }

  Hive.registerAdapter<MangaDatabaseItem>(MangaDatabaseItemAdapter());
}
