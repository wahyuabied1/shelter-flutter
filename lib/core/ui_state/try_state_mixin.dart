import 'package:flutter/widgets.dart';

mixin TryStateMixin<T extends StatefulWidget> on State<T> {
  void tryState(Function() updater) {
    if (mounted) {
      setState(updater);
    }
  }
}
