import 'package:almonafs_flutter/features/getAilplaneState/manager/Airplane_citys_cubit.dart';
import 'package:almonafs_flutter/features/getAilplaneState/manager/airplane_citys_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/location_field.dart';
class LocationCard extends StatelessWidget {
  final bool isArabic;
  final Function(dynamic city) onFromSelected;
  final Function(dynamic city) onToSelected;
  final dynamic selectedFromCity;
  final dynamic selectedToCity;

  const LocationCard({
    super.key,
    required this.isArabic,
    required this.onFromSelected,
    required this.onToSelected,
    this.selectedFromCity,
    this.selectedToCity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'بلد المغادرة والعودة' : 'Departure and Return Country',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: LocationField(
                    label: isArabic ? 'من' : 'From',
                    hint: isArabic ? 'اختر مدينة المغادرة' : 'Enter Departure City',
                    icon: Icons.flight_takeoff_outlined,
                    selectedValue: isArabic
                        ? (selectedFromCity?.nameAr ?? selectedFromCity?.name ?? '')
                        : (selectedFromCity?.name ?? selectedFromCity?.nameAr ?? ''),
                    onTap: () => _showCityPicker(context, isFrom: true),
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: LocationField(
                    label: isArabic ? 'إلى' : 'To',
                    hint: isArabic ? 'اختر مدينة الوصول' : 'Enter Destination City',
                    icon: Icons.flight_land_outlined,
                    selectedValue: isArabic
                        ? (selectedToCity?.nameAr ?? selectedToCity?.name ?? '')
                        : (selectedToCity?.name ?? selectedToCity?.nameAr ?? ''),
                    onTap: () => _showCityPicker(context, isFrom: false),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: 50.38 * 3.1415926535 / 180,
                  child: Image.asset(
                    'assets/images/airplane.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 🧭 Show Bottom Sheet to Select City
 void _showCityPicker(BuildContext context, {required bool isFrom}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isFrom 
                      ? (isArabic ? 'اختر مدينة المغادرة' : 'Select Departure City')
                      : (isArabic ? 'اختر مدينة الوصول' : 'Select Arrival City'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
                            
            // Content
            Expanded(
              child: BlocBuilder<AirPlaneCitysCubit, AirPlaneCitysState>(
                builder: (context, state) {
                  if (state is AirPlaneCitysLoading) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Loading cities...'),
                        ],
                      ),
                    );
                  } else if (state is AirPlaneCitysSuccess) {
                    final cities = state.cities;
                    
                    if (cities.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_off, size: 64, color: Colors.grey[300]),
                            const SizedBox(height: 16),
                            Text(
                              isArabic ? 'لا توجد مدن' : 'No cities found',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    return ListView.separated(
                      itemCount: cities.length,
                      padding: const EdgeInsets.only(bottom: 16),
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey[100],
                        indent: 16,
                        endIndent: 16,
                      ),
                      itemBuilder: (context, index) {
                        final city = cities[index];
                        final cityName = isArabic
                            ? (city.nameAr ?? city.name ?? '')
                            : (city.name ?? city.nameAr ?? '');
                        final countryName = isArabic
                            ? (city.nameAr ?? city.name ?? '')
                            : (city.name ?? city.nameAr ?? '');
                            
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              if (isFrom) {
                                onFromSelected(city);
                              } else {
                                onToSelected(city);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.blue[600],
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cityName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        if (countryName.isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            countryName,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is AirPlaneCitysError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              context.read<AirPlaneCitysCubit>().getAirPlaneCitys();
                            },
                            child: Text(isArabic ? 'إعادة المحاولة' : 'Try Again'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_city, size: 64, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text(
                            isArabic ? 'لا توجد مدن متاحة' : 'No cities available',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
}
