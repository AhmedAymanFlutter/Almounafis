import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/account_info_header.dart';
import 'package:flutter/material.dart';

import '../../servicepackadge/view/Service_view.dart';

import '../widget/About_us.dart';
import '../widget/card_sitting.dart';
import '../widget/languang.dart';

class SittingScreen extends StatelessWidget {
  const SittingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryblue,
      body: SafeArea(
        child: Column(
          children: [
            const AccountInfoHeader(),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      MenuItemWidget(
                        title: 'Languange',
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LanguageScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        iconPath: 'assets/icons/translate.svg',
                      ),
                      SizedBox(height: 10),
                      MenuItemWidget(
                        title: 'Services',
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ServicesView(),
                            ),
                            (route) => false,
                          );
                        },
                        iconPath: 'assets/icons/serves.svg',
                      ),
                      SizedBox(height: 10),
                      MenuItemWidget(
                        title: 'Packages',
                        onTap: () {},
                        iconPath: 'assets/icons/packdg.svg',
                      ),
                      SizedBox(height: 10),
                      MenuItemWidget(
                        title: 'About Us',
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutUsScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        iconPath: 'assets/icons/About Us.svg',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
