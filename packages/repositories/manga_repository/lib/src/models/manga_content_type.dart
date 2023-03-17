enum MangaContentType {
  manhua,

  manhwa,

  manga,

  unknown;

  factory MangaContentType.parse(String rawString) {
    switch (rawString.toLowerCase()) {
      case 'manhua':
        return MangaContentType.manhua;

      case 'manhwa':
        return MangaContentType.manhwa;

      case 'manga':
        return MangaContentType.manhwa;

      default:
        return MangaContentType.unknown;
    }
  }
}
