import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart';
import 'package:almonafs_flutter/features/home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/features/home/manager/country_state.dart';
import 'package:almonafs_flutter/features/home/manager/country_cubit.dart';
import 'package:almonafs_flutter/features/home/data/repo/country_repo.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../home/presentation/views/widget/utils/get_image.dart';
import '../../localization/manager/localization_cubit.dart';
import '../widget/card_country_widget.dart';

class AllCountriesPage extends StatelessWidget {
  AllCountriesPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isArabic =
        context.read<LanguageCubit>().state == AppLanguage.arabic;

    return BlocProvider(
      create: (_) => CountryCubit(CountryRepository())..fetchAllCountries(),
      child: BlocBuilder<CountryCubit, CountryState>(
        builder: (context, state) {
          List<Data> countries = [];

          if (state is CountryLoaded) {
            countries = state.countries;
          } else if (state is CountryFiltered) {
            countries = state.filteredCountries;
          }

          final isLoading = state is CountryLoading;

          return Scaffold(
            backgroundColor: AppColor.mainWhite,
            appBar: AppBar(
              title: Text(
                isArabic ? "كل الدول" : "All Countries",
                style: const TextStyle(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: AppColor.mainWhite,
              foregroundColor: Colors.black,
            ),
            body: Column(
              children: [
                CustomSearchBar(
                  controller: searchController,
                  onChanged: (query) {
                    context.read<CountryCubit>().searchCountries(
                      query,
                      isArabic,
                    );
                  },
                ),
                const SizedBox(height: 10),

                /// ✅ Skeleton-style loader (like CountriesSection)
                Expanded(
                  child: isLoading
                      ? _buildSkeletonList()
                      : _buildCountryList(context, countries, isArabic),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 🩶 نفس شكل الـ Skeletonizer من CountriesSection لكن عمودي
  Widget _buildSkeletonList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemCount: 6,
      itemBuilder: (_, __) => Container(
        height: 280,
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
        child: Skeletonizer(
          enabled: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الدولة
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // اسم الدولة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 14,
                  width: 120,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 8),

              // وصف
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 10,
                  width: 200,
                  color: Colors.grey[300],
                ),
              ),

              const Spacer(),

              // العملة أو الموقع
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 12,
                  width: 100,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🟢 بعد التحميل، عرض الدول
  Widget _buildCountryList(
    BuildContext context,
    List<Data> countries,
    bool isArabic,
  ) {
    if (countries.isEmpty) {
      return Center(
        child: Text(isArabic ? 'لا توجد دول متاحة' : 'No countries available'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return SizedBox(
          height: 300,
          child: CountryCard(
            name: isArabic
                ? (country.nameAr ?? "بدون اسم")
                : (country.name ?? "No Name"),
            imageUrl: getCountryImageUrl(country),
            description: isArabic
                ? (country.descriptionArFlutter ?? "لا يوجد وصف متاح")
                : (country.descriptionFlutter ?? "No description available"),
            currency:
                country.currency ?? (isArabic ? "غير محدد" : "Not specified"),
            location: isArabic
                ? (country.nameAr ?? "بدون موقع")
                : (country.name ?? "Unknown"),
            countryId: country.slug ?? country.sId ?? "",
          ),
        );
      },
    );
  }
}
