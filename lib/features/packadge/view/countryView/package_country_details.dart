import 'package:almonafs_flutter/features/packadge/view/countryView/widget/country_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/router/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/repo/package_repo.dart';
import '../../manager/package_cubit.dart';
import '../../manager/package_state.dart';

class CountriesView extends StatelessWidget {
  final String packageTypeId;
  final String packageTypeName;

  const CountriesView({
    super.key,
    required this.packageTypeId,
    required this.packageTypeName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PackageCubit(PackageTypeRepo())
          ..getCountriesForPackageType(packageTypeId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            packageTypeName,
            style: AppTextStyle.setPoppinsTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.mainBlack,
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/packageView'),
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
            if (state is CountriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountriesLoaded) {
              final countriesData = state.countriesData;
              final countries =
                  countriesData['data']?['countries'] as List? ?? [];

              if (countries.isEmpty) {
                return const Center(
                  child: Text('لا توجد دول متاحة'),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final countryName = country['name'] ?? 'Unknown';
                  final countryId = country['_id'] ?? '';
                  final countryImage = country['image'] ?? 
                      country['imageCover'] ?? 
                      'https://via.placeholder.com/421x200?text=$countryName';

                  return CountryCard(
                    countryName: countryName,
                    countryId: countryId,
                    countryImage: countryImage,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.packagesListView,
                        arguments: {
                          'countryId': countryId,
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
  }
}

