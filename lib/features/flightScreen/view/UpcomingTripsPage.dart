import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../../home/presentation/widgets/search_bar.dart';
import '../../localization/manager/localization_cubit.dart';
import 'widget/date_field.dart';
import 'widget/dropdown_field.dart';
import 'widget/filter_chip.dart';
import 'widget/glass_card.dart';
import 'widget/location_field.dart';
import 'widget/passenger_counter.dart';
import 'widget/trip_type_button.dart';

class FlightBookingScreen extends StatefulWidget {
  const FlightBookingScreen({super.key});

  @override
  State<FlightBookingScreen> createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  bool isRoundTrip = true;
  int selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Component 20 (1).png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomSearchBar(),
                            const SizedBox(height: 20),
                            _buildFilterSection(isArabic),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.only(left: 74),
                              child: _buildTripTypeSection(isArabic),
                            ),
                            const SizedBox(height: 20),
                            _buildLocationCard(isArabic),
                            const SizedBox(height: 20),
                            _buildDateCard(isArabic),
                            const SizedBox(height: 24),
                            _buildSearchButton(isArabic),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // 🔹 Filter Section
  Widget _buildFilterSection(bool isArabic) {
    return Row(
      children: [
        Text(
          isArabic ? 'تصفية حسب' : 'Filter by',
          style: AppTextStyle.setPoppinsTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColor.secondaryBlack,
          ),
        ),
        const SizedBox(width: 12),
        FilterChipWidget(label: isArabic ? 'شركات الطيران' : 'Airlines', onTap: () {}),
        const SizedBox(width: 8),
        FilterChipWidget(label: isArabic ? 'الركاب' : 'Passengers', onTap: () {}),
        const SizedBox(width: 8),
        FilterChipWidget(label: isArabic ? 'الدرجة' : 'Class', onTap: () {}),
      ],
    );
  }

  // 🔹 Trip Type
  Widget _buildTripTypeSection(bool isArabic) {
    return Row(
      children: [
        TripTypeButton(
          label: isArabic ? 'ذهاب وعودة' : 'Round Trip',
          icon: Icons.sync,
          isSelected: isRoundTrip,
          onTap: () => setState(() => isRoundTrip = true),
        ),
        const SizedBox(width: 12),
        TripTypeButton(
          label: isArabic ? 'ذهاب فقط' : 'One Way',
          icon: Icons.arrow_forward,
          isSelected: !isRoundTrip,
          onTap: () => setState(() => isRoundTrip = false),
        ),
      ],
    );
  }

  // 🔹 Location
  Widget _buildLocationCard(bool isArabic) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'بلد المغادرة والعودة' : 'Departure and Return Country',
            style: AppTextStyle.setPoppinsSecondaryBlack(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: LocationField(
                      label: isArabic ? 'من' : 'From',
                      hint: isArabic ? 'أدخل نقطة الانطلاق' : 'Enter Departure Point',
                      icon: Icons.location_on_outlined,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: LocationField(
                      label: isArabic ? 'إلى' : 'To',
                      hint: isArabic ? 'أدخل وجهتك' : 'Enter Your Destination',
                      icon: Icons.location_on_outlined,
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
      ),
    );
  }

  // 🔹 Date Section
  Widget _buildDateCard(bool isArabic) {
  return GlassCard(
    child: LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 600; 

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isRoundTrip
                  ? (isArabic
                      ? 'أدخل تواريخ الذهاب والعودة'
                      : 'Enter Departure and Return Dates')
                  : (isArabic
                      ? 'اختر تاريخ الرحلة'
                      : 'Select the travel date'),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColor.secondaryblue,
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Round trip or single trip date fields
            if (isRoundTrip)
              Row(
                children: [
                  Expanded(
                    child: DateField(
                      label: isArabic ? 'تاريخ المغادرة' : 'Departure Date',
                      date: '01 / 11 / 2025',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DateField(
                      label: isArabic ? 'تاريخ العودة' : 'Return Date',
                      date: '08 / 11 / 2025',
                    ),
                  ),
                ],
              )
            else
              DateField(
                label: isArabic ? 'تاريخ المغادرة' : 'Departure Date',
                date: '01 / 11 / 2025',
              ),

            const SizedBox(height: 16),

            // ✅ Passenger & Dropdowns (responsive)
            if (isWide)
              Row(
                children: [
                  Flexible(child: PassengerCounterDropdown()),
                  const SizedBox(width: 8),
                  Flexible(
                    child: DropdownField(
                      label: isArabic ? 'شركات الطيران' : 'Airlines',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: DropdownField(
                      label: isArabic ? 'الدرجة' : 'Class',
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  PassengerCounterDropdown(),
                  const SizedBox(height: 8),
                  DropdownField(
                    label: isArabic ? 'شركات الطيران' : 'Airlines',
                  ),
                  const SizedBox(height: 8),
                  DropdownField(
                    label: isArabic ? 'الدرجة' : 'Class',
                  ),
                ],
              ),
          ],
        );
      },
    ),
  );
}

  // 🔹 Search Button
  Widget _buildSearchButton(bool isArabic) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A8EEA), Color(0xFF102E4F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              isArabic ? 'ابحث عن رحلتك' : 'Search for your trip',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
