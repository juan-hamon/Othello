import 'package:go_router/go_router.dart';
import 'package:othello/pages/pages.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
