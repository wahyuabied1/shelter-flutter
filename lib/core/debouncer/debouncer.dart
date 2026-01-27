import 'dart:async';

import 'package:flutter/animation.dart';

class Debouncer {
  int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

/// prevent tap event being called multiple times
/// due to aggressive user click while future process is still running
class TapDebouncer {
  bool _isTapping = false;

  void debounce(Future Function() future) {
    if (_isTapping) {
      return;
    }
    _isTapping = true;
    future().whenComplete(() => _isTapping = false);
  }
}
