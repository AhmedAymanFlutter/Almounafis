import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../localization/manager/localization_cubit.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const SectionTitle({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              isArabic ? "عرض الكل" : "See all",
              style: TextStyle(color: AppColor.secondaryblue),
            ),
          ),
        ],
      ),
    );
  }
}
