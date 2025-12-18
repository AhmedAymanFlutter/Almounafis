import 'package:almonafs_flutter/features/packadge/data/repo/package_repo.dart';
import 'package:almonafs_flutter/features/packadge/view/package_List/widget/List_package_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../config/router/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../localization/manager/localization_cubit.dart';
import '../../manager/package_cubit.dart';
import '../../manager/package_state.dart';

class PackagesListView extends StatelessWidget {
  final String countrySlug;
  final String packageTypeSlug;
  final String countryName;

  const PackagesListView({
    super.key,
    required this.countrySlug,
    required this.packageTypeSlug,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, languageState) {
        final isArabic = languageState == AppLanguage.arabic;

        return BlocProvider(
          create: (_) => PackageCubit(PackageTypeRepo())
            ..getPackagesForCountry(countrySlug, packageTypeSlug),
          child: Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
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
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isArabic ? 3.14159 : 0),
                    child: SvgPicture.asset(
                      'assets/icons/arrowback.svg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              body: BlocBuilder<PackageCubit, PackageState>(
                builder: (context, state) {
                  if (state is PackagesLoading) {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                      itemCount: 4,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) => Skeletonizer(
                        enabled: true,
                        child: PackageCard(
                          title: "Loading...",
                          price: "—",
                          image: "",
                          description: "Loading...",
                          onTap: () {},
                        ),
                      ),
                    );
                  } else if (state is PackagesLoaded) {
                    
                    final List<dynamic> packages =
                        state.packagesData['data'] is List
                            ? state.packagesData['data']
                            : (state.packagesData['data']['packages'] ?? []);

                    if (packages.isEmpty) {
                      return Center(
                        child: Text(
                          isArabic ? 'لا توجد باقات متاحة' : 'No packages available',
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.mainBlack,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                      itemCount: packages.length,
                      itemBuilder: (context, index) {
                        final package = packages[index];

                        final packageTitle = isArabic
                            ? (package['nameAr'] ?? package['name'] ?? 'بلا عنوان')
                            : (package['name'] ?? 'Unknown');

                        final packageSlug = package['slug'] ?? package['_id'] ?? '';
                        final packagePrice = package['price'] ?? 'N/A';

                        // ✅✅ FIXED IMAGE PARSING LOGIC ✅✅
                        String packageImage = '';

                        // Priority 1: Check nested "images.coverImage.url" (From your logs)
                        if (package['images'] != null && 
                            package['images'] is Map && 
                            package['images']['coverImage'] != null) {
                          packageImage = package['images']['coverImage']['url'] ?? '';
                        } 
                        // Priority 2: Check "imageCover" object (Standard in some endpoints)
                        else if (package['imageCover'] != null) {
                          if (package['imageCover'] is Map) {
                            packageImage = package['imageCover']['url'] ?? '';
                          } else if (package['imageCover'] is String) {
                            packageImage = package['imageCover'];
                          }
                        }
                        // Priority 3: Check "image" object
                        else if (package['image'] != null) {
                          if (package['image'] is Map) {
                            packageImage = package['image']['url'] ?? '';
                          } else if (package['image'] is String) {
                            packageImage = package['image'];
                          }
                        }

                        final packageDescription = isArabic
                            ? (package['descriptionAr'] ?? package['description'] ?? '')
                            : (package['description'] ?? '');

                        return PackageCard(
                          title: packageTitle,
                          price: packagePrice,
                          image: packageImage, // ✅ Passing correct URL
                          description: packageDescription,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.packageDetailsView,
                              arguments: {
                                'slug': packageSlug,
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
          ),
        );
      },
    );
  }
}