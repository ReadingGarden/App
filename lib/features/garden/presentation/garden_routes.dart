import 'package:book_flutter/features/garden/presentation/pages/garden_add_page.dart';
import 'package:book_flutter/features/garden/presentation/pages/garden_book_list_page.dart';
import 'package:book_flutter/features/garden/presentation/pages/garden_edit_page.dart';
import 'package:book_flutter/features/garden/presentation/pages/garden_invite_page.dart';
import 'package:book_flutter/features/garden/presentation/pages/garden_leader_page.dart';
import 'package:book_flutter/features/garden/presentation/pages/garden_member_page.dart';
import 'package:book_flutter/features/garden/presentation/pages/garden_page.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> get gardenRoutes => [
  GoRoute(
    path: '/bottom-navi/garden',
    name: 'garden',
    builder: (context, state) => const GardenPage(),
    routes: [
      GoRoute(
        path: 'invite',
        name: 'invite',
        builder: (context, state) {
          final gardenNo = state.extra as int;
          return GardenInvitePage(gardenNo: gardenNo);
        },
      ),
      GoRoute(
        path: 'garden-edit',
        name: 'garden-edit',
        builder: (context, state) => const GardenEditPage(),
      ),
      GoRoute(
        path: 'garden-book',
        name: 'garden-book',
        builder: (context, state) {
          final gardenNo = state.extra as int;
          return GardenBookListPage(gardenNo: gardenNo);
        },
      ),
      GoRoute(
        path: 'garden-member',
        name: 'garden-member',
        builder: (context, state) {
          final gardenNo = state.extra as int;
          return GardenMemberPage(gardenNo: gardenNo);
        },
        routes: [
          GoRoute(
            path: 'garden-leader',
            name: 'garden-leader',
            builder: (context, state) => const GardenLeaderPage(),
          ),
        ],
      ),
      GoRoute(
        path: 'garden-add',
        name: 'garden-add',
        builder: (context, state) => const GardenAddPage(),
        routes: [
          GoRoute(
            path: 'garden-add-done',
            name: 'garden-add-done',
            builder: (context, state) => const GardenAddDonePage(),
          ),
        ],
      ),
    ],
  ),
];
