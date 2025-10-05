import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/account_info_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'en'; // 'en' or 'ar'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e2e4f),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AccountInfoHeader(),
              const SizedBox(height: 20),
             
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/translate.svg',color: Color(0xFF292D32),width: 48,height: 48,),
                  Text(' Language',style: AppTextStyle.setPoppinsTextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColor.secondaryBlack))  
                ],
              ),
              SizedBox(height: 30),
                    LanguageCard(
                      title: 'English (UK)',
                      isSelected: selectedLanguage == 'en',
                      onTap: () {
                        setState(() {
                          selectedLanguage = 'en';
                        });
                        // Add your locale change logic here
                        // Example: context.setLocale(Locale('en', 'GB'));
                      },
                    ),
                    SizedBox(height: 30),
                    LanguageCard(
                      title: 'العربيه',
                      isSelected: selectedLanguage == 'ar',
                      onTap: () {
                        setState(() {
                          selectedLanguage = 'ar';
                        });
                        // Add your locale change logic here
                        // Example: context.setLocale(Locale('ar'));
                      },
                    ),
                    const SizedBox(
                      height: 900,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? const Color(0xff0e2e4f) 
                : Colors.grey.shade300,
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
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xff0e2e4f),
                size: 24,
              )
            else
              Icon(
                Icons.circle_outlined,
                color: Colors.grey.shade400,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}