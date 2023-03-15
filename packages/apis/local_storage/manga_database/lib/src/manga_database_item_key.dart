/// How a manga database item key looks:
///
/// `4a67344c-3264-4fa1-a5a6-a673793536bd|Solo Leveling_Na Honjaman Lebel-eob_Only I Level Up`
///
/// `+----------------------------------+` `+-------------------------------------------------+`
///
///                 ⬆ id ⬆                                    ⬆ titles ⬆
class MangaDatabaseItemKey {
  MangaDatabaseItemKey(this.id, this.titles);

  factory MangaDatabaseItemKey.parse(String rawString) {
    final splitRawString = rawString.split('|');
    final id = splitRawString.first;
    final titles = splitRawString.last.split('_');
    return MangaDatabaseItemKey(id, titles);
  }

  final String id;
  final List<String> titles;

  @override
  String toString() {
    return '$id|${titles.join('_')}';
  }
}
