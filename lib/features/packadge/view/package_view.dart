import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/router/routes.dart';
import '../data/repo/package_repo.dart';
import '../manager/package_cubit.dart';
import '../manager/package_state.dart';
import 'widget/Package_widget.dart';

class PackageView extends StatefulWidget {
  const PackageView({super.key});

  @override
  State<PackageView> createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView> {
  late PackageCubit _packageCubit;

  @override
  void initState() {
    super.initState();
    _packageCubit = PackageCubit(PackageTypeRepo())..getAllPackages();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return BlocProvider.value(
      value: _packageCubit,
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            leading: const SizedBox(),
            title: Text(
              isArabic ? 'أنواع الباقات' : 'Package Type',
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.mainBlack,
              ),
            ),
            centerTitle: true,
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
                      isArabic
                          ? 'لا توجد باقات متاحة حالياً'
                          : 'No packages found',
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
                      onTap: () async {
                        _packageCubit.getCountriesForPackageType(pkg.id ?? '');

                        await Navigator.pushNamed(
                          context,
                          Routes.countriesView,
                          arguments: {
                            'packageTypeId': pkg.sId ?? '',
                            'packageTypeName': isArabic
                                ? (pkg.nameAr ?? pkg.name ?? '')
                                : (pkg.name ?? ''),
                          },
                        );

                        // 🔁 Refresh بعد الرجوع من countries view
                        _packageCubit.getAllPackages();
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
                        isArabic
                            ? 'حدث خطأ: ${state.message}'
                            : 'Error: ${state.message}',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.setPoppinsSecondaryBlack(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _packageCubit.getAllPackages(),
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

  @override
  void dispose() {
    _packageCubit.close();
    super.dispose();
  }
}
