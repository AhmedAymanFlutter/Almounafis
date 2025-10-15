import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../localization/manager/localization_cubit.dart';
import '../../data/model/AirLine_data.dart';

class PassengerCounterDropdown extends StatefulWidget {
  final FlightFilter? currentFilter;
  final Function(FlightFilter)? onFilterChanged;
  final ValueChanged<int>? onAdultsChanged;
  final ValueChanged<int>? onChildrenChanged;
  final ValueChanged<int>? onInfantsChanged;

  const PassengerCounterDropdown({
    super.key,
    this.currentFilter,
    this.onFilterChanged,
    this.onAdultsChanged,
    this.onChildrenChanged,
    this.onInfantsChanged,
  });

  @override
  State<PassengerCounterDropdown> createState() =>
      _PassengerCounterDropdownState();
}

class _PassengerCounterDropdownState extends State<PassengerCounterDropdown> {
  int adults = 1;
  int children = 0;
  int infants = 0;
  bool _isExpanded = false;

  void _updateFilter() {
    final total = adults + children + infants;
    final updatedFilter = (widget.currentFilter ?? FlightFilter()).copyWith(
      passengerCount: total.toString(),
    );
    widget.onFilterChanged?.call(updatedFilter);
  }

  void _incrementAdults() {
    setState(() {
      if (adults < 9) adults++;
      _updateFilter();
      widget.onAdultsChanged?.call(adults); // ✅ أضفنا هذا
    });
  }

  void _decrementAdults() {
    setState(() {
      if (adults > 1) adults--;
      _updateFilter();
      widget.onAdultsChanged?.call(adults);
    });
  }

  void _incrementChildren() {
    setState(() {
      if (children < 8) children++;
      _updateFilter();
      widget.onChildrenChanged?.call(children); // ✅
    });
  }

  void _decrementChildren() {
    setState(() {
      if (children > 0) children--;
      _updateFilter();
      widget.onChildrenChanged?.call(children);
    });
  }

  void _incrementInfants() {
    setState(() {
      if (infants < 8) infants++;
      _updateFilter();
      widget.onInfantsChanged?.call(infants); // ✅
    });
  }

  void _decrementInfants() {
    setState(() {
      if (infants > 0) infants--;
      _updateFilter();
      widget.onInfantsChanged?.call(infants);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey[300]!, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getPassengerSummary(isArabic),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                ),
              ),
              if (_isExpanded)
                Container(
                  margin: EdgeInsets.only(top: 8.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPassengerRow(
                        label: isArabic ? 'البالغون' : 'Adults',
                        subtitle: isArabic ? '+12 سنة' : '+12 years',
                        count: adults,
                        onIncrement: _incrementAdults,
                        onDecrement: _decrementAdults,
                        canDecrement: adults > 1,
                      ),
                      Divider(height: 24.h, color: Colors.grey[200]),
                      _buildPassengerRow(
                        label: isArabic ? 'الأطفال' : 'Children',
                        subtitle: isArabic ? '2-11 سنة' : '2-11 years',
                        count: children,
                        onIncrement: _incrementChildren,
                        onDecrement: _decrementChildren,
                        canDecrement: children > 0,
                      ),
                      Divider(height: 24.h, color: Colors.grey[200]),
                      _buildPassengerRow(
                        label: isArabic ? 'الرضع' : 'Infants',
                        subtitle:
                            isArabic ? 'أقل من سنتين' : 'Less than 2 years',
                        count: infants,
                        onIncrement: _incrementInfants,
                        onDecrement: _decrementInfants,
                        canDecrement: infants > 0,
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              setState(() => _isExpanded = false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1a2a4a),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            isArabic ? 'تم' : 'Done',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPassengerRow({
    required String label,
    required String subtitle,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    required bool canDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
            SizedBox(height: 4.h),
            Text(subtitle,
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600])),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onIncrement,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, size: 16.sp, color: Colors.black87),
              ),
            ),
            SizedBox(width: 12.w),
            SizedBox(
              width: 30.w,
              child: Center(
                child: Text('$count',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: canDecrement ? onDecrement : null,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: canDecrement ? Colors.grey[200] : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove,
                    size: 16.sp,
                    color: canDecrement
                        ? Colors.black87
                        : Colors.grey[400]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getPassengerSummary(bool isArabic) {
    List<String> parts = [];

    if (adults > 0) {
      parts.add(isArabic
          ? '$adults ${adults == 1 ? 'بالغ' : 'بالغين'}'
          : '$adults ${adults == 1 ? 'Adult' : 'Adults'}');
    }

    if (children > 0) {
      parts.add(isArabic
          ? '$children ${children == 1 ? 'طفل' : 'أطفال'}'
          : '$children ${children == 1 ? 'Child' : 'Children'}');
    }

    if (infants > 0) {
      parts.add(isArabic
          ? '$infants ${infants == 1 ? 'رضيع' : 'رضع'}'
          : '$infants ${infants == 1 ? 'Infant' : 'Infants'}');
    }

    if (parts.isEmpty) {
      return isArabic ? 'لم يتم اختيار ركاب' : 'No passengers selected';
    }

    return parts.join(isArabic ? '، ' : ', ');
  }
}
