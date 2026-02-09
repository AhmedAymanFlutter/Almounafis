import 'package:almonafs_flutter/core/helper/Fun_helper.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/global_Settings/data/model/global_Setting_model.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourBookingBottomBar extends StatelessWidget {
  final ViatorTour tour;

  const TourBookingBottomBar({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.mainWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainBlack.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'From',
                style: AppTextStyle.setPoppinssecondaryGery(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                '${tour.price?.amount ?? 0} ${tour.price?.currency ?? "USD"}',
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ).copyWith(color: AppColor.lightBlue),
              ),
            ],
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final isArabic =
                    context.read<LanguageCubit>().state == AppLanguage.arabic;
                final globalSettingsState = context
                    .read<GlobalSettingsCubit>()
                    .state;
                GlobalSettingModel? settings;
                if (globalSettingsState is GlobalSettingsLoaded) {
                  settings = globalSettingsState.globalSettings;
                }

                final tourName = tour.title ?? "Tour";
                final message = isArabic
                    ? "أرغب في حجز $tourName"
                    : "I want to book $tourName";

                WhatsAppService.launchWhatsApp(
                  context,
                  isArabic: isArabic,
                  customMessage: message,
                  settings: settings,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.mainColor,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Check Availability',
                style: AppTextStyle.setPoppinsWhite(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
