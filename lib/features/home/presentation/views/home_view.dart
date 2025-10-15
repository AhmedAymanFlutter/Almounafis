import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../../core/helper/Fun_helper.dart';
import '../../../../core/theme/app_color.dart';
import '../../../flightScreen/view/UpcomingTripsPage.dart';
import '../../../hotels/view/HotelsPage.dart';
import '../../../localization/manager/localization_cubit.dart';
import 'widget/cusstom_drawer_widget.dart';
import 'widget/home_content.dart';
import 'widget/utils/build_nav_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        final isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            floatingActionButton:  FloatingActionButton(
              onPressed: () {
                final globalSettingsState = context.read<GlobalSettingsCubit>().state;
                            if (globalSettingsState is GlobalSettingsLoaded) {
                            WhatsAppService.launchWhatsApp(
                              context,
                              isArabic: isArabic,
                               settings: globalSettingsState.globalSettings,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isArabic 
                                    ? "جاري تحميل الإعدادات..." 
                                    : "Loading settings..."
                                ),
                              ),
                            );
                          }
              },
              backgroundColor: Colors.green,
              child: Icon(
                Icons.call,
                color: AppColor.mainWhite,
              ),
            ),
            backgroundColor: AppColor.mainWhite,
            drawer: CustomDrawer(onNavigationItemTapped: _onItemTapped),
            body: SafeArea(
              child: _selectedIndex == 1
                  ? const HomeContent()
                  : _buildOtherPages(),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: _selectedIndex,
              backgroundColor: Colors.transparent,
              color: AppColor.secondaryBlack,
              buttonBackgroundColor: AppColor.mainWhite,
              animationDuration: const Duration(milliseconds: 300),
              onTap: _onItemTapped,
              items: [
                buildNavItem(
                  icon: "assets/icons/bag.svg",
                  label: isArabic ? "الرحلات" : "Trips",
                  isSelected: _selectedIndex == 0,
                ),
                buildNavItem(
                  icon: "assets/icons/home.svg",
                  label: isArabic ? "الرئيسية" : "Home",
                  isSelected: _selectedIndex == 1,
                ),
                buildNavItem(
                  icon: "assets/icons/sleep.svg",
                  label: isArabic ? "الفنادق" : "Hotels",
                  isSelected: _selectedIndex == 2,
                ),
             
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtherPages() {
    switch (_selectedIndex) {
      case 0:
        return const FlightBookingScreen();
      case 2:
        return  HotelsPage();
      default:
        return const HomeContent();
    }
  }
}
