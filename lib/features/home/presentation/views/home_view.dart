import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/global_Settings/data/model/global_Setting_model.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:almonafs_flutter/features/packadge/view/package_view.dart';
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
              SocialMediaSection? socialMedia;
              if (globalSettingsState is GlobalSettingsLoaded) {
                socialMedia =
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
                  backgroundColor: AppColor.secondaryblue,
                  child: SvgPicture.asset('assets/images/whatsapp.svg'),
                ),
                backgroundColor: AppColor.mainWhite,
                drawer: CustomDrawer(
                  onNavigationItemTapped: _onItemTapped,
                  socialMedia: socialMedia,
                ),
                body: SafeArea(
                  child: _selectedIndex == 1
                      ? const HomeContent()
                      : _buildOtherPages(),
                ),

                bottomNavigationBar: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColor.secondaryblue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: BottomNavigationBar(
                      currentIndex: _selectedIndex,
                      onTap: _onItemTapped,
                      backgroundColor: AppColor.secondaryblue,
                      selectedItemColor: AppColor.mainWhite,
                      unselectedItemColor: Colors.grey[400],
                      type: BottomNavigationBarType.fixed,
                      showUnselectedLabels: true,
                      selectedLabelStyle: AppTextStyle.setPoppinsWhite(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      unselectedLabelStyle: AppTextStyle.setPoppinsWhite(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      items: [
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: SvgPicture.asset(
                              "assets/icons/bag.svg",
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 0
                                    ? AppColor.mainWhite
                                    : Colors.grey[400]!,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: isArabic ? "الرحلات" : "Trips",
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: SvgPicture.asset(
                              "assets/icons/home.svg",
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 1
                                    ? AppColor.mainWhite
                                    : Colors.grey[400]!,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: isArabic ? "الرئيسية" : "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: SvgPicture.asset(
                              "assets/icons/sleep.svg",
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 2
                                    ? AppColor.mainWhite
                                    : Colors.grey[400]!,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: isArabic ? "الفنادق" : "Hotels",
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: SvgPicture.asset(
                              "assets/icons/Packages.svg",
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 3
                                    ? AppColor.mainWhite
                                    : Colors.grey[400]!,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: isArabic ? "الباقات" : "Packages",
                        ),
                      ],
                    ),
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
