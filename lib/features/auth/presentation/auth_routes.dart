import 'package:book_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:book_flutter/features/auth/presentation/pages/pwd_find_page.dart';
import 'package:book_flutter/features/auth/presentation/pages/pwd_setting_page.dart';
import 'package:book_flutter/features/auth/presentation/pages/signup_page.dart';
import 'package:book_flutter/features/auth/presentation/pages/start_page.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> get authRoutes => [
      GoRoute(
        path: '/start',
        name: 'start',
        builder: (context, state) => StartPage(),
        routes: [
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (context, state) => LoginPage(),
            routes: [
              GoRoute(
                path: 'signup',
                name: 'signup',
                builder: (context, state) => SignupPage(),
                routes: [
                  GoRoute(
                    path: 'signup-done',
                    name: 'signup-done',
                    builder: (context, state) {
                      final userNick = state.extra as String;
                      return SignupDonePage(user_nick: userNick);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'pwd-find',
                name: 'pwd-find',
                builder: (context, state) => PwdFindPage(),
                routes: [
                  GoRoute(
                    path: 'pwd-setting',
                    name: 'pwd-setting',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>;
                      return PwdSettingPage(
                        user_email: extra['user_email'] as String,
                        isLoginPage: extra['isLoginPage'] as bool,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ];
