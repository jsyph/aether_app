class MangaSeeMangaDoesNotExistException implements Exception {
  final String cause;
  MangaSeeMangaDoesNotExistException(this.cause);

  @override
  String toString() {
    return cause;
  }
}

class MangaSeeChapterDoesNotExistException implements Exception {
  final String cause;
  MangaSeeChapterDoesNotExistException(this.cause);

  @override
  String toString() {
    return cause;
  }
}

class MangaSeeCannotGetDatabaseException implements Exception {
  final String cause;
  MangaSeeCannotGetDatabaseException(this.cause);

  @override
  String toString() {
    return cause;
  }
}

class MangaSeeMangaDatabaseConnotBeEmptyException implements Exception {
  final String cause;
  MangaSeeMangaDatabaseConnotBeEmptyException(this.cause);
  
  @override
  String toString() {
    return cause;
  }
}

class MangaSeeConnectionFailureException implements Exception {
  final String cause;
  MangaSeeConnectionFailureException(this.cause);
  
  @override
  String toString() {
    return cause;
  }
}
