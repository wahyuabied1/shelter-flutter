import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

extension ServiceLocatorExt on GetIt {
  T create<T extends Object>(BuildContext context) => get<T>();
}

final GetIt serviceLocator = GetIt.instance;