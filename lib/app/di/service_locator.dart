import 'package:get_it/get_it.dart';

// Central Service Locator
// This is the container where all dependencies is actually stored
// Usages are as simple as:
// `serviceLocator<MyDependency>()` or `serviceLocator.get<MyDependency>()`
final GetIt serviceLocator = GetIt.instance;