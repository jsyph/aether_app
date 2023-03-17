enum MangaReleaseStatus {
  onGoing,
  dropped,
  completed,
  cancelled,
  hiatus,
  unknown;

  factory MangaReleaseStatus.parse(String rawString) {
    switch (rawString.toLowerCase()) {
      case 'ongoing':
        return MangaReleaseStatus.onGoing;

      case 'dropped':
        return MangaReleaseStatus.dropped;
      case 'completed':
        return MangaReleaseStatus.completed;
      case 'cancelled':
        return MangaReleaseStatus.cancelled;
      case 'hiatus':
        return MangaReleaseStatus.hiatus;
      default:
        return MangaReleaseStatus.unknown;
    }
  }
}
