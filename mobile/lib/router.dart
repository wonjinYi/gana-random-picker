import 'package:go_router/go_router.dart';

import 'screens/HomeScreen.dart';
import 'screens/SettingScreen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) => SettingScreen(),
    ),
  ],
);
