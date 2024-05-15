import 'package:go_router/go_router.dart';

import 'package:mobile/screens/home_screen/home_screen.dart';
import 'package:mobile/screens/setting_screen.dart';
import 'package:mobile/screens/terms_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsScreen(),
    )
  ],
);
