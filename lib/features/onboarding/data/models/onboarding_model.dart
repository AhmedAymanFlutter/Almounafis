import 'package:almonafs_flutter/features/onboarding/data/onboarding_strings.dart';

class OnboardingContent {
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;
  final String imagePath;

  const OnboardingContent({
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.imagePath,
  });

  String getTitle(bool isArabic) => isArabic ? titleAr : titleEn;
  String getDescription(bool isArabic) =>
      isArabic ? descriptionAr : descriptionEn;
}

class OnboardingData {
  static const List<OnboardingContent> pages = [
    OnboardingContent(
      titleEn: OnboardingStrings.title1En,
      titleAr: OnboardingStrings.title1Ar,
      descriptionEn: OnboardingStrings.description1En,
      descriptionAr: OnboardingStrings.description1Ar,
      imagePath: 'assets/images/onboarding1.png',
    ),
    OnboardingContent(
      titleEn: OnboardingStrings.title2En,
      titleAr: OnboardingStrings.title2Ar,
      descriptionEn: OnboardingStrings.description2En,
      descriptionAr: OnboardingStrings.description2Ar,
      imagePath: 'assets/images/onboarding2.png',
    ),
    OnboardingContent(
      titleEn: OnboardingStrings.title3En,
      titleAr: OnboardingStrings.title3Ar,
      descriptionEn: OnboardingStrings.description3En,
      descriptionAr: OnboardingStrings.description3Ar,
      imagePath: 'assets/images/onboarding3.png',
    ),
  ];
}
