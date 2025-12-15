import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/global_Settings/view/widgets/global_settings_body.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/global_cubit.dart';
import '../manager/global_stete.dart';

class GlobalSettingsView extends StatefulWidget {
  const GlobalSettingsView({super.key});

  @override
  State<GlobalSettingsView> createState() => _GlobalSettingsViewState();
}

class _GlobalSettingsViewState extends State<GlobalSettingsView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _isInitialized = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GlobalSettingsCubit>().getGlobalSettings();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  // Helper method for local translations
  String _tr(BuildContext context, String key) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    final Map<String, Map<String, String>> localizedStrings = {
      'title': {'ar': 'الإعدادات العامة', 'en': 'General Settings'},
      'refresh_tooltip': {'ar': 'تحديث', 'en': 'Refresh'},
      'loading': {'ar': 'جاري تحميل الإعدادات...', 'en': 'Loading settings...'},
      'try_again': {'ar': 'حاول مرة أخرى', 'en': 'Try Again'},
      'swipe_hint': {
        'ar': 'اسحب للتحديث أو انتظر تحميل الإعدادات',
        'en': 'Swipe to refresh or wait for settings to load',
      },
    };

    return localizedStrings[key]?[isArabic ? 'ar' : 'en'] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    // 1. Wrap with BlocBuilder to listen for Language changes
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, languageState) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                elevation: 0,
                backgroundColor: AppColor.secondaryblue,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    _tr(context, 'title'), // 2. Use the translation helper
                    style: AppTextStyle.setPoppinsWhite(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(color: AppColor.secondaryblue),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          context
                              .read<GlobalSettingsCubit>()
                              .getGlobalSettings();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          color: AppColor.mainWhite,
                        ),
                        tooltip: _tr(context, 'refresh_tooltip'),
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: BlocConsumer<GlobalSettingsCubit, GlobalSettingsState>(
                  listener: (context, state) {
                    if (state is GlobalSettingsError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red.shade400,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    }
                    if (state is GlobalSettingsLoaded) {
                      _fadeController.forward();
                    }
                  },
                  builder: (context, state) {
                    if (state is GlobalSettingsLoading) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              Text(_tr(context, 'loading')),
                            ],
                          ),
                        ),
                      );
                    }

                    if (state is GlobalSettingsLoaded) {
                      if (_isInitialized) {
                        _fadeController.forward(from: 0.0);
                      }
                      return FadeTransition(
                        opacity: _fadeController,
                        child: GlobalSettingsBody(
                          globalSettings: state.globalSettings,
                        ),
                      );
                    }

                    if (state is GlobalSettingsError) {
                      return SizedBox(
                        height: 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 80,
                                color: Colors.red.shade300,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                state.message,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context
                                      .read<GlobalSettingsCubit>()
                                      .getGlobalSettings();
                                },
                                icon: const Icon(Icons.refresh),
                                label: Text(_tr(context, 'try_again')),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 200,
                      child: Center(child: Text(_tr(context, 'swipe_hint'))),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
