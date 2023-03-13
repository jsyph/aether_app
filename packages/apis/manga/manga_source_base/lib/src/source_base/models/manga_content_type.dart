enum MangaContentType {
  manhwa,
  manhua,
  manga,
  // is not returned from  parse factory
  unknown,
  none;

  factory MangaContentType.parse(String rawString) {
    switch (rawString.toLowerCase()) {
      case 'manhua':
        return MangaContentType.manhua;

      case 'manhwa':
        return MangaContentType.manhwa;

      case 'manga':
        return MangaContentType.manga;

      default:
        return MangaContentType.none;
    }
  }
}
