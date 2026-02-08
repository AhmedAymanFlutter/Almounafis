import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/model/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header: Profile pic, name, and rating
          Row(
            children: [
              // Profile Picture
              ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: CachedNetworkImage(
                  imageUrl: review.profilePic,
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: Colors.grey[600]),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Name and user info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.username,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      review.userInfo,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Star Rating
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < review.stars ? Icons.star : Icons.star_border,
                color: Colors.amber[700],
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Comment
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),

          // Date
          Text(
            review.commentDate,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
