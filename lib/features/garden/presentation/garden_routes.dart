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
        builder: (context, state) => GardenPage(),
        routes: [
          GoRoute(
            path: 'invite',
            name: 'invite',
            builder: (context, state) {
              final gardenNo = state.extra as int;
              return GardenInvitePage(garden_no: gardenNo);
            },
          ),
          GoRoute(
            path: 'garden-edit',
            name: 'garden-edit',
            builder: (context, state) => GardenEditPage(),
          ),
          GoRoute(
            path: 'garden-book',
            name: 'garden-book',
            builder: (context, state) {
              final garden = state.extra as Map;
              return GardenBookListPage(garden: garden);
            },
          ),
          GoRoute(
            path: 'garden-member',
            name: 'garden-member',
            builder: (context, state) {
              final gardenNo = state.extra as int;
              return GardenMemberPage(garden_no: gardenNo);
            },
            routes: [
              GoRoute(
                path: 'garden-leader',
                name: 'garden-leader',
                builder: (context, state) => GardenLeaderPage(),
              ),
            ],
          ),
          GoRoute(
            path: 'garden-add',
            name: 'garden-add',
            builder: (context, state) => GardenAddPage(),
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
