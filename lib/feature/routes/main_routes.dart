import 'package:shelter_super_app/feature/routes/cleaningqu_routes.dart';
import 'package:shelter_super_app/feature/routes/hadirqu_routes.dart';
import 'package:shelter_super_app/feature/routes/homepage_routes.dart';

/// Top most route in the stack
class MainRoutes {
  MainRoutes._();

  static final routes = [
    ...HomepageRoutes.mainRoutes,
    ...HadirQuRoutes.mainRoutes,
    ...CleaningquRoutes.mainRoutes
  ];
}
