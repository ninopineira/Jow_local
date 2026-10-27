import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/enums.dart';
import 'list_screen.dart';
import 'menu_screen.dart';
import 'onboarding_screen.dart';
import 'providers.dart';
import 'recipe_detail_screen.dart';
import 'recipe_editor_screen.dart';
import 'recipes_screen.dart';
import 'review_screen.dart';
import 'settings_screen.dart';
import 'strings.dart';
import 'theme.dart';

GoRouter buildRouter({required bool onboarded}) => GoRouter(
  initialLocation: onboarded ? '/menu' : '/onboarding',
  routes: [
    GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => HomeShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/menu',
              builder: (_, _) => const MenuScreen(),
              routes: [
                GoRoute(
                  path: 'review',
                  builder: (_, s) => ReviewScreen(week: s.extra! as DateTime),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/list', builder: (_, _) => const ListScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/recipes',
              builder: (_, _) => const RecipesScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (_, _) => const RecipeEditorScreen(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (_, s) => RecipeDetailScreen(
                    recipeId: int.parse(s.pathParameters['id']!),
                  ),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (_, s) => RecipeEditorScreen(
                        recipeId: int.parse(s.pathParameters['id']!),
                      ),
                    ),
                    GoRoute(
                      path: 'cook',
                      builder: (_, s) => CookModeScreen(
                        recipeId: int.parse(s.pathParameters['id']!),
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
              path: '/settings',
              builder: (_, _) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'profile',
                  builder: (_, _) => const ProfileEditScreen(),
                ),
                GoRoute(
                  path: 'aisles',
                  builder: (_, _) => const AisleOrderScreen(),
                ),
                GoRoute(path: 'about', builder: (_, _) => const AboutScreen()),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: shell,
    bottomNavigationBar: NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (i) =>
          shell.goBranch(i, initialLocation: i == shell.currentIndex),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month_rounded),
          label: S.tabMenu,
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_basket_outlined),
          selectedIcon: Icon(Icons.shopping_basket_rounded),
          label: S.tabList,
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book_rounded),
          label: S.tabRecipes,
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings_rounded),
          label: S.tabSettings,
        ),
      ],
    ),
  );
}

class PopoteApp extends ConsumerStatefulWidget {
  const PopoteApp({super.key, required this.onboarded});

  final bool onboarded;

  @override
  ConsumerState<PopoteApp> createState() => _PopoteAppState();
}

class _PopoteAppState extends ConsumerState<PopoteApp> {
  late final router = buildRouter(onboarded: widget.onboarded);

  @override
  void dispose() {
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pref =
        ref.watch(profileProvider).value?.theme ?? ThemePreference.system;
    return MaterialApp.router(
      title: S.appName,
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: switch (pref) {
        ThemePreference.system => ThemeMode.system,
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
      },
      routerConfig: router,
    );
  }
}
