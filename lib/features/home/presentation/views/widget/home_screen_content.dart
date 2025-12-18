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
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.95,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header with Menu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: AppColor.secondaryblue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.secondaryblue.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: AppColor.mainWhite,
                              size: 26,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                      ),
                      Text(
                        isArabic ? 'استكشف' : 'Explore',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondaryblue,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: AppColor.secondaryblue,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),

                /// 🌍 Our Countries Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.allCountriesPage),
                    title: isArabic ? "دولنا" : "Our Countries",
                  ),
                ),
                const SizedBox(height: 16),

                BlocBuilder<CountryCubit, CountryState>(
                  builder: (context, state) =>
                      CountriesSection(state: state, isArabic: isArabic),
                ),

                const SizedBox(height: 32),

                /// 🗺️ Upcoming Tours Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(
                    onTap: () => Navigator.pushNamed(context, Routes.allToursPage),
                    title: isArabic ? "الجولات القادمة" : "Upcoming Tours",
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(
                  height: 800,
                  child: SingleChildScrollView(child: UpcomingTourList()),
                ),
                
                const SizedBox(height: 120), // Extra space for bottom nav
              ],
            ),
          ),
        ),
      ),
    );
  }
}
