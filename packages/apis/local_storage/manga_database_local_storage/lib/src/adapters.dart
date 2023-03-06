import 'package:hive/hive.dart';
import 'models/models.dart';

void registerHiveAdapters() {
  Hive.registerAdapter<MangaDatabaseItemCoverImage>(
    MangaDatabaseItemCoverImageAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemDescription>(
    MangaDatabaseItemDescriptionAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemGenres>(
    MangaDatabaseItemGenresAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemRating>(
    MangaDatabaseItemRatingAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemTitle>(
    MangaDatabaseItemTitleAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemUrl>(
    MangaDatabaseItemUrlAdapter(),
  );

  Hive.registerAdapter(
    MangaDatabaseItemMangaTypeAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItem>(
    MangaDatabaseItemAdapter(),
  );
}
