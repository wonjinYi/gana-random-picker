import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile/provider/setting_model.dart';

import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';
import 'router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final String _title = 'Rapid Gana Draw';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingModel()),
      ],
      builder: (context, _) {
        return MaterialApp.router(
          title: _title,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: Provider.of<SettingModel>(context).themeMode,
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Provider.of<SettingModel>(context).locale,
        );
      },
    );
  }
}
