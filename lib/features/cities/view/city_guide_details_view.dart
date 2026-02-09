import 'package:almonafs_flutter/core/helper/Fun_helper.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_guide_model.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CityGuideDetailsView extends StatelessWidget {
  final GuidePlace place;

  const CityGuideDetailsView({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: place.images?.firstOrNull?.url ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          place.name ?? '',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.mainBlack,
                          ),
                        ),
                      ),
                      if (place.rating != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RatingBarIndicator(
                              rating: place.rating!.toDouble(),
                              itemBuilder: (context, index) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 18.sp,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${place.reviewsCount ?? 0} reviews',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  if (place.type != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.mainColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        place.type!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(height: 24.h),
                  if (place.description != null) ...[
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.mainBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    HtmlContentWidget(
                      htmlContent: place.description ?? '<p></p>',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      textColor: Colors.grey[800]!,
                    ),
                    SizedBox(height: 24.h),
                  ],
                  if (place.location?.address != null) ...[
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.mainBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColor.mainColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            place.location!.address!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (place.location?.googleMapsUrl != null) ...[
                      SizedBox(height: 12.h),
                      TextButton.icon(
                        onPressed: () async {
                          final uri = Uri.parse(place.location!.googleMapsUrl!);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        icon: const Icon(Icons.map, color: AppColor.mainColor),
                        label: const Text(
                          "View on Google Maps",
                          style: TextStyle(color: AppColor.mainColor),
                        ),
                      ),
                    ],
                    SizedBox(height: 24.h),
                  ],
                  // Book Now via WhatsApp
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final globalSettingsState = context
                            .read<GlobalSettingsCubit>()
                            .state;

                        if (globalSettingsState is GlobalSettingsLoaded) {
                          WhatsAppService.launchWhatsApp(
                            context,
                            isArabic: context.read<LanguageCubit>().isArabic,
                            settings: globalSettingsState.globalSettings,
                            customMessage:
                                'I would like to book: ${place.name ?? ''}',
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Loading settings..."),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      icon: const Icon(Icons.send, color: Colors.white),
                      label: Text(
                        "Book via WhatsApp",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
