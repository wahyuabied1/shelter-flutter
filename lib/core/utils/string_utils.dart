extension StringValidatorExtension on String {
  bool toBoolean() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }
    throw '"$this" can not be parsed to boolean';
  }

  bool isValidPhoneNumber() {
    String pattern = r'(^(?:[+08]9)?[0-9]{8,16}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool isValidPhoneIndonesia() {
    String pattern = r'(^08[0-9]{6,12}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool isValidPhoneIndonesiaWithCountryCallingCode() {
    String pattern = r'(^\+62[0-9]{8,13}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool hasAnySpecialCharacter() {
    // regex contains characters that is not an alphabet and number
    var specialCharRegex = RegExp(r'[a-zA-Z0-9 ]+').allMatches(this);
    bool expression = specialCharRegex.length == 1 &&
        specialCharRegex.first.start == 0 &&
        specialCharRegex.first.end == length;
    return !expression;
  }

  bool hasAnyNumber() {
    RegExp numberRegex = RegExp(r'[0-9]');
    return numberRegex.hasMatch(this);
  }

  bool get isNumeric => RegExp(r'^[0-9]*$').hasMatch(this);

  bool get isValidEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,7}$',
    );
    return emailRegExp.hasMatch(this);
  }

  bool get isValidUrl {
    if (length == 0) return false;
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }
}

extension NullableStringValidatorExtension on String? {
  bool? toBooleanOrNull() {
    if (this == null) {
      return null;
    } else if (this?.toLowerCase() == 'true') {
      return true;
    } else if (this?.toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean';
  }
}

extension StringFormatterExtension on String {
  toTitleCase() {
    if (isEmpty) return '';
    return toLowerCase()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1, word.length))
        .join(' ');
  }

  String masking() {
    try {
      if (isValidEmail) {
        final name = substring(0, indexOf('@'));
        final start = name.length > 4 ? name.length - 4 : 1;
        final end = name.length;
        return replaceRange(start, end, '*'.padRight(end - start, '*'));
      } else if (isValidPhoneNumber()) {
        final start = length - 6;
        final end = start + 4;
        return replaceRange(start, end, '*'.padRight(end - start, '*'));
      }
      return this;
    } catch (e) {
      return this;
    }
  }

  String maskingKtp() {
    try {
      const start = 4;
      final end = length;
      return replaceRange(start, end, '*'.padRight(end - start, '*'));
    } catch (e) {
      return this;
    }
  }

  hideUrl() {
    var result = split(' ');
    return result.where((e) => e.contains('https') == false).join(' ');
  }

  /// Convert to local format from +62 prefix
  /// e.g. +628123123123 -> 08123123123
  /// e.g 08123123123 -> 08123123123
  String convertPhoneToLocalFormat() {
    final phoneNumber = replaceAll('-', '').replaceAll(' ', '');
    if (phoneNumber.startsWith('+62')) {
      return '0${phoneNumber.substring(3)}';
    }
    return phoneNumber;
  }
}

extension NullableStringExt on String? {
  double? toDouble() {
    return double.tryParse(this ?? '');
  }

  String toFourDigitFormatted() {
    if (this == null) {
      return '';
    } else {
      return toString()
          .replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
    }
  }

  String capitalizeOperatorName() {
    if (this == null) {
      return '';
    } else {
      if (RegExp(
        'pln',
        caseSensitive: false,
      ).hasMatch(this!)) {
        return '';
      } else {
        if (this!.length > 2) {
          return capitalize();
        } else {
          // XL case
          return this!.toUpperCase();
        }
      }
    }
  }

  String capitalize() {
    if (this == null) {
      return '';
    } else {
      return '${this![0].toUpperCase()}${this!.substring(1)}';
    }
  }

  String get orEmpty => this ?? '';

  String get orDash => this ?? '-';

  String get orEmptyOrZero => this ?? '0';

  bool isValidUrl() {
    final RegExp regex = RegExp(
      r'https?://\S+',
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(this ?? '');
  }

  bool? toBool() {
    return bool.tryParse(this ?? '');
  }

  String removePrefix(String prefix) {
    if (this == null) return '';

    if (this!.startsWith(prefix)) {
      return this!.substring(prefix.length);
    }

    return this!;
  }
}

extension StringValidation on String {
  containsIgnoreCase(String value) {
    return toLowerCase().contains(value.toLowerCase());
  }

  equalIgnoreCase(String value) {
    return toLowerCase() == value.toLowerCase();
  }
}

extension FileExtension on String? {
  /// Returns the file extension from the given string.
  String get fileExtension {
    if (this == null) return '';
    try {
      return this!.split('.').last;
    } catch (e) {
      return ''; // Return an empty string if there's no extension.
    }
  }
}
