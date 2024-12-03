extension RangeExt on int? {
  int get orEmpty => this ?? 0;
  bool inRange(int first, int last) {
    return first <= orEmpty && orEmpty <= last;
  }
}