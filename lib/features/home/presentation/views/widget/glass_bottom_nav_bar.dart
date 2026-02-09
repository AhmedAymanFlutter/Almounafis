import 'dart:ui';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isArabic;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    int visualIndex = 0;
    switch (currentIndex) {
      case 0:
        visualIndex = 0;
        break;
      case 2:
        visualIndex = 1;
        break;
      case 1:
        visualIndex = 2;
        break;
      case 3:
        visualIndex = 3;
        break;
      case 4:
        visualIndex = 4;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                _buildItem(
                  'assets/icons/bag.svg',
                  isArabic ? 'الحجز' : 'Booking',
                ),
                _buildItem(
                  'assets/icons/sleep.svg',
                  isArabic ? 'الفنادق' : 'Hotels',
                ),
                _buildItem(
                  'assets/icons/home.svg',
                  isArabic ? 'الرئيسية' : 'Home',
                ),
                _buildItem(
                  'assets/icons/Packages.svg',
                  isArabic ? 'الباقات' : 'Packages',
                ),
                _buildItem(
                  'assets/icons/city-block-svgrepo-com.svg',
                  isArabic ? 'المدن' : 'Cities',
                ),
              ],
              currentIndex: visualIndex,
              onTap: (index) {
                // Map visual index back to logic index
                int logicIndex = 1;
                switch (index) {
                  case 0:
                    logicIndex = 0;
                    break;
                  case 1:
                    logicIndex = 2;
                    break;
                  case 2:
                    logicIndex = 1;
                    break;
                  case 3:
                    logicIndex = 3;
                    break;
                  case 4:
                    logicIndex = 4;
                    break;
                }
                onTap(logicIndex);
              },
              backgroundColor: AppColor.secondaryblue,
              unselectedItemColor: AppColor.mainWhite,
              selectedItemColor: AppColor.mainColor,
              elevation: 0,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: SvgPicture.asset(
          iconPath,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            AppColor.mainWhite.withOpacity(0.5),
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: SvgPicture.asset(
          iconPath,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(
            AppColor.mainColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      label: label,
    );
  }
}
