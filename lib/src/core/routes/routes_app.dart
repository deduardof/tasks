import 'package:go_router/go_router.dart';
import 'package:tasks/src/pages/home_page.dart';
import 'package:tasks/src/pages/task_types_page.dart';

final routesApp = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: '/task/types',
          builder: (context, state) => TaskTypesPage(),
        ),
      ],
    ),
  ],
);
