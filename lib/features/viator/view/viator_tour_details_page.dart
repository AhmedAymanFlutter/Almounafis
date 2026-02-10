import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/data/repo/viator_repo.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_cubit.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_state.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_booking_bottom_bar.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_exclusions_widget.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_image_gallery.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_inclusions_widget.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_itinerary_widget.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_reviews_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViatorTourDetailsPage extends StatelessWidget {
  final String productCode;
  final String? title;

  const ViatorTourDetailsPage({
    super.key,
    required this.productCode,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Get current language
    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;
    final currentLang = isArabic ? 'ar' : 'en';

    return BlocProvider(
      create: (context) =>
          ViatorCubit(ViatorRepository())
            ..fetchTourDetails(productCode, lang: currentLang),
      child: BlocListener<LanguageCubit, AppLanguage>(
        listener: (context, langState) {
          // Refetch tour details when language changes
          final isArabic = langState == AppLanguage.arabic;
          final lang = isArabic ? 'ar' : 'en';
          debugPrint(
            '🌍 Language changed in Tour Details, refetching with lang: $lang',
          );
          context.read<ViatorCubit>().fetchTourDetails(productCode, lang: lang);
        },
        child: Scaffold(
          backgroundColor: AppColor.mainWhite,
          bottomNavigationBar: BlocBuilder<ViatorCubit, ViatorState>(
            builder: (context, state) {
              if (state is ViatorTourDetailsLoaded) {
                return TourBookingBottomBar(tour: state.tour);
              }
              return const SizedBox();
            },
          ),
          body: SafeArea(
            child: BlocBuilder<ViatorCubit, ViatorState>(
              builder: (context, state) {
                if (state is ViatorLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.mainColor),
                  );
                } else if (state is ViatorError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppTextStyle.setPoppinsSecondlightGrey(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                } else if (state is ViatorTourDetailsLoaded) {
                  return _buildDetails(context, state.tour);
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context, ViatorTour tour) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320.h,
          pinned: true,
          backgroundColor: AppColor.mainWhite,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: TourImageGallery(
              images: tour.images,
              coverImage: tour.coverImage,
            ),
          ),
          leading: Container(
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColor.mainWhite.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColor.mainBlack),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tour.title ?? '',
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: Colors.amber, size: 22.sp),
                    SizedBox(width: 6.w),
                    Text(
                      '${tour.rating?.average ?? 0}',
                      style: AppTextStyle.setPoppinsBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' (${tour.rating?.count ?? 0} reviews)',
                      style: AppTextStyle.setPoppinssecondaryGery(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                if (tour.itinerary?.duration?.fixedDurationInMinutes !=
                    null) ...[
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColor.primaryWhite,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColor.lightGrey.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          size: 20.sp,
                          color: AppColor.secondaryblue,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${tour.itinerary!.duration!.fixedDurationInMinutes! ~/ 60}h ${tour.itinerary!.duration!.fixedDurationInMinutes! % 60}m',
                          style: AppTextStyle.setPoppinsSecondaryBlack(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                _buildSectionTitle('Description'),
                HtmlContentWidget(
                  htmlContent:
                      tour.description ?? '<p>No description available.</p>',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textColor: AppColor.secondaryGrey,
                ),
                SizedBox(height: 24.h),

                if (tour.pricingInfo != null &&
                    tour.pricingInfo!.ageBands != null) ...[
                  _buildSectionTitle('Pricing & Ages'),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: tour.pricingInfo!.ageBands!.map((band) {
                      return Chip(
                        backgroundColor: AppColor.primaryWhite,
                        side: BorderSide(
                          color: AppColor.lightGrey.withOpacity(0.3),
                        ),
                        avatar: Icon(
                          Icons.person_outline,
                          size: 18.sp,
                          color: AppColor.secondaryblue,
                        ),
                        label: Text(
                          '${band.ageBand} (${band.startAge}-${band.endAge})',
                          style: AppTextStyle.setPoppinsSecondaryBlack(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),
                ],

                if (tour.logistics != null) ...[
                  _buildSectionTitle('Meeting & Pickup'),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.lightGrey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tour.logistics!.start != null)
                          ...tour.logistics!.start!.map(
                            (p) => Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: AppColor.secondaryblue,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      'Start: ${p.description ?? ""}',
                                      style:
                                          AppTextStyle.setPoppinsSecondaryBlack(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (tour.logistics!.end != null)
                          ...tour.logistics!.end!.map(
                            (p) => Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.flag_outlined,
                                    color: AppColor.secondaryblue,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      'End: ${p.description ?? ""}',
                                      style:
                                          AppTextStyle.setPoppinsSecondaryBlack(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                if (tour.cancellationPolicy != null) ...[
                  _buildSectionTitle('Cancellation Policy'),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColor.primaryWhite,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HtmlContentWidget(
                          htmlContent:
                              tour.cancellationPolicy!.description ?? '<p></p>',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          textColor: AppColor.secondaryBlack,
                        ),
                        if (tour.cancellationPolicy!.refundEligibility != null)
                          ...tour.cancellationPolicy!.refundEligibility!.map(
                            (r) => Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 16.sp,
                                    color: AppColor.secondaryGrey,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      '${r.percentageRefundable}% refund if cancelled ${r.dayRangeMin} day(s) prior',
                                      style:
                                          AppTextStyle.setPoppinssecondaryGery(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                if (tour.itinerary != null) ...[
                  _buildSectionTitle('Itinerary'),
                  TourItineraryWidget(itinerary: tour.itinerary!),
                  SizedBox(height: 24.h),
                ],

                if (tour.inclusions != null && tour.inclusions!.isNotEmpty) ...[
                  _buildSectionTitle('What\'s Included'),
                  TourInclusionsWidget(inclusions: tour.inclusions!),
                  SizedBox(height: 24.h),
                ],

                if (tour.exclusions != null && tour.exclusions!.isNotEmpty) ...[
                  _buildSectionTitle('What\'s Excluded'),
                  TourExclusionsWidget(exclusions: tour.exclusions!),
                  SizedBox(height: 24.h),
                ],

                if (tour.ticketInfo != null) ...[
                  _buildSectionTitle('Ticket Info'),
                  Text(
                    tour.ticketInfo!.ticketTypeDescription ?? '',
                    style: AppTextStyle.setPoppinsSecondaryBlack(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                if (tour.additionalInfo != null &&
                    tour.additionalInfo!.isNotEmpty) ...[
                  _buildSectionTitle('Additional Info'),
                  ...tour.additionalInfo!.map(
                    (e) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 18.sp,
                            color: AppColor.secondaryblue,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              e.description ?? '',
                              style: AppTextStyle.setPoppinsSecondaryBlack(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                if (tour.reviews != null &&
                    tour.reviews!.reviewCountTotals != null) ...[
                  _buildSectionTitle('Reviews Breakdown'),
                  TourReviewsWidget(reviews: tour.reviews!),
                  SizedBox(height: 100.h),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: AppTextStyle.setPoppinsBlack(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
