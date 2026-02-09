import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourImageGallery extends StatefulWidget {
  final List<TourImage>? images;
  final String? coverImage;

  const TourImageGallery({super.key, this.images, this.coverImage});

  @override
  State<TourImageGallery> createState() => _TourImageGalleryState();
}

class _TourImageGalleryState extends State<TourImageGallery> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images == null || widget.images!.isEmpty) {
      if (widget.coverImage != null) {
        return Image.network(
          widget.coverImage!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image,
            size: 50,
            color: AppColor.secondaryGrey,
          ),
        );
      }
      return Container(color: AppColor.primaryWhite);
    }

    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.images!.length,
          onPageChanged: (value) {
            setState(() {
              _currentPage = value;
            });
          },
          itemBuilder: (context, index) {
            return Image.network(
              widget.images![index].url ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 50,
                color: AppColor.secondaryGrey,
              ),
            );
          },
        ),
        Positioned(
          bottom: 16.h,
          right: 20.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColor.mainBlack.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '${_currentPage + 1} / ${widget.images!.length}',
              style: TextStyle(color: AppColor.mainWhite, fontSize: 12.sp),
            ),
          ),
        ),
      ],
    );
  }
}
