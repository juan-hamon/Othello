import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:othello/pages/pages.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/game',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const GamePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    )
  ],
);
