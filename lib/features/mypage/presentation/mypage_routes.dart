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
        builder: (context, state) => MyPage(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => ProfilePage(),
            routes: [
              GoRoute(
                path: 'nickname',
                name: 'nickname',
                builder: (context, state) => NickNamePage(),
              ),
              GoRoute(
                path: 'profile-image',
                name: 'profile-image',
                builder: (context, state) => ProfileImagePage(),
              ),
            ],
          ),
          GoRoute(
            path: 'auth-manage',
            name: 'auth-manage',
            builder: (context, state) => AuthManagePage(),
          ),
          GoRoute(
            path: 'alert',
            name: 'alert',
            builder: (context, state) => AlertSettingPage(),
          ),
          GoRoute(
            path: 'tos',
            name: 'tos',
            builder: (context, state) => TosPage(),
          ),
        ],
      ),
    ];
