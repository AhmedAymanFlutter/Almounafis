import 'package:almonafs_flutter/core/helper/app_images.dart';
import 'package:almonafs_flutter/core/helper/text_helper.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountInfoHeader extends StatelessWidget {
  const AccountInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            TextHelper.skip,
            style: AppTextStyle.setPoppinsWhite(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeView()),
                (route) => false,
              );
            },
            icon: SvgPicture.asset(AppImages.arrowIcon),
          ),
        ],
      ),
    );
  }
}
