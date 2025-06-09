import 'package:go_router/go_router.dart';
import 'package:tasks/src/pages/home_page.dart';

final routesApp = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
  ],
);
