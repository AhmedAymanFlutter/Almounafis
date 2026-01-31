import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';

class CategoryFilterList extends StatefulWidget {
  final bool isArabic;
  const CategoryFilterList({super.key, required this.isArabic});

  @override
  State<CategoryFilterList> createState() => _CategoryFilterListState();
}

class _CategoryFilterListState extends State<CategoryFilterList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = widget.isArabic
        ? ['الكل', 'شاطئ', 'جبل', 'غابة', 'مدينة', 'تخييم']
        : ['All', 'Beach', 'Mountain', 'Forest', 'City', 'Camping'];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.secondaryblue : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: isSelected
                    ? null
                    : Border.all(color: Colors.grey.shade200),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColor.secondaryblue.withOpacity(0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
