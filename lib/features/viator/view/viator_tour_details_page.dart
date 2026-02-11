import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/data/repo/viator_repo.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_cubit.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_state.dart';
import 'package:almonafs_flutter/features/viator/resources/viator_strings.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_about_section.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_additional_info_section.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_booking_bottom_bar.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_booking_info_section.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_cancellation_section.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_header_section.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_image_gallery.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_itinerary_widget.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_logistics_section.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_options_section.dart';
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
    // Define isArabic here to use in the widget tree
    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

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
                TourHeaderSection(tour: tour),
                TourBookingInfoSection(tour: tour),
                TourAboutSection(tour: tour),
                TourOptionsSection(tour: tour),
                TourLogisticsSection(tour: tour),
                TourCancellationSection(tour: tour),

                if (tour.itinerary != null) ...[
                  _buildSectionTitle(
                    isArabic
                        ? ViatorStringsAr.itinerary
                        : ViatorStringsEn.itinerary,
                  ),
                  TourItineraryWidget(itinerary: tour.itinerary!),
                  SizedBox(height: 24.h),
                ],

                TourAdditionalInfoSection(tour: tour),

                if (tour.reviews != null &&
                    tour.reviews!.reviewCountTotals != null) ...[
                  _buildSectionTitle(
                    isArabic
                        ? ViatorStringsAr.reviewsBreakdown
                        : ViatorStringsEn.reviewsBreakdown,
                  ),
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
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
