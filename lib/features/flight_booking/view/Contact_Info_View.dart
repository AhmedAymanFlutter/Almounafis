import 'package:almonafs_flutter/features/flight_booking/view/widget/confirm_booking_button.dart';
import 'package:almonafs_flutter/features/getAilplaneState/data/model/Airplane_City_model.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/Fun_helper.dart';
import '../../flightScreen/data/model/AirLine_data.dart';
import '../../global_Settings/manager/global_cubit.dart';
import '../data/model/Flight_Booking_Request.dart';
import '../manager/flight_booking_cubit.dart';
import '../manager/flight_booking_state.dart';
import 'helper/contact_info_helper.dart';
import 'widget/contact_form.dart';
import 'widget/contact_summary_card.dart';

class ContactInfoView extends StatefulWidget {
  final FlightBookingRequest bookingRequest;
  final AirLineData? selectedAirline;
  final GetCitesAirplane? fromCity;
  final GetCitesAirplane? toCity;

  const ContactInfoView({
    super.key,
    required this.bookingRequest,
    this.selectedAirline,
    this.fromCity,
    this.toCity,
  });

  @override
  State<ContactInfoView> createState() => _ContactInfoViewState();
}

class _ContactInfoViewState extends State<ContactInfoView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  String selectedCountryCode = '+20';

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    super.dispose();
  }

  String _generateTripSummary(BuildContext context) {
    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;
    final booking = widget.bookingRequest;
    final airline = widget.selectedAirline;

    final fromCityName = isArabic
        ? (widget.fromCity?.nameAr ?? widget.fromCity?.name ?? 'غير محددة')
        : (widget.fromCity?.name ?? widget.fromCity?.nameAr ?? 'Not specified');

    final toCityName = isArabic
        ? (widget.toCity?.nameAr ?? widget.toCity?.name ?? 'غير محددة')
        : (widget.toCity?.name ?? widget.toCity?.nameAr ?? 'Not specified');

    if (isArabic) {
      return '''
السلام عليكم 

*ملخص الرحلة*

 *شركة الطيران:* ${airline?.nameAr ?? airline?.name ?? 'شركة الطيران'}
 *من:* $fromCityName
 *إلى:* $toCityName

 *تاريخ المغادرة:* ${booking.departureDate}
${booking.returnDate != null ? ' *تاريخ العودة:* ${booking.returnDate}' : ''}

 *عدد المسافرين:*
${booking.adults} بالغ
${booking.children} طفل
${booking.infants} رضيع

 *الدرجة:* ${_getClassType(booking.travelClass, true)}

${emailController.text.isNotEmpty ? ' *البريد الإلكتروني:* ${emailController.text}' : ''}
${phoneController.text.isNotEmpty ? ' *رقم الهاتف:* $selectedCountryCode${phoneController.text}' : ''}

أرغب في الحصول على عرض سعر لهذه الرحلة 
شكراً لكم 
''';
    } else {
      return '''
Hello ,

 *Trip Summary*

 *Airline:* ${airline?.name ?? airline?.nameAr ?? 'Airline'}
 *From:* $fromCityName
 *To:* $toCityName

 *Departure Date:* ${booking.departureDate}
${booking.returnDate != null ? ' *Return Date:* ${booking.returnDate}' : ''}

 *Passengers:*
${booking.adults} Adults
${booking.children} Children
${booking.infants} Infants

 *Class Type:* ${_getClassType(booking.travelClass, false)}

${emailController.text.isNotEmpty ? ' *Email:* ${emailController.text}' : ''}
${phoneController.text.isNotEmpty ? ' *Phone:* $selectedCountryCode${phoneController.text}' : ''}

I would like to get a price quote for this trip 
Thank you   
''';
    }
  }

  String _getClassType(String? cabinClass, bool isArabic) {
    if (cabinClass == null) return isArabic ? 'اقتصادية' : 'Economy';

    switch (cabinClass.toLowerCase()) {
      case 'economy':
        return isArabic ? 'اقتصادية' : 'Economy';
      case 'business':
        return isArabic ? 'رجال الأعمال' : 'Business';
      case 'first':
        return isArabic ? 'الدرجة الأولى' : 'First Class';
      default:
        return cabinClass;
    }
  }

  void _sendToWhatsApp(BuildContext context, bool isArabic) {
    final globalSettingsState = context.read<GlobalSettingsCubit>().state;

    if (globalSettingsState is GlobalSettingsLoaded) {
      final summary = _generateTripSummary(context);
      WhatsAppService.launchWhatsApp(
        context,
        isArabic: isArabic,
        settings: globalSettingsState.globalSettings,
        customMessage: summary,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic ? "جاري تحميل الإعدادات..." : "Loading settings...",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'معلومات الاتصال' : 'Contact Information'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<FlightBookingCubit, FlightBookingState>(
        listener: (context, state) =>
            ContactInfoHelper.handleBookingState(context, state),
        child: BlocBuilder<FlightBookingCubit, FlightBookingState>(
          builder: (context, state) {
            final isLoading = state is FlightBookingLoading;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth >= 900;

                    if (isDesktop) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Form(
                          key: formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Area (Summary)
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    ContactSummaryCard(
                                      bookingRequest: widget.bookingRequest,
                                      selectedAirline: widget.selectedAirline,
                                      fromCity: widget.fromCity,
                                      toCity: widget.toCity,
                                    ),
                                    const SizedBox(height: 24),
                                    // Make sure WhatsApp button is also available or decide placement
                                    // Putting it here for desktop might look good or below form
                                    // Following plan: Summary on left.
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              // Right Area (Form & Actions)
                              Expanded(
                                flex: 6,
                                child: Column(
                                  children: [
                                    _buildWhatsAppButton(context, isArabic),
                                    const SizedBox(height: 24),
                                    ContactForm(
                                      formKey: formKey,
                                      emailController: emailController,
                                      phoneController: phoneController,
                                      whatsappController: whatsappController,
                                      selectedCountryCode: selectedCountryCode,
                                      onCountryCodeChanged: (code) => setState(
                                        () => selectedCountryCode = code,
                                      ),
                                      isLoading: isLoading,
                                    ),
                                    const SizedBox(height: 32),
                                    ConfirmBookingButton(
                                      isLoading: isLoading,
                                      onPressed: () =>
                                          ContactInfoHelper.submitBooking(
                                            context: context,
                                            formKey: formKey,
                                            bookingRequest:
                                                widget.bookingRequest,
                                            selectedAirline:
                                                widget.selectedAirline,
                                            emailController: emailController,
                                            phoneController: phoneController,
                                            whatsappController:
                                                whatsappController,
                                            countryCode: selectedCountryCode,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Mobile/Tablet Layout (Existing Column)
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ContactSummaryCard(
                                bookingRequest: widget.bookingRequest,
                                selectedAirline: widget.selectedAirline,
                                fromCity: widget.fromCity,
                                toCity: widget.toCity,
                              ),
                              const SizedBox(height: 20),
                              _buildWhatsAppButton(context, isArabic),
                              const SizedBox(height: 28),
                              ContactForm(
                                formKey: formKey,
                                emailController: emailController,
                                phoneController: phoneController,
                                whatsappController: whatsappController,
                                selectedCountryCode: selectedCountryCode,
                                onCountryCodeChanged: (code) =>
                                    setState(() => selectedCountryCode = code),
                                isLoading: isLoading,
                              ),
                              const SizedBox(height: 32),
                              ConfirmBookingButton(
                                isLoading: isLoading,
                                onPressed: () =>
                                    ContactInfoHelper.submitBooking(
                                      context: context,
                                      formKey: formKey,
                                      bookingRequest: widget.bookingRequest,
                                      selectedAirline: widget.selectedAirline,
                                      emailController: emailController,
                                      phoneController: phoneController,
                                      whatsappController: whatsappController,
                                      countryCode: selectedCountryCode,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWhatsAppButton(BuildContext context, bool isArabic) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF25D366), Color(0xFF128C7E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF25D366).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _sendToWhatsApp(context, isArabic),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isArabic ? 'واتساب' : 'WhatsApp',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  isArabic ? 'سريع وسهل' : 'Quick & Easy',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
