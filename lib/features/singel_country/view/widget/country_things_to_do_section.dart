import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_guide_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CountryThingsToDoSection extends StatelessWidget {
  final List<GuidePlace> thingsToDo;

  const CountryThingsToDoSection({super.key, required this.thingsToDo});

  @override
  Widget build(BuildContext context) {
    if (thingsToDo.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Things to Do',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.mainBlack,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 280.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: thingsToDo.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final thing = thingsToDo[index];
              return _buildThingCard(context, thing);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildThingCard(BuildContext context, GuidePlace thing) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.cityGuideDetailsView,
          arguments: thing,
        );
      },
      child: Container(
        width: 220.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: SizedBox(
                height: 140.h,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: thing.images?.firstOrNull?.url ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.local_activity, color: Colors.grey[400]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thing.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.mainBlack,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (thing.type != null)
                    Text(
                      thing.type!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: (thing.rating ?? 0).toDouble(),
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 14.sp,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '(${thing.reviewsCount ?? 0})',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
