import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart' show Shimmer;

class ShimmerLoader extends StatelessWidget {
  final int itemCount;
  final double height;
  final double itemWidth;
  final double spacing;
  final Axis scrollDirection;

  const ShimmerLoader({
    super.key,
    required this.itemCount ,
    required this.height ,
    required this.itemWidth ,
    required this.spacing, required this.scrollDirection ,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Shimmer(
        duration: const Duration(seconds: 2),
        color: Colors.grey.shade400,
        colorOpacity: 0.3,
        enabled: true,
        child: ListView.separated(
          scrollDirection: scrollDirection,
          itemCount: itemCount,
          separatorBuilder: (_, __) => SizedBox(width: spacing),
          itemBuilder: (context, index) {
            return Container(
              width: itemWidth,
              height: height,
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),
      ),
    );
  }
}