extension NullableBoolExt on bool? {
  bool isTrue() {
    if (this == true) {
      return true;
    } else {
      return false;
    }
  }

  bool isFalse() {
    if (this == false) {
      return true;
    } else {
      return false;
    }
  }
}
