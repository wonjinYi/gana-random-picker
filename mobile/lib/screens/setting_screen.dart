import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mobile/global_variables.dart';
import 'package:mobile/provider/setting_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final String urlTermsAndConditions = urls['termsAndConditions']!;
  final String urlPrivacyPolicy = urls['privacyPolicy']!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleSetting),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 언어 설정
              RowItem(
                label: (AppLocalizations.of(context)!.language),
                child: DropdownButtonWithEnum<Language>(
                  items: Language.values,
                  currentItem: context.watch<SettingModel>().language,
                  onChanged: context.read<SettingModel>().updateLanguage,
                  getDisplayText: getDisplayTextOfLanguage,
                ),
              ),
              // 테마 설정
              RowItem(
                label: (AppLocalizations.of(context)!.theme),
                child: DropdownButtonWithEnum<ThemeName>(
                  items: ThemeName.values,
                  currentItem: context.watch<SettingModel>().themeName,
                  onChanged: context.read<SettingModel>().updateThemeName,
                  getDisplayText: getDisplayTextOfThemeName,
                ),
              ),
              // 이용약관 보기. 별도의 screen에 플러터 webview를 넣어 구현함.
              RowItem(
                label: (AppLocalizations.of(context)!.termsAndConditions),
                child: LinkOpenButton(
                    url: urlTermsAndConditions,
                    onPressed: () {
                      context.push('/terms');
                    }),
              ),
              // 개인정보방침 보기. 서드파티 인앱브라우저로 구현함.
              RowItem(
                label: (AppLocalizations.of(context)!.privacyPolicy),
                child: LinkOpenButton(
                    url: urlPrivacyPolicy,
                    onPressed: () {
                      if (!Platform.isLinux) {
                        final browser = InAppBrowser();
                        browser.openUrlRequest(
                            urlRequest:
                                URLRequest(url: WebUri(urls['privacyPolicy']!)),
                            settings: InAppBrowserClassSettings(
                              browserSettings:
                                  InAppBrowserSettings(hideUrlBar: false),
                              webViewSettings:
                                  InAppWebViewSettings(javaScriptEnabled: true),
                            ));
                      } else {}
                    }),
              ),
              // 설정 초기화
              RowItem(
                label: (AppLocalizations.of(context)!.resetPreferences),
                child: ResetPrefsButton(),
              ),
              Divider(
                  height: 64.0,
                  thickness: 1,
                  color: Theme.of(context).colorScheme.tertiary),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.developerInfo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({super.key, required this.label, this.child});
  final String label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(label),
          SizedBox(width: 8),
          child ?? Container(),
        ],
      ),
    );
  }
}

class LinkOpenButton extends StatelessWidget {
  const LinkOpenButton({super.key, required this.url, required this.onPressed});

  final String url;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(AppLocalizations.of(context)!.open),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary),
        ));
  }
}

class ResetPrefsButton extends StatelessWidget {
  const ResetPrefsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final confirm = await resetConfirmation(context);
          if (confirm) {
            if (context.mounted) {
              context.read<SettingModel>().resetAll();
            } else {
              throw Exception('context is not mounted');
            }
          }
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.error),
          foregroundColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.onError),
          overlayColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.error),
        ),
        child: Text(AppLocalizations.of(context)!.reset));
  }

  Future<bool> resetConfirmation(BuildContext context) async {
    bool? result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.reset),
              content: Text(AppLocalizations.of(context)!.msgResetConfirmation),
              backgroundColor: Theme.of(context).colorScheme.error,
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onError),
                    overlayColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.error),
                  ),
                  child: Text(AppLocalizations.of(context)!.no),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onError),
                  ), // resetConfirmation
                  child: Text(AppLocalizations.of(context)!.yes),
                ),
              ],
            ));
    return result ?? false;
  }
}

class DropdownButtonWithEnum<T extends Enum> extends StatelessWidget {
  const DropdownButtonWithEnum({
    super.key,
    required this.items,
    required this.currentItem,
    required this.onChanged,
    required this.getDisplayText,
  });

  final List<T> items;
  final T currentItem;
  final void Function(T newValue) onChanged;
  final String Function(BuildContext context, T enumValue) getDisplayText;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      menuMaxHeight: double.infinity,
      dropdownColor: Theme.of(context).colorScheme.surface,
      value: currentItem,
      onChanged: (T? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        } else {
          throw Exception('newValue is null');
        }
      },
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(getDisplayText(context, item)),
        );
      }).toList(),
    );
  }
}

String getDisplayTextOfLanguage(BuildContext context, Language language) {
  switch (language) {
    case Language.system:
      return AppLocalizations.of(context)!.system;
    case Language.en:
      return AppLocalizations.of(context)!.english;
    case Language.ko:
      return AppLocalizations.of(context)!.korean;
    default:
      return 'Unknown Language';
  }
}

String getDisplayTextOfThemeName(BuildContext context, ThemeName themeName) {
  switch (themeName) {
    case ThemeName.system:
      return AppLocalizations.of(context)!.system;
    case ThemeName.light:
      return AppLocalizations.of(context)!.light;
    case ThemeName.dark:
      return AppLocalizations.of(context)!.dark;
    default:
      return 'Unknown Theme Name';
  }
}
