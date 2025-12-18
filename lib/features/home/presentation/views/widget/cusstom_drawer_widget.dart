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
  final SocialMediaSection? socialMedia;

  const CustomDrawer({
    super.key,
    required this.onNavigationItemTapped,
    this.socialMedia,
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
                  if (socialMedia != null) ...[
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          if (socialMedia!.facebook != null)
                            buildSocialMediaIcon(
                              context,
                              platform: 'Facebook',
                              url: socialMedia!.facebook!.url ?? '',
                              iconUrl: socialMedia!.facebook!.mobileIcon,
                            ),
                          if (socialMedia!.instagram != null)
                            buildSocialMediaIcon(
                              context,
                              platform: 'Instagram',
                              url: socialMedia!.instagram!.url ?? '',
                              iconUrl: socialMedia!.instagram!.mobileIcon,
                            ),
                          if (socialMedia!.twitter != null)
                            buildSocialMediaIcon(
                              context,
                              platform: 'Twitter',
                              url: socialMedia!.twitter!.url ?? '',
                              iconUrl: socialMedia!.twitter!.mobileIcon,
                            ),
                          if (socialMedia!.youtube != null)
                            buildSocialMediaIcon(
                              context,
                              platform: 'YouTube',
                              url: socialMedia!.youtube!.url ?? '',
                              iconUrl: socialMedia!.youtube!.mobileIcon,
                            ),
                          if (socialMedia!.linkedin != null)
                            buildSocialMediaIcon(
                              context,
                              platform: 'LinkedIn',
                              url: socialMedia!.linkedin!.url ?? '',
                              iconUrl: socialMedia!.linkedin!.mobileIcon,
                            ),
                          if (socialMedia!.snapchat != null)
                            buildSocialMediaIcon(
                              context,
                              platform: 'Snapchat',
                              url: socialMedia!.snapchat!.url ?? '',
                              iconUrl: socialMedia!.snapchat!.mobileIcon,
                            ),
                          if (socialMedia!.tiktok != null)
                            buildSocialMediaIcon(
                              context,
                              platform: 'TikTok',
                              url: socialMedia!.tiktok!.url ?? '',
                              iconUrl: socialMedia!.tiktok!.mobileIcon,
                            ),
                        ],
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
