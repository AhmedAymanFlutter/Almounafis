import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart';
import 'package:almonafs_flutter/features/home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/features/home/manager/country_state.dart';
import 'package:almonafs_flutter/features/home/manager/country_cubit.dart';
import 'package:almonafs_flutter/features/home/data/repo/country_repo.dart';
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

          return Scaffold(
            backgroundColor: AppColor.mainWhite,
            appBar: AppBar(
              title: const Text("All Countries"),
              elevation: 0,
              backgroundColor: AppColor.mainWhite,
              foregroundColor: Colors.black,
            ),
            body: Column(
              children: [
                CustomSearchBar(
                  controller: searchController,
                  onChanged: (query) {
                    print("🔍 Searching for: $query");
                    context.read<CountryCubit>().searchCountries(query, isArabic);
                  },
                ),
                const SizedBox(height: 10),

                if (state is CountryLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state is CountryError)
                  Expanded(
                    child: Center(child: Text(state.message)),
                  )
                else if (countries.isEmpty)
                  const Expanded(
                    child: Center(child: Text("No countries available.")),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return SizedBox(
                          height: 300,
                          child:CountryCard(
  name: isArabic
      ? (country.nameAr ?? "بدون اسم")
      : (country.name ?? "No Name"),
  imageUrl: getCountryImageUrl(country),
  description: isArabic
      ? (country.descriptionArFlutter ?? "لا يوجد وصف متاح")
      : (country.descriptionFlutter ?? "No description available"),
  currency: country.currency ?? (isArabic ? "غير محدد" : "Not specified"),
  location: isArabic
      ? (country.nameAr ?? "بدون موقع")
      : (country.name ?? "Unknown"),
  countryId: country.slug ?? country.sId ?? "",
)

                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

