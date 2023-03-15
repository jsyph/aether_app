class MangaDatabaseError extends Error {
  MangaDatabaseError(this.error);

  final String error;
}
