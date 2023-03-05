import 'package:hive/hive.dart';
import 'models/models.dart';

void registerHiveAdapters() {
  Hive.registerAdapter<MangaDatabaseItemProperty>(
    MangaDatabaseItemPropertyAdapter(),
  );

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

  Hive.registerAdapter<MangaDatabaseItemUri>(
    MangaDatabaseItemUriAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItem>(
    MangaDatabaseItemAdapter(),
  );
}
