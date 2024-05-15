// Filter
enum Filter {
  hiragana('hiragana'),
  katakana('katakana');

  final String name;
  const Filter(this.name);
}

// Language
enum Language {
  system('system'),
  en('en'), // english
  ko('ko'); // korean

  final String name;
  const Language(this.name);
}

// Theme Name
enum ThemeName {
  system('system'),
  light('light'),
  dark('dark');

  final String name;
  const ThemeName(this.name);
}

// urls
Map<String, String> urls = {
  'termsAndConditions':
      'https://github.com/wonjinYi/rapid-gana-draw/blob/main/TERMS_AND_CONDITIONS.md',
  'privacyPolicy':
      'https://github.com/wonjinYi/rapid-gana-draw/blob/main/PRIVACY_POLICY.md',
};
