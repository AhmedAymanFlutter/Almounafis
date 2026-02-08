import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../data/model/reviews_mock_data.dart';
import 'review_card.dart';
import 'dart:async';

class ReviewsSection extends StatefulWidget {
  final bool isArabic;

  const ReviewsSection({super.key, required this.isArabic});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Auto-scroll every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < ReviewsMockData.reviews.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = ReviewsMockData.reviews;

    return Column(
      children: [
        // Section Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isArabic ? "آراء العملاء" : "Customer Reviews",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColor.secondaryblue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[700], size: 18.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "4.9",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondaryblue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Reviews Carousel Slider
        SizedBox(
          height: 230.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ReviewCard(review: reviews[index]),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),

        // Carousel Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            reviews.length > 10 ? 10 : reviews.length,
            (index) => Container(
              width: _currentPage == index ? 24.w : 8.w,
              height: 8.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: _currentPage == index
                    ? AppColor.secondaryblue
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
