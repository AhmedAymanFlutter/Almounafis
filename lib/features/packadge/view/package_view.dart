import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/router/routes.dart';
import '../data/repo/package_repo.dart';
import '../manager/package_cubit.dart';
import '../manager/package_state.dart';
import 'widget/Package_widget.dart';

class PackageView extends StatelessWidget {
  const PackageView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return BlocProvider(
      create: (_) => PackageCubit(PackageTypeRepo())..getAllPackages(),
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          
          appBar: AppBar(
            title: Text(
              isArabic ? 'أنواع الباقات' : 'Package Type',
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.mainBlack,
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.home),
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
              if (state is PackageLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PackageLoaded) {
                final packages = state.packageModel.data ?? [];

                if (packages.isEmpty) {
                  return Center(
                    child: Text(
                      isArabic ? 'لا توجد باقات متاحة حالياً' : 'No packages found',
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    final pkg = packages[index];
                    return PackageCardView(
                      package: pkg,
                      onTap: () {
                        context.read<PackageCubit>().getCountriesForPackageType(pkg.id ?? '');
                        Navigator.pushNamed(
                          context,
                          Routes.countriesView,
                          arguments: {
                            'packageTypeId': pkg.sId ?? '',
                            'packageTypeName': isArabic
                                ? (pkg.nameAr ?? pkg.name ?? '')
                                : (pkg.name ?? ''),
                          },
                        );
                      },
                    );
                  },
                );
              } else if (state is PackageError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isArabic ? 'حدث خطأ: ${state.message}' : 'Error: ${state.message}',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.setPoppinsSecondaryBlack(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<PackageCubit>().getAllPackages(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.mainBlack,
                          foregroundColor: AppColor.mainWhite,
                        ),
                        child: Text(isArabic ? 'إعادة المحاولة' : 'Retry'),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
