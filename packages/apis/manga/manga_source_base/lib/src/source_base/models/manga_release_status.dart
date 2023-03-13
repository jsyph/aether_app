enum MangaReleaseStatus {
  onGoing,
  completed,
  cancelled,
  hiatus,
  dropped,
  none;

  factory MangaReleaseStatus.parse(String rawString) {
    switch (rawString.toLowerCase()) {
      case 'ongoing':
        return MangaReleaseStatus.onGoing;

      case 'completed':
        return MangaReleaseStatus.completed;

      case 'cancelled':
        return MangaReleaseStatus.cancelled;

      case 'dropped':
        return MangaReleaseStatus.dropped;

      case 'hiatus':
        return MangaReleaseStatus.hiatus;

      default:
        return MangaReleaseStatus.none;
    }
  }
}
