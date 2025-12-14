import 'package:almonafs_flutter/features/home/manager/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../seeAllPage/widget/card_country_widget.dart';
import '../../../manager/country_state.dart';
import '../widget/utils/get_image.dart';

class CountriesSection extends StatelessWidget {
  final CountryState state;
  final bool isArabic;

  const CountriesSection({
    super.key,
    required this.state,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    if (state is CountryLoading) return _buildLoading();
    if (state is CountryError)
      return _buildError(context, state as CountryError);
    if (state is CountryLoaded) return _buildCountries(state as CountryLoaded);
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoading() => SizedBox(
    height: 220,
    child: Skeletonizer(
      enabled: true,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, __) => Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الدولة
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // اسم الدولة
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Container(
                  height: 14,
                  width: 100,
                  color: Colors.grey[300],
                ),
              ),

              // وصف الدولة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 10,
                  width: 180,
                  color: Colors.grey[300],
                ),
              ),

              const Spacer(),

              // العملة أو الموقع
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 12,
                  width: 80,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _buildError(BuildContext context, CountryError state) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.error, color: Colors.red, size: 50),
      const SizedBox(height: 8),
      Text(
        isArabic ? "حدث خطأ في التحميل" : state.message,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      const SizedBox(height: 16),
      Center(
        child: ElevatedButton(
          onPressed: () => context.read<CountryCubit>().fetchAllCountries(),
          child: Text(isArabic ? "إعادة المحاولة" : "Retry"),
        ),
      ),
    ],
  );

  Widget _buildCountries(CountryLoaded state) {
    final countries = state.countries;

    if (countries.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Icon(Icons.warning, color: Colors.orange, size: 50),
            Text(
              isArabic ? 'لا توجد دول متاحة' : 'No countries available',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: countries.length,
        itemBuilder: (_, index) {
          final country = countries[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == countries.length - 1 ? 0 : 12.0,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: 1,
              child: SizedBox(
                width: 300,
                child: CountryCard(
                  name: isArabic
                      ? (country.nameAr ?? "بدون اسم")
                      : (country.name ?? "No Name"),
                  imageUrl: getCountryImageUrl(country),
                  description: isArabic
                      ? (country.descriptionArFlutter ?? "لا يوجد وصف متاح")
                      : (country.descriptionFlutter ??
                            "No description available"),
                  currency:
                      country.currency ??
                      (isArabic ? "غير محدد" : "Not specified"),
                  location: isArabic
                      ? (country.nameAr ?? "بدون موقع")
                      : (country.name ?? "Unknown"),
                  countryId: country.id ?? "",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
