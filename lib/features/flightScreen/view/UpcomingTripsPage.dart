import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/flightScreen/view/utils/componant_utils.dart';
import 'package:almonafs_flutter/features/getAilplaneState/data/model/Airplane_City_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../getAilplaneState/manager/Airplane_citys_cubit.dart';
import '../../localization/manager/localization_cubit.dart';
import 'utils/date_Card_utils.dart';
import 'utils/simple_location_card.dart';
import 'utils/search_button.dart';

class FlightBookingScreen extends StatefulWidget {
  const FlightBookingScreen({super.key});

  @override
  State<FlightBookingScreen> createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  bool isRoundTrip = true;
  int selectedNavIndex = 0;

  final _departureDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _fromCityController = TextEditingController();
  final _toCityController = TextEditingController();

  int adultsCount = 1;
  int childrenCount = 0;
  int infantsCount = 0;

  GetCitesAirplane? selectedFromCity;
  GetCitesAirplane? selectedToCity;
  String? selectedAirlineId; //  غيرنا النوع من AirLineData? لـ String?

  String selectedClass = 'economy';

  // controllers for contact info (used in booking request)
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AirPlaneCitysCubit>().getAirPlaneCitys();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: SizedBox(),
                backgroundColor: Colors.transparent,
                title: Text(
                  'Booking flight',
                  style: AppTextStyle.setPoppinsSecondaryBlack(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/FlightBook.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: 120,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //  crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // CustomSearchBar(controller: , onChanged: (String value) {  },),
                        const SizedBox(height: 20),
                        Center(
                          child: buildTripTypeSection(
                            isArabic: isArabic,
                            isRoundTrip: isRoundTrip,
                            onSelectRoundTrip: () =>
                                setState(() => isRoundTrip = true),
                            onSelectOneWay: () =>
                                setState(() => isRoundTrip = false),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SimpleLocationCard(
                          isArabic: isArabic,
                          fromController: _fromCityController,
                          toController: _toCityController,
                        ),
                        const SizedBox(height: 20),
                        DateCard(
                          isArabic: isArabic,
                          isRoundTrip: isRoundTrip,
                          departureDateController: _departureDateController,
                          returnDateController: _returnDateController,
                          onAdultsChanged: (val) => adultsCount = val,
                          onChildrenChanged: (val) => childrenCount = val,
                          onInfantsChanged: (val) => infantsCount = val,
                          onAirlineChanged: (value) {
                            setState(
                              () => selectedAirlineId =
                                  (value == null ||
                                      value == 'Any' ||
                                      value == 'أي')
                                  ? null
                                  : value,
                            );
                          },
                          onClassChanged: (value) {
                            if (value != null &&
                                value != 'Any' &&
                                value != 'أي') {
                              setState(() => selectedClass = value);
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        SearchButton(
                          isArabic: isArabic,
                          contextRef: context,
                          fromCity: _fromCityController.text,
                          toCity: _toCityController.text,
                          departureDateController: _departureDateController,
                          returnDateController: _returnDateController,
                          isRoundTrip: isRoundTrip,
                          adultsCount: adultsCount,
                          childrenCount: childrenCount,
                          infantsCount: infantsCount,
                          selectedClass: selectedClass,
                          selectedAirlineId: selectedAirlineId,
                          emailController: emailController,
                          phoneController: phoneController,
                          whatsappController: whatsappController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _departureDateController.dispose();
    _returnDateController.dispose();
    _fromCityController.dispose();
    _toCityController.dispose();
    emailController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    super.dispose();
  }
}
