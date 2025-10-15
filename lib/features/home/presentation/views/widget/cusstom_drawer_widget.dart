// custom_drawer.dart
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../config/router/routes.dart';
import '../../../../localization/manager/localization_cubit.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onNavigationItemTapped;

  const CustomDrawer({
    super.key,
    required this.onNavigationItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Drawer(
            child: Container(
              width: 356,
              height: 861,
              color: AppColor.mainWhite,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerHeader(isArabic),
                  _buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/user.svg',
                    title: isArabic ? 'الملف الشخصي' : 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.signUp);
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/translate.svg',
                    title: isArabic ? 'اللغة' : 'Language',
                    onTap: () {
                 Navigator.pop(context);
                Navigator.pushNamed(context, Routes.languageScreen);
                  }, 

                  ),
                  _buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/serves.svg',
                    title: isArabic ? 'الخدمات' : 'Services',
                   onTap: () {
  Navigator.pop(context);
  Navigator.pushNamed(context, Routes.servicesView);
},

                  ),
                  _buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/Packages.svg',
                    title: isArabic ? 'الباقات' : 'Packages',
                    onTap: () {
  Navigator.pushNamed(context, Routes.packageView);
},

                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  _buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/About Us.svg',
                    title: isArabic ? 'من نحن' : 'About Us',
                    onTap: () {
  Navigator.pushNamed(context, Routes.aboutUsScreen);
},

                  ),
                  _buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/setting-2.svg',
                    title: isArabic ? 'الإعدادات' : 'Settings',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.globalSettingsView);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawerHeader(bool isArabic) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color(0xff0e2e4f),
      ),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/splash/main_logo.png',
              width: 48,
              height: 48,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isArabic ? 'مرحبًا بك' : 'Welcome User',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        color: textColor ?? const Color(0xff0e2e4f),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: textColor ?? Colors.black87,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.grey.shade100,
    );
  }
}
