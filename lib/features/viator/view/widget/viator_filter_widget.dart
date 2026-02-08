import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViatorFilterWidget extends StatefulWidget {
  const ViatorFilterWidget({super.key});

  @override
  State<ViatorFilterWidget> createState() => _ViatorFilterWidgetState();
}

class _ViatorFilterWidgetState extends State<ViatorFilterWidget> {
  final TextEditingController _searchController = TextEditingController();
  // Timer for debouncing search
  // Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    // _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViatorCubit>();
    // Assuming context provides the cubit

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search tours...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(
                vertical: 0.h,
                horizontal: 16.w,
              ),
            ),
            onSubmitted: (value) {
              cubit.fetchTours(search: value);
            },
          ),
          SizedBox(height: 16.h),

          // Filters Row (Horizontal Scroll)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Rating Filter
                _buildFilterChip(
                  label: 'Rating 4+',
                  onSelected: (selected) {
                    cubit.fetchTours(minRating: selected ? 4.0 : null);
                  },
                ),
                SizedBox(width: 8.w),

                // Cancellation Filter
                _buildFilterChip(
                  label: 'Free Cancellation',
                  onSelected: (selected) {
                    cubit.fetchTours(
                      cancellationType: selected ? 'FREE_CANCELLATION' : null,
                    );
                  },
                ),
                SizedBox(width: 8.w),

                // Sort Filter (Simplified for now)
                PopupMenuButton<String>(
                  icon: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryblue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.secondaryblue),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          size: 16.sp,
                          color: AppColor.secondaryblue,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Sort',
                          style: TextStyle(
                            color: AppColor.secondaryblue,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onSelected: (value) {
                    cubit.fetchTours(sort: value);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'top-rated',
                      child: Text('Top Rated'),
                    ),
                    const PopupMenuItem(
                      value: 'price-low',
                      child: Text('Price: Low to High'),
                    ),
                    const PopupMenuItem(
                      value: 'price-high',
                      child: Text('Price: High to Low'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Text(label),
      onSelected: onSelected,
      backgroundColor: Colors.grey[100],
      selectedColor: AppColor.secondaryblue.withOpacity(0.2),
      checkmarkColor: AppColor.secondaryblue,
      labelStyle: TextStyle(fontSize: 12.sp, color: AppColor.mainBlack),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey[300]!),
      ),
    );
  }
}
