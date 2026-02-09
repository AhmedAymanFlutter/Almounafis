import 'package:almonafs_flutter/features/cities/data/repo/citeies_repo.dart';
import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';

import 'package:almonafs_flutter/features/viator/view/widget/viator_filter_widget.dart';
import 'package:almonafs_flutter/features/viator/view/widget/viator_tour_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViatorAllToursPage extends StatelessWidget {
  const ViatorAllToursPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine language from localization cubit or directionality
    final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    return BlocProvider(
      create: (context) => CityCubit(CityRepository())..getCities(limit: 1000),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            isArabic ? "كل الجولات" : "All Tours",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.h),

              // Filter Widget
              const ViatorFilterWidget(),

              SizedBox(height: 16.h),

              // Vertical Tour List
              Expanded(
                child: ViatorTourListWidget(
                  isArabic: isArabic,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
