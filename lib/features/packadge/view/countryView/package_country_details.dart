import 'package:almonafs_flutter/features/packadge/view/countryView/widget/country_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../config/router/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../localization/manager/localization_cubit.dart';
import '../../data/repo/package_repo.dart';
import '../../manager/package_cubit.dart';
import '../../manager/package_state.dart';

class CountriesView extends StatelessWidget {
  final String packageTypeSlug; // Changed from ID to Slug to match Repo
  final String packageTypeName;
  final String? packageTypeNameAr;

  const CountriesView({
    super.key,
    required this.packageTypeSlug,
    required this.packageTypeName,
    this.packageTypeNameAr,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ✅ Trigger Step 2 API Call immediately
      create: (_) =>
          PackageCubit(PackageTypeRepo())
            ..getCountriesForPackageType(packageTypeSlug),
      child: BlocBuilder<LanguageCubit, AppLanguage>(
        builder: (context, langState) {
          final isArabic = langState == AppLanguage.arabic;

          return Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  isArabic
                      ? (packageTypeNameAr ?? packageTypeName)
                      : packageTypeName,
                  style: AppTextStyle.setPoppinsTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.mainBlack,
                  ),
                ),
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'assets/icons/arrowback.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              body: BlocBuilder<PackageCubit, PackageState>(
                builder: (context, state) {
                  // ✅ Handle Loading State
                  if (state is CountriesLoading) {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      itemCount: 4,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) => Skeletonizer(
                        enabled: true,
                        child: CountryCard(
                          countryName: "Loading...",
                          countrySlug: "",
                          countryImage: "",
                          onTap: () {},
                        ),
                      ),
                    );
                  }
                  // ✅ Handle Success State
                  else if (state is CountriesLoaded) {
                    // 🔍 Parsing the Map Data
                    final List<dynamic> countries =
                        state.countriesData['data'] is List
                        ? state.countriesData['data']
                        : (state.countriesData['data']['countries'] ?? []);

                    if (countries.isEmpty) {
                      return Center(
                        child: Text(
                          isArabic
                              ? 'لا توجد دول متاحة'
                              : 'No countries available',
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.secondaryBlack,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];

                        final countryName = isArabic
                            ? (country['nameAr'] ?? country['name'] ?? 'دولة')
                            : (country['name'] ?? 'Country');

                        // Use Slug for API calls, ID for other logic if needed
                        final countrySlug =
                            country['slug'] ?? country['_id'] ?? '';

                        final countryImage =
                            country['image'] ??
                            country['imageCover']?['url'] ?? // Handle object structure if needed
                            country['imageCover'] ??
                            '';

                        return CountryCard(
                          countryName: countryName,
                          countrySlug: countrySlug,
                          countryImage: countryImage,
                          onTap: () {
                            // ✅ Navigate to Step 3
                            Navigator.pushNamed(
                              context,
                              Routes.packagesListView,
                              arguments: {
                                'countrySlug': countrySlug, // Pass Slug
                                'packageTypeSlug':
                                    packageTypeSlug, // Pass Parent Slug
                                'countryName': countryName,
                              },
                            );
                          },
                        );
                      },
                    );
                  } else if (state is PackageError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
