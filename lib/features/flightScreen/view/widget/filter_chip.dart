import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../localization/manager/localization_cubit.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _translateLabel(label, isArabic),
                    style: AppTextStyle.setPoppinsTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondaryBlack,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ✅ ترجمة بسيطة حسب اللغة
  String _translateLabel(String label, bool isArabic) {
    if (!isArabic) return label;

    switch (label.toLowerCase()) {
      case 'passengers':
        return 'الركاب';
      case 'airlines':
        return 'شركات الطيران';
      case 'class':
        return 'الدرجة';
      case 'date':
        return 'التاريخ';
      case 'filter':
        return 'تصفية';
      default:
        return label;
    }
  }
}
