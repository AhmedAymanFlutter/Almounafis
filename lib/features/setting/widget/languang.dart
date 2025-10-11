import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../../auth/presentation/widgets/account_info_header.dart';
import '../../localization/manager/localization_cubit.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Scaffold(
          backgroundColor: const Color(0xff0e2e4f),
          body: SafeArea(
            child: Column(
              children: [
                const AccountInfoHeader(),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/translate.svg',
                            color: const Color(0xFF292D32),
                            width: 48,
                            height: 48,
                          ),
                          Text(
                            ' Language',
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColor.secondaryBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      LanguageCard(
                        title: 'English (UK)',
                        isSelected: !isArabic,
                        onTap: () {
                          context
                              .read<LanguageCubit>()
                              .setLanguage(AppLanguage.english);
                        },
                      ),
                      const SizedBox(height: 30),

                      LanguageCard(
                        title: 'العربية',
                        isSelected: isArabic,
                        onTap: () {
                          context
                              .read<LanguageCubit>()
                              .setLanguage(AppLanguage.arabic);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LanguageCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xff0e2e4f) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xff0e2e4f)
                      : Colors.black87,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color:
                  isSelected ? const Color(0xff0e2e4f) : Colors.grey.shade400,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
