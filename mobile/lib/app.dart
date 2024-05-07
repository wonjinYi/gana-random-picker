import 'package:flutter/material.dart';
import 'router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final String _title = 'Rapid Gana Draw';

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: _title,
      routerConfig: router,
    );
  }
}
