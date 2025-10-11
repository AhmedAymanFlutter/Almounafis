import 'package:almonafs_flutter/core/helper/app_images.dart';
import 'package:almonafs_flutter/core/helper/text_helper.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../localization/manager/localization_cubit.dart';

class AccountInfoHeader extends StatelessWidget {
  const AccountInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment:
                isArabic ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (isArabic)
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeView()),
                      (route) => false,
                    );
                  },
                  icon: Transform.rotate(
                    angle: 3.14, // عكس السهم للاتجاه العربي
                    child: SvgPicture.asset(AppImages.arrowIcon),
                  ),
                ),
              Text(
                isArabic ? TextHelperAr.skip : TextHelperEn.skip,
                style: AppTextStyle.setPoppinsWhite(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (!isArabic)
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeView()),
                      (route) => false,
                    );
                  },
                  icon: SvgPicture.asset(AppImages.arrowIcon),
                ),
            ],
          ),
        );
      },
    );
  }
}
