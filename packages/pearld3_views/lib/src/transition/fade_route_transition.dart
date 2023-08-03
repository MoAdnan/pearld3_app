import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage fadeRouteTransition(
    {required BuildContext context,
    required GoRouterState state,
    required Widget child}) {
  return CustomTransitionPage(
    transitionDuration: const Duration(microseconds: 700),
    child: child,
    key: state.pageKey,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
