import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../localization/manager/localization_cubit.dart';

Widget buildNavItem({
  required String icon,
  required String label,
  required bool isSelected,
}) {
  final double iconSize = label == "Home" ? 20 : 24;

  return BlocBuilder<LanguageCubit, AppLanguage>(
    builder: (context, langState) {
      bool isArabic = langState == AppLanguage.arabic;
      String translatedLabel = _translateLabel(label, isArabic);

      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: SizedBox(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: iconSize,
                width: iconSize,
                child: SvgPicture.asset(
                  icon,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColor.mainBlack : AppColor.mainWhite,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                translatedLabel,
                style: AppTextStyle.setPoppinsTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? AppColor.mainBlack
                      : AppColor.mainWhite,
                      
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

String _translateLabel(String label, bool isArabic) {
  if (!isArabic) return label;

  switch (label.toLowerCase()) {
    case 'home':
      return 'الرئيسية';
    case 'tours':
      return 'الجولات';
    case 'hotels':
      return 'الفنادق';
    case 'packages':
      return 'الباقات';
   
    default:
      return label;
  }
}
