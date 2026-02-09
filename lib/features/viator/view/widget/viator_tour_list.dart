import 'package:almonafs_flutter/features/viator/manager/viator_cubit.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_state.dart';
import 'package:almonafs_flutter/features/viator/view/viator_tour_details_page.dart';
import 'package:almonafs_flutter/features/viator/view/widget/viator_tour_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViatorTourListWidget extends StatefulWidget {
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
  State<ViatorTourListWidget> createState() => _ViatorTourListWidgetState();
}

class _ViatorTourListWidgetState extends State<ViatorTourListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ViatorCubit>().loadMoreTours();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViatorCubit, ViatorState>(
      builder: (context, state) {
        if (state is ViatorLoading) {
          if (widget.scrollDirection == Axis.vertical) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            height: widget.height ?? 280.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ViatorError) {
          if (widget.scrollDirection == Axis.vertical) {
            return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 14.sp),
              ),
            );
          }
          return SizedBox(
            height: widget.height ?? 280.h,
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
            if (widget.scrollDirection == Axis.vertical) {
              return Center(
                child: Text(
                  widget.isArabic
                      ? 'لا توجد جولات متاحة'
                      : 'No tours available',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              );
            }
            return SizedBox(
              height: widget.height ?? 280.h,
              child: Center(
                child: Text(
                  widget.isArabic
                      ? 'لا توجد جولات متاحة'
                      : 'No tours available',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              ),
            );
          }

          Widget listView = ListView.separated(
            controller: _scrollController, // Attach controller
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            scrollDirection: widget.scrollDirection,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            // Add +1 to item count if loading more to show spinner
            itemCount: state.isLoadingMore
                ? state.tours.length + 1
                : state.tours.length,
            separatorBuilder: (context, index) =>
                widget.scrollDirection == Axis.horizontal
                ? SizedBox(width: 0.w)
                : SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              // Show loading indicator at the end
              if (index >= state.tours.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              final tour = state.tours[index];
              return GestureDetector(
                onTap: () {
                  if (tour.productCode != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViatorTourDetailsPage(
                          productCode: tour.productCode!,
                          title: tour.title,
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: widget.scrollDirection == Axis.horizontal
                      ? EdgeInsets.zero
                      : EdgeInsets.only(
                          bottom: index == state.tours.length - 1 ? 20.h : 0,
                        ),
                  child: widget.scrollDirection == Axis.horizontal
                      ? ViatorTourCard(tour: tour, isArabic: widget.isArabic)
                      : ViatorTourCard(
                          tour: tour,
                          isArabic: widget.isArabic,
                          width: double.infinity,
                        ),
                ),
              );
            },
          );

          if (widget.scrollDirection == Axis.vertical) {
            return listView;
          }

          return SizedBox(height: widget.height ?? 280.h, child: listView);
        } else {
          return widget.scrollDirection == Axis.vertical
              ? const SizedBox()
              : SizedBox(height: widget.height ?? 280.h);
        }
      },
    );
  }
}
