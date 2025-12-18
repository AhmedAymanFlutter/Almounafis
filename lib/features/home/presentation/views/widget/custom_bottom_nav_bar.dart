import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isArabic;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColor.secondaryblue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.secondaryblue.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Events Tab (Left)
              _NavBarItem(
                icon: 'assets/icons/bag.svg',
                label: isArabic ? 'الحجز' : 'booking',
                isSelected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              
              // Booking Tab (Center-Left)
              _NavBarItem(
                icon: 'assets/icons/sleep.svg',
                label: isArabic ? 'الفنادق' : 'hotels',
                isSelected: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              // Empty space for Home (will be in Stack)
              const SizedBox(width: 60),
              // Profile Tab (Center-Right)
              _NavBarItem(
                icon: 'assets/icons/Packages.svg',
                label: isArabic ? 'الحزم' : 'packages',
                isSelected: currentIndex == 3,
                onTap: () => onTap(3),
              ),
              _NavBarItem(
                icon: 'assets/icons/city-block-svgrepo-com.svg',
                label: isArabic ? 'الحزم' : 'cites',
                isSelected: currentIndex == 4,
                onTap: () => onTap(4),
              ),

            ],
          ),
        ),
        // Home Tab - Centered and Highlighted
        Positioned(
          left: 0,
          right: 0,
          bottom: 15,
          child: Center(
            child: _NavBarItem(
              icon: 'assets/icons/home.svg',
              label: isArabic ? 'الرئيسية' : 'Home',
              isSelected: currentIndex == 1,
              onTap: () => onTap(1),
              isCenter: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isCenter;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: isSelected || isCenter
                ? BoxDecoration(
                    color: isCenter 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: isCenter
                        ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  )
                : null,
            child: SvgPicture.asset(
              icon,
              width: isCenter ? 28 : 24,
              height: isCenter ? 28 : 24,
              colorFilter: ColorFilter.mode(
                isCenter 
                    ? AppColor.secondaryblue 
                    : (isSelected ? Colors.white : Colors.grey[300]!),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyle.setPoppinsWhite(
              fontSize: isCenter ? 11 : 10,
              fontWeight: isCenter ? FontWeight.w600 : FontWeight.w500,
            ).copyWith(
              color: isCenter 
                  ? Colors.white 
                  : (isSelected ? Colors.white : Colors.grey[300]),
            ),
          ),
        ],
      ),
    );
  }
}
