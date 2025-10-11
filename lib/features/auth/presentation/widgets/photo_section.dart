import 'package:almonafs_flutter/core/helper/text_helper.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../localization/manager/localization_cubit.dart';

class PhotoSection extends StatelessWidget {
  const PhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(color: AppColor.lightGrey),
            ),
            color: AppColor.primaryWhite,
            child: ListTile(
              leading: CircleAvatar(
                radius: 28.r,
                backgroundImage: const AssetImage("assets/images/download.png"),
              ),
              title: Text(
                isArabic ? TextHelperAr.yourPhoto : TextHelperEn.yourPhoto,
                style: AppTextStyle.setPoppinsSecondaryBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                isArabic ? TextHelperAr.addPhoto : TextHelperEn.addPhoto,
                style: AppTextStyle.setPoppinsSecondlightGrey(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
