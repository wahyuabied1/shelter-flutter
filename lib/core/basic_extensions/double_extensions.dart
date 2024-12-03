extension ObjectExt on double? {
  double orZero() => this ?? 0.0;

  double nullZeroToOne() => orZero() == 0.0 ? 1.0 : orZero();
}
