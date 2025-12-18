import 'package:almonafs_flutter/features/global_Settings/data/model/global_Setting_model.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:almonafs_flutter/features/packadge/view/package_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helper/Fun_helper.dart';
import '../../../../core/theme/app_color.dart';
import '../../../cities/view/city_view.dart';
import '../../../flightScreen/view/UpcomingTripsPage.dart';
import '../../../hotels/view/HotelsPage.dart';
import '../../../localization/manager/localization_cubit.dart';
import 'widget/cusstom_drawer_widget.dart';
import 'widget/home_content.dart';
import 'widget/custom_bottom_nav_bar.dart';

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
                backgroundColor: AppColor.mainWhite,
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
                  child: SvgPicture.asset(
                    'assets/images/whatsapp.svg',
                    width: 30,
                    height: 30,
                    fit: BoxFit.scaleDown,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
                drawer: CustomDrawer(
                  onNavigationItemTapped: _onItemTapped,
                  socialMedia: socialMedia,
                ),
                body: SafeArea(
                  child: _selectedIndex == 1
                      ? const HomeContent()
                      : _buildOtherPages(),
                ),
                bottomNavigationBar: CustomBottomNavBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  isArabic: isArabic,
                ),
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
      case 4:
        return const CityPage();
      default:
        return const HomeContent();
    }
  }
}
