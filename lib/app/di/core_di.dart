import 'package:shelter_super_app/app/di/core_di_module.dart';

Future configureCoreDependencies() async {
  final coreModule = CoreModule();
  await coreModule.configureDependency();
}
