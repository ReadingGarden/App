import 'package:book_flutter/ErrorPage.dart';
import 'package:book_flutter/app/navigation/bottom_navi_page.dart';
import 'package:book_flutter/app/splash/splash_page.dart';
import 'package:book_flutter/features/auth/presentation/auth_routes.dart';
import 'package:book_flutter/features/book/presentation/book_routes.dart';
import 'package:book_flutter/features/garden/presentation/garden_routes.dart';
import 'package:book_flutter/features/memo/presentation/memo_routes.dart';
import 'package:book_flutter/features/mypage/presentation/mypage_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) => ErrorPage(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/error',
      name: 'error',
      builder: (context, state) => ErrorPage(),
    ),
    GoRoute(
      path: '/bottom-navi',
      name: 'bottom-navi',
      builder: (context, state) => const BottomNaviPage(),
    ),
    ...authRoutes,
    ...bookRoutes,
    ...memoRoutes,
    ...mypageRoutes,
    ...gardenRoutes,
  ],
);
