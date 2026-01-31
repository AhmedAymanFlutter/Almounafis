import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';

class ModernPromoSlider extends StatefulWidget {
  final bool isArabic;
  const ModernPromoSlider({super.key, required this.isArabic});

  @override
  State<ModernPromoSlider> createState() => _ModernPromoSliderState();
}

class _ModernPromoSliderState extends State<ModernPromoSlider> {
  int _current = 0;
  final PageController _controller = PageController(viewportFraction: 0.9);
  Timer? _timer;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.hasClients) {
        if (_current < imgList.length - 1) {
          _current++;
        } else {
          _current = 0;
        }
        _controller.animateToPage(
          _current,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: imgList.length,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            itemBuilder: (context, index) {
              return Transform.scale(
                scale: _current == index
                    ? 1.0
                    : 0.9, // Simulate enlargeCenterPage
                child: _buildPromoCard(imgList[index]),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(
                entry.key,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _current == entry.key ? 20.w : 8.w,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: _current == entry.key
                      ? AppColor.secondaryblue
                      : Colors.grey.shade300,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPromoCard(String imageUrl) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isArabic ? 'خصم 20٪' : '20% OFF',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.isArabic
                  ? 'على رحلتك القادمة إلى باريس'
                  : 'On your next trip to Paris',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
