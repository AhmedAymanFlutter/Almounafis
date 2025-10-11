import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
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
    return BlocProvider(
      create: (_) => PackageCubit(PackageTypeRepo())..getAllPackages(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Package Type',style: AppTextStyle.setPoppinsTextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.mainBlack),),
          leading: GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.home),
            child: SvgPicture.asset('assets/icons/arrowback.svg',width: 24,height: 24,fit: BoxFit.scaleDown,)),
        ),
        body: BlocBuilder<PackageCubit, PackageState>(
          builder: (context, state) {
            if (state is PackageLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PackageLoaded) {
              final packages = state.packageModel.data ?? [];

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
                'packageTypeName': pkg.name ?? '',
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
