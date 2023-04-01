/// ### Class that conatins the raw data for a single chapter from MangaSee
///
/// Example:
/// ```json
/// {
///   Chapter: "100130",
///   Type: "Chapter",
///   Date: "2021-04-05 19:07:03",
///   ChapterName: null,
/// },
/// ```
///
/// The field `Type` is doesn't have a class representaion
class MangaSeeChapter {
  MangaSeeChapter._(
      {required this.name,
      required this.timeUploaded,
      required this.url,
      required this.mangaUrlSafeName,
      required this.chapterNumber});

  factory MangaSeeChapter.fromJson(
    Map<String, dynamic> json,
    String mangaUrlSafeName,
  ) {
    final String processedChapterNumber =
        _processChapterNumber(json["Chapter"]);
    return MangaSeeChapter._(
      name: json['ChapterName'],
      timeUploaded: DateTime.parse(
        json['Date'],
      ),
      url:
          'https://mangasee123.com/read-online/$mangaUrlSafeName-chapter-$processedChapterNumber-index-${json["Chapter"][0]}.html',
      mangaUrlSafeName: mangaUrlSafeName,
      chapterNumber: processedChapterNumber,
    );
  }
  final String chapterNumber;

  final String mangaUrlSafeName;

  final String? name;

  final DateTime timeUploaded;

  final String url;

  @override
  String toString() {
    return '''\nMangaSeeChapter(
      title: $name,
      timeUploaded: $timeUploaded,
      url: $url,
      urlSafeName: $mangaUrlSafeName,
    )
''';
  }

  /// Converts "MangaSee chapter formatting" to a readable chapter number.
  ///
  /// Chapter formatting:
  /// ```
  /// eg. 109565 -> [1] [0956] [5]      -> Chapter 956.5
  ///                ?   chap.  decimal
  /// ```
  /// [chapterId] is the chapter number formatted from MangaSee's website.
  /// Returns a readable chapter number.
  ///
  /// From https://github.com/Hecsall/MAPI/blob/master/lib/services/api.dart#L47
  static String _processChapterNumber(String chapterId) {
    final decimalNumber =
        chapterId.substring(chapterId.length - 1, chapterId.length);
    final decimal = decimalNumber != '0' ? '.$decimalNumber' : '';
    final integer =
        _removeChapterPad(chapterId.substring(1, chapterId.length - 1));
    return integer + decimal;
  }

  /// Removes zero-padding from [chapter].
  ///
  /// Recursive function that keeps removing leading "0" until there are no more.
  /// If the final string is empty, it returns "0" (It will be empty if the
  /// chapter number is actually "0" and it gets deleted by the function).
  /// Returns the chapter without zero-padding.
  ///
  /// From https://github.com/Hecsall/MAPI/blob/master/lib/services/api.dart#L30
  static String _removeChapterPad(String chapter) {
    if (chapter.startsWith('0')) {
      return _removeChapterPad(chapter.substring(1, chapter.length));
    }
    return chapter.isNotEmpty ? chapter : '0';
  }
}
