import 'package:almonafs_flutter/features/viator/manager/viator_cubit.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_state.dart';
import 'package:almonafs_flutter/features/viator/view/widget/viator_tour_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViatorTourListWidget extends StatelessWidget {
  final bool isArabic;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double? height;

  const ViatorTourListWidget({
    super.key,
    required this.isArabic,
    this.scrollDirection = Axis.horizontal,
    this.physics,
    this.shrinkWrap = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViatorCubit, ViatorState>(
      builder: (context, state) {
        if (state is ViatorLoading) {
          if (scrollDirection == Axis.vertical) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            height: height ?? 280.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ViatorError) {
          if (scrollDirection == Axis.vertical) {
            return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 14.sp),
              ),
            );
          }
          return SizedBox(
            height: height ?? 280.h,
            child: Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 14.sp),
              ),
            ),
          );
        } else if (state is ViatorLoaded) {
          if (state.tours.isEmpty) {
            if (scrollDirection == Axis.vertical) {
              return Center(
                child: Text(
                  isArabic ? 'لا توجد جولات متاحة' : 'No tours available',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              );
            }
            return SizedBox(
              height: height ?? 280.h,
              child: Center(
                child: Text(
                  isArabic ? 'لا توجد جولات متاحة' : 'No tours available',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              ),
            );
          }

          Widget listView = ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            scrollDirection: scrollDirection,
            physics: physics,
            shrinkWrap: shrinkWrap,
            itemCount: state.tours.length,
            separatorBuilder: (context, index) =>
                scrollDirection == Axis.horizontal
                ? SizedBox(width: 0.w)
                : SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final tour = state.tours[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to details (To be implemented or repurposed)
                },
                child: Padding(
                  padding: scrollDirection == Axis.horizontal
                      ? EdgeInsets.zero
                      : EdgeInsets.only(
                          bottom: index == state.tours.length - 1 ? 20.h : 0,
                        ),
                  child: scrollDirection == Axis.horizontal
                      ? ViatorTourCard(tour: tour, isArabic: isArabic)
                      : ViatorTourCard(
                          tour: tour,
                          isArabic: isArabic,
                          width: double.infinity,
                        ),
                ),
              );
            },
          );

          if (scrollDirection == Axis.vertical) {
            return listView;
          }

          return SizedBox(height: height ?? 280.h, child: listView);
        } else {
          return scrollDirection == Axis.vertical
              ? const SizedBox()
              : SizedBox(height: height ?? 280.h);
        }
      },
    );
  }
}
