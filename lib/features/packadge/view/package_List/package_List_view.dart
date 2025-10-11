import 'package:almonafs_flutter/features/packadge/data/repo/package_repo.dart';
import 'package:almonafs_flutter/features/packadge/view/package_List/widget/List_package_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/router/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../manager/package_cubit.dart';
import '../../manager/package_state.dart';

class PackagesListView extends StatelessWidget {
  final String countryId;
  final String countryName;

  const PackagesListView({
    super.key,
    required this.countryId,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PackageCubit(PackageTypeRepo())
          ..getPackagesForCountry(countryId),
      child: Scaffold(
        backgroundColor: AppColor.mainWhite,
        appBar: AppBar(
          
          title: Text(
            countryName,
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
            if (state is PackagesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PackagesLoaded) {
              final packagesData = state.packagesData;
              final packages = packagesData['data']?['packages'] as List? ?? [];

              if (packages.isEmpty) {
                return const Center(child: Text('لا توجد باقات متاحة'));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final package = packages[index];
                  final packageTitle = package['title'] ?? 'Unknown';
                  final packageId = package['_id'] ?? '';
                  final packagePrice = package['price'] ?? 'N/A';
                  final packageImage = package['image'] ??
                      package['imageCover'] ??
                      'https://via.placeholder.com/421x200?text=$packageTitle';
                  final packageDescription = package['description'] ?? '';
                  return PackageCard(
                    title: packageTitle,
                    price: packagePrice,
                    image: packageImage,
                    description: packageDescription,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.packageDetailsView,
                        arguments: {
                          'packageId': packageId,
                          'packageTitle': packageTitle,
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

