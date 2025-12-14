import 'package:almonafs_flutter/features/global_Settings/data/model/global_Setting_model.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:almonafs_flutter/features/packadge/view/package_view.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart'; // No longer needed
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart'; // No longer needed
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helper/Fun_helper.dart';
import '../../../../core/theme/app_color.dart';
import '../../../flightScreen/view/UpcomingTripsPage.dart';
import '../../../hotels/view/HotelsPage.dart';
import '../../../localization/manager/localization_cubit.dart';
import 'widget/cusstom_drawer_widget.dart';
import 'widget/home_content.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    // Fetch global settings when the home view loads
    context.read<GlobalSettingsCubit>().getGlobalSettings();
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        final isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: BlocBuilder<GlobalSettingsCubit, GlobalSettingsState>(
            builder: (context, globalSettingsState) {
              // Extract social media list from global settings
              List<SocialMedia>? socialMediaList;
              if (globalSettingsState is GlobalSettingsLoaded) {
                socialMediaList =
                    globalSettingsState.globalSettings.data?.socialMedia;
              }

              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
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
                                : "Loading settings...",
                          ),
                        ),
                      );
                    }
                  },
                  backgroundColor: Colors.green,
                  child: SvgPicture.asset('assets/images/whatsapp.svg'),
                ),
                backgroundColor: AppColor.mainWhite,
                drawer: CustomDrawer(
                  onNavigationItemTapped: _onItemTapped,
                  socialMediaList:
                      socialMediaList, // Pass social media data here
                ),
                body: SafeArea(
                  child: _selectedIndex == 1
                      ? const HomeContent()
                      : _buildOtherPages(),
                ),

                // --- START: MODIFIED SECTION ---
                bottomNavigationBar: SizedBox(
                  height: 90,
                  child: BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                    backgroundColor: AppColor.secondaryBlack,
                    selectedItemColor:
                        AppColor.mainWhite, // Color for the selected label
                    unselectedItemColor:
                        Colors.grey[400], // Color for unselected labels
                    type: BottomNavigationBarType.fixed, // Shows all labels
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          "assets/icons/bag.svg",
                          colorFilter: ColorFilter.mode(
                            Colors.grey[400]!,
                            BlendMode.srcIn,
                          ),
                        ),
                        activeIcon: SvgPicture.asset(
                          "assets/icons/bag.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.mainWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: isArabic ? "الرحلات" : "Trips",
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          "assets/icons/home.svg",
                          colorFilter: ColorFilter.mode(
                            Colors.grey[400]!,
                            BlendMode.srcIn,
                          ),
                        ),
                        activeIcon: SvgPicture.asset(
                          "assets/icons/home.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.mainWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: isArabic ? "الرئيسية" : "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          "assets/icons/sleep.svg",
                          colorFilter: ColorFilter.mode(
                            Colors.grey[400]!,
                            BlendMode.srcIn,
                          ),
                        ),
                        activeIcon: SvgPicture.asset(
                          "assets/icons/sleep.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.mainWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: isArabic ? "الفنادق" : "Hotels",
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          "assets/icons/Packages.svg",
                          colorFilter: ColorFilter.mode(
                            Colors.grey[400]!,
                            BlendMode.srcIn,
                          ),
                        ),
                        activeIcon: SvgPicture.asset(
                          "assets/icons/Packages.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.mainWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: isArabic ? "الباقات" : "Packages",
                      ),
                    ],
                  ),
                ),
                // --- END: MODIFIED SECTION ---
              );
            },
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
        return HotelsPage();
      case 3:
        return PackageView();
      default:
        return const HomeContent();
    }
  }
}
