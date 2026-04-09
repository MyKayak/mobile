import 'package:go_router/go_router.dart';
import '../../features/meets/views/meets_screen.dart';
import '../../features/meets/views/races_screen.dart';
import '../../features/meets/views/heats_screen.dart';
import '../../features/settings/views/settings_screen.dart';
import '../../features/teams/views/teams_screen.dart';
import '../../features/athletes/views/athletes_screen.dart';
import '../../features/auth/views/login_screen.dart';
import 'scaffold_with_nav_bar.dart';

final goRouter = GoRouter(
  initialLocation: '/meets',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/meets',
              builder: (context, state) => const MeetsScreen(),
              routes: [
                GoRoute(
                  path: 'races/:meetId',
                  builder: (context, state) => RacesScreen(
                    meetId: state.pathParameters['meetId']!,
                  ),
                  routes: [
                    GoRoute(
                      path: 'heats/:raceId',
                      builder: (context, state) => HeatsScreen(
                        raceId: int.parse(state.pathParameters['raceId']!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/teams',
              builder: (context, state) => const TeamsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/athletes',
              builder: (context, state) => const AthletesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
