import 'package:shelter_super_app/core/utils/string_utils.dart';

extension NullableStringExt on String? {
  String initialName() {
    List<String> names = orEmpty.split(" ");
    String initials = names
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : "")
        .join();
    return (initials.length > 2 ? initials.substring(0, 2) : initials);
  }
}
