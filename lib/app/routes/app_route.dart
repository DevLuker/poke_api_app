import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_api_app/app/config/config.dart';
import 'package:poke_api_app/features/home/view/home_view.dart';

final goRouterConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: HomeView.route,
      builder: (context, state) => const HomeView(),
    ),
    // ... others
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text(
        '¡Ocurrió un error!',
        style: TextStyle(color: AppColors.red),
      ),
    ),
  ),
);
