import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/repo/package_repo.dart';
import '../../manager/package_cubit.dart';
import '../../manager/package_state.dart';

class PackageDetailsView extends StatelessWidget {
  final String packageId;
  final String packageTitle;

  const PackageDetailsView({
    super.key,
    required this.packageId,
    required this.packageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PackageCubit(PackageTypeRepo())
          ..getPackageDetails(packageId),
      child: Scaffold(
        body: BlocBuilder<PackageCubit, PackageState>(
          builder: (context, state) {
            if (state is PackageDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PackageDetailsLoaded) {
              final details = state.packageDetails.data?.first;
              
              if (details == null) {
                return const Center(child: Text('No details available'));
              }
              return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 56),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hero Image with back button
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                     30.r
                                    ),
                                    child: Image.network(
                                      details.imageCover ?? '',
                                      height: 650.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Container(
                                        height: 650.h,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.broken_image,
                                            size: 50, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  // Gradient overlay
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30.r),
                                        bottomRight: Radius.circular(30.r),
                                      ),
                                      child: Container(
                                        height: 650.h,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.6),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Back button
                                  Positioned(
                                    top: 16.h,
                                    left: 16.w,
                                    child: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 18.sp,
                                          color: AppColor.mainBlack,
                                        ),
                                      ),
                                    ),
                                  ),          
                                  // Title and location at bottom of image
                                  Positioned(
                                    bottom: 16.h,
                                    left: 16.w,
                                    right: 16.w,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          details.name ?? 'No title',
                                          style: AppTextStyle.setPoppinsTextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                       
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Content section
                              Padding(
                                padding: EdgeInsets.all(20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Estimate duration
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ESTIMATE',
                                            style:
                                                AppTextStyle.setPoppinsTextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.lightGrey,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            '3D 2N',
                                            style:
                                                AppTextStyle.setPoppinsTextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.mainBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    // Description section
                                    Text(
                                      'Description',
                                      style: AppTextStyle.setPoppinsTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.mainBlack,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      details.description ??
                                          'No description available',
                                      style: AppTextStyle.setPoppinsTextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.lightGrey,
                                       
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    // Choose date section
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Choose date',
                                          style: AppTextStyle.setPoppinsTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.mainBlack,
                                          ),
                                        ),
                                        Icon(
                                          Icons.info_outline,
                                          size: 18.sp,
                                          color: AppColor.lightGrey,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),
                                    // Date picker placeholder
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14.w,
                                        vertical: 12.h,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Select your preferred dates',
                                            style:
                                                AppTextStyle.setPoppinsTextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.lightGrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.calendar_today,
                                            size: 18.sp,
                                            color: AppColor.lightGrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 80.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Floating booking button
                        Positioned(
                          bottom: 20.h,
                          left: 20.w,
                          right: 20.w,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle WhatsApp booking
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Opening WhatsApp...'),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFF1D8DEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.r),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14.h),
                                    ),
                                    child: Text(
                                      'Book Now via WhatsApp',
                                      style: AppTextStyle.setPoppinsTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
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
                ),
              );
            } else if (state is PackageError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}