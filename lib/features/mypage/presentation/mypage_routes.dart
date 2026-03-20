import 'package:book_flutter/features/mypage/presentation/pages/alert_setting_page.dart';
import 'package:book_flutter/features/mypage/presentation/pages/auth_manage_page.dart';
import 'package:book_flutter/features/mypage/presentation/pages/my_page.dart';
import 'package:book_flutter/features/mypage/presentation/pages/nickname_page.dart';
import 'package:book_flutter/features/mypage/presentation/pages/profile_image_page.dart';
import 'package:book_flutter/features/mypage/presentation/pages/profile_page.dart';
import 'package:book_flutter/features/mypage/presentation/pages/tos_page.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> get mypageRoutes => [
      GoRoute(
        path: '/bottom-navi/mypage',
        name: 'mypage',
        builder: (context, state) => const MyPage(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
            routes: [
              GoRoute(
                path: 'nickname',
                name: 'nickname',
                builder: (context, state) => const NickNamePage(),
              ),
              GoRoute(
                path: 'profile-image',
                name: 'profile-image',
                builder: (context, state) => const ProfileImagePage(),
              ),
            ],
          ),
          GoRoute(
            path: 'auth-manage',
            name: 'auth-manage',
            builder: (context, state) => const AuthManagePage(),
          ),
          GoRoute(
            path: 'alert',
            name: 'alert',
            builder: (context, state) => const AlertSettingPage(),
          ),
          GoRoute(
            path: 'tos',
            name: 'tos',
            builder: (context, state) => const TosPage(),
          ),
        ],
      ),
    ];
