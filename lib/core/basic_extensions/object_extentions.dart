extension ObjectExt on Object? {
  int toIntOrZero() => int.tryParse(toString()) ?? 0;

  bool? asBool() => bool.tryParse(toString());

  double? asDouble() => double.tryParse(toString());

  int? asInt() => int.tryParse(toString());

  int toIntOrOne() {
    if(toString().isEmpty || toString() == '0'){
      return 1;
    }
    return int.tryParse(toString()) ?? 1;
  }

}
