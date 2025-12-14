// custom_drawer.dart
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/global_Settings/data/model/global_Setting_model.dart';
import 'package:almonafs_flutter/features/home/presentation/views/widget/utils/drawer_items_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/router/routes.dart';
import '../../../../localization/manager/localization_cubit.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onNavigationItemTapped;
  final List<SocialMedia>? socialMediaList;

  const CustomDrawer({
    super.key,
    required this.onNavigationItemTapped,
    this.socialMediaList,
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
              color: AppColor.mainWhite,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildDrawerHeader(isArabic),
                  buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/user.svg',
                    title: isArabic ? 'الملف الشخصي' : 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.signUp);
                    },
                  ),
                  buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/translate.svg',
                    title: isArabic ? 'اللغة' : 'Language',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.languageScreen);
                    },
                  ),
                  buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/serves.svg',
                    title: isArabic ? 'الخدمات' : 'Services',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.servicesView);
                    },
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/About Us.svg',
                    title: isArabic ? 'من نحن' : 'About Us',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.aboutUsScreen);
                    },
                  ),
                  buildDrawerItem(
                    context,
                    iconPath: 'assets/icons/setting-2.svg',
                    title: isArabic ? 'الإعدادات' : 'Settings',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.globalSettingsView);
                    },
                  ),
                  
                  // Social Media Section
                  if (socialMediaList != null && socialMediaList!.isNotEmpty) ...[
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        isArabic ? 'تابعنا على' : 'Follow Us',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: socialMediaList!.map((social) {
                          return buildSocialMediaIcon(
                            context,
                            platform: social.platform ?? '',
                            url: social.url ?? '',
                            iconUrl: social.desktopIconUrl,
                            
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}