import 'package:flutter/material.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../../home/presentation/widgets/search_bar.dart';
import 'widget/date_field.dart';
import 'widget/dropdown_field.dart';
import 'widget/filter_chip.dart';
import 'widget/glass_card.dart';
import 'widget/location_field.dart';
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/FlightBook.png',
            ),
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
                      _buildFilterSection(),
                      const SizedBox(height: 24),
                      Padding(
                          padding: const EdgeInsets.only(left: 74),
                        child: _buildTripTypeSection()),
                      const SizedBox(height: 20),
                      _buildLocationCard(),
                      const SizedBox(height: 20),
                      _buildDateCard(),
                      const SizedBox(height: 24),
                      _buildSearchButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildFilterSection() {
    return Row(
      children: [
         Text(
          'Filter by',
          style: AppTextStyle.setPoppinsTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.secondaryBlack),
        ),
        const SizedBox(width: 12),
        FilterChipWidget(  label: 'Airlines', onTap: () {  },),
        const SizedBox(width: 8),
        FilterChipWidget(  label: 'Passengers', onTap: () {  },),
        const SizedBox(width: 8),
        FilterChipWidget(  label: 'Class', onTap: () {  },),
      ],
    );
  }

  Widget _buildTripTypeSection() {
    return Row(
      children: [
        TripTypeButton(
          label: 'Round Trip',
          icon: Icons.sync,
          isSelected: isRoundTrip,
          onTap: () => setState(() => isRoundTrip = true),
        ),
        const SizedBox(width: 12),
        TripTypeButton(
          label: 'One way',
          icon: Icons.arrow_forward,
          isSelected: !isRoundTrip,
          onTap: () => setState(() => isRoundTrip = false),
        ),
      ],
    );
  }

  Widget _buildLocationCard() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Departure and Return Country',
            style: AppTextStyle.setPoppinsSecondaryBlack(fontSize: 10, fontWeight: FontWeight.w500)
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LocationField(
                  label: 'From',
                  hint: 'Enter Departure Point',
                  icon: Icons.location_on_outlined,
                ),
              ),
              Positioned
              (

              child: Transform.rotate(
                angle:50.38 * 3.1415926535 / 180,
                child:    Image.asset('assets/images/airplane.png',
                width: 40,
                height: 40,
                ),
                ),
              ),
              Expanded(
                child: LocationField(
                  label: 'To',
                  hint: 'Enter Your Destination',
                  icon: Icons.location_on_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isRoundTrip
                ? 'Enter Departure and Return Dates'
                : 'Select the travel date',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColor.secondaryblue,
            ),
          ),
          const SizedBox(height: 16),
          if (isRoundTrip)
            Row(
              children: [
                Expanded(
                  child: DateField(
                    label: 'Departure Date',
                    date: '01 / 11 / 2025',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DateField(
                    label: 'To',
                    date: '08 / 11 / 2025',
                  ),
                ),
              ],
            )
          else
            DateField(
              label: 'Departure Date',
              date: '01 / 11 / 2025',
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: DropdownField(label: 'Passengers')),
              const SizedBox(width: 8),
              Expanded(child: DropdownField(label: 'Airlines')),
              const SizedBox(width: 8),
              Expanded(child: DropdownField(label: 'Class')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
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
          child: const Center(
            child: Text(
              'Search for your trip',
              style: TextStyle(
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