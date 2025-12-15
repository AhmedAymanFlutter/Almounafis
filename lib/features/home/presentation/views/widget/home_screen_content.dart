import 'package:almonafs_flutter/features/home/presentation/views/widget/countries_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/router/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../localization/manager/localization_cubit.dart';
import '../../../../upcomming_Tour/view/tour_view.dart';
import '../../../manager/country_cubit.dart';
import '../../../manager/country_state.dart';
import '../../widgets/section_title.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColor.secondaryblue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.menu,
                          color: AppColor.mainWhite,
                          size: 24,
                        ),
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// 🌍 Our Countries Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SectionTitle(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.allCountriesPage),
                title: isArabic ? "دولنا" : "Our Countries",
              ),
            ),
            const SizedBox(height: 12),

            BlocBuilder<CountryCubit, CountryState>(
              builder: (context, state) =>
                  CountriesSection(state: state, isArabic: isArabic),
            ),

            const SizedBox(height: 24),

            /// 🗺️ Upcoming Tours Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SectionTitle(
                onTap: () => Navigator.pushNamed(context, Routes.allToursPage),
                title: isArabic ? "الجولات القادمة" : "Upcoming Tours",
              ),
            ),
            const SizedBox(height: 6),
            const SizedBox(
              height: 300,
              child: SingleChildScrollView(child: UpcomingTourList()),
            ),
          ],
        ),
      ),
    );
  }
}
