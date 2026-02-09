class LanguageOption {
  final String code;
  final String nameEnglish;
  final String nameNative;
  final String flagEmoji;
  final String description;

  const LanguageOption({
    required this.code,
    required this.nameEnglish,
    required this.nameNative,
    required this.flagEmoji,
    required this.description,
  });
}

class LanguageData {
  static const List<LanguageOption> supportedLanguages = [
    LanguageOption(
      code: 'en',
      nameEnglish: 'English',
      nameNative: 'English',
      flagEmoji: '🇬🇧',
      description: 'United Kingdom',
    ),
    LanguageOption(
      code: 'ar',
      nameEnglish: 'Arabic',
      nameNative: 'العربية',
      flagEmoji: '🇸🇦',
      description: 'Saudi Arabia',
    ),
  ];
}
