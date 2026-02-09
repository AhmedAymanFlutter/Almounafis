import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/cities/manger/city_state.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViatorCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar & Filter Button Row
          Row(
            children: [
              Expanded(
                child: TextField(
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
              ),
              SizedBox(width: 8.w),
              // Filter Button
              InkWell(
                onTap: () {
                  _showFilterBottomSheet(context, cubit);
                },
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryblue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.filter_list, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, ViatorCubit cubit) {
    // Capture the CityCubit from the current context
    final cityCubit = context.read<CityCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Provide the captured CityCubit to the bottom sheet's context
        return BlocProvider.value(
          value: cityCubit,
          child: _FilterBottomSheetContent(cubit: cubit),
        );
      },
    );
  }
}

class _FilterBottomSheetContent extends StatefulWidget {
  final ViatorCubit cubit;

  const _FilterBottomSheetContent({required this.cubit});

  @override
  State<_FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<_FilterBottomSheetContent> {
  String? _selectedCity;
  double? _selectedRating;
  String? _selectedCancellation;
  String _selectedLang = 'en';

  @override
  void initState() {
    super.initState();
    final filters = widget.cubit.currentFilters;
    _selectedCity = filters['city'] as String?;
    _selectedRating = filters['minRating'] as double?;
    _selectedCancellation = filters['cancellationType'] as String?;
    _selectedLang = (filters['lang'] as String?) ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Filters',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),

          // City Dropdown
          Text(
            'City',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<CityCubit, CityState>(
            builder: (context, state) {
              final uniqueCities = <String>{};
              final cities = <City>[];

              if (state is CityLoaded) {
                for (var city in state.cityResponse.data?.cities ?? []) {
                  if (city.name != null && !uniqueCities.contains(city.name)) {
                    uniqueCities.add(city.name!);
                    cities.add(city);
                  }
                }
              }

              // Handle selected city mismatch (if selected city is not in the current list)
              String? currentValue = _selectedCity;
              if (currentValue != null &&
                  currentValue.isNotEmpty &&
                  !uniqueCities.contains(currentValue)) {
                // Add the currently selected city to the list temporarily to avoid dropdown crash
                cities.insert(0, City(name: currentValue));
                uniqueCities.add(currentValue);
              }

              return DropdownButtonFormField<String>(
                value: currentValue,
                decoration: InputDecoration(
                  hintText: 'Select city',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city.name,
                    child: Text(
                      city.name ?? "Unknown",
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
              );
            },
          ),
          SizedBox(height: 16.h),

          // Min Rating
          Text(
            'Minimum Rating',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            children: [3.0, 4.0, 4.5, 5.0].map((rating) {
              final isSelected = _selectedRating == rating;
              return ChoiceChip(
                label: Text('$rating+'),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedRating = selected ? rating : null;
                  });
                },
                selectedColor: AppColor.secondaryblue.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: isSelected ? AppColor.secondaryblue : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                backgroundColor: Colors.grey[100],
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                side: isSelected
                    ? BorderSide(color: AppColor.secondaryblue)
                    : BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),

          // Cancellation Type
          Text(
            'Cancellation Policy',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            children:
                [
                  {'label': 'Free Cancellation', 'value': 'FREE_CANCELLATION'},
                  {'label': 'Standard', 'value': 'STANDARD'},
                ].map((option) {
                  final isSelected = _selectedCancellation == option['value'];
                  return ChoiceChip(
                    label: Text(option['label']!),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCancellation = selected
                            ? option['value']
                            : null;
                      });
                    },
                    selectedColor: AppColor.secondaryblue.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? AppColor.secondaryblue : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    backgroundColor: Colors.grey[100],
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    side: isSelected
                        ? BorderSide(color: AppColor.secondaryblue)
                        : BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 16.h),

          // Language
          Text(
            'Language',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildLanguageOption('English', 'en'),
              SizedBox(width: 12.w),
              _buildLanguageOption('Arabic', 'ar'),
            ],
          ),
          SizedBox(height: 24.h),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    widget.cubit.clearFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    widget.cubit.fetchTours(
                      city: _selectedCity,
                      minRating: _selectedRating,
                      cancellationType: _selectedCancellation,
                      lang: _selectedLang,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondaryblue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String label, String value) {
    final isSelected = _selectedLang == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLang = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.secondaryblue.withOpacity(0.1)
              : Colors.grey[100],
          border: Border.all(
            color: isSelected ? AppColor.secondaryblue : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColor.secondaryblue : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
