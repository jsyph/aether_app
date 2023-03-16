import 'package:app_logging/app_logging.dart';
import 'package:hive/hive.dart';
import 'models/models.dart';

void registerHiveAdapters() { 
  Hive.registerAdapter<MangaDatabaseItemDescription>(
    MangaDatabaseItemDescriptionAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemGenres>(
    MangaDatabaseItemGenresAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemCoverImage>(
    MangaDatabaseItemCoverImageAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemMangaType>(
    MangaDatabaseItemMangaTypeAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemPostedOn>(
    MangaDatabaseItemPostedOnAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemRating>(
    MangaDatabaseItemRatingAdapter(),
  );
  Hive.registerAdapter<MangaDatabaseItemReleaseStatus>(
    MangaDatabaseItemReleaseStatusAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemTitle>(
    MangaDatabaseItemTitleAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemUrl>(
    MangaDatabaseItemUrlAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItemProperty>(
    MangaDatabaseItemPropertyAdapter(),
  );

  Hive.registerAdapter<MangaDatabaseItem>(
    MangaDatabaseItemAdapter(),
  );

  Hive.registerAdapter<ReleaseStatus>(
    ReleaseStatusAdapter(),
  );
}
