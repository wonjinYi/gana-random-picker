import 'package:flutter/material.dart';
import 'package:mobile/router.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            router.go('/');
          },
          child: const Text('Go back to Home Screen'),
        ),
      ),
    );
  }
}
