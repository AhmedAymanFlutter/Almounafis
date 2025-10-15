// views/global_settings_view.dart
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/global_Setting_model.dart';


class GlobalSettingsView extends StatefulWidget {
  const GlobalSettingsView({super.key});

  @override
  State<GlobalSettingsView> createState() => _GlobalSettingsViewState();
}

class _GlobalSettingsViewState extends State<GlobalSettingsView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.blue.shade600,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'الإعدادات العامة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade600, Colors.blue.shade400],
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      context.read<GlobalSettingsCubit>().getGlobalSettings();
                    },
                    icon: const Icon(Icons.refresh),
                    tooltip: 'تحديث',
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  );
                }
                if (state is GlobalSettingsLoaded) {
                  _fadeController.forward();
                }
              },
              builder: (context, state) {
                if (state is GlobalSettingsLoading) {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('جاري تحميل الإعدادات...'),
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
                    child: _buildSettingsContent(state.globalSettings),
                  );
                }

                if (state is GlobalSettingsError) {
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<GlobalSettingsCubit>().getGlobalSettings();
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('حاول مرة أخرى'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox(
                  height: 200,
                  child: Center(child: Text('اسحب للتحديث أو انتظر تحميل الإعدادات')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsContent(GlobalSettingModel globalSettings) {
    final data = globalSettings.data;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<GlobalSettingsCubit>().getGlobalSettings();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primary Contact Information
            _buildSection(
              title: 'معلومات الاتصال الأساسية',
              icon: Icons.contact_page,
              children: [
                if (data?.primaryPhone != null)
                  _buildInfoItem(
                    icon: Icons.phone_rounded,
                    title: 'الهاتف الأساسي',
                    value: data!.primaryPhone!.number ?? 'غير محدد',
                    color: Colors.green,
                  ),
                if (data?.primaryEmail != null)
                  _buildInfoItem(
                    icon: Icons.email_rounded,
                    title: 'البريد الإلكتروني الأساسي',
                    value: data!.primaryEmail!.email ?? 'غير محدد',
                    color: Colors.orange,
                  ),
                if (data?.primaryAddress != null)
                  _buildInfoItem(
                    icon: Icons.location_on_rounded,
                    title: 'العنوان الأساسي',
                    value: '${data!.primaryAddress!.street ?? ''}, ${data.primaryAddress!.city ?? ''}, ${data.primaryAddress!.country ?? ''}',
                    color: Colors.blue,
                  ),
                if (data?.primaryWhatsapp != null)
                  _buildInfoItem(
                    icon: Icons.chat_rounded,
                    title: 'واتساب',
                    value: data!.primaryWhatsapp!.number ?? 'غير محدد',
                    color: const Color(0xFF25D366),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Website Settings
            if (data?.websiteSettings != null)
              _buildSection(
                title: 'إعدادات الموقع',
                icon: Icons.settings_rounded,
                children: [
                  _buildToggleItem(
                    icon: Icons.settings,
                    title: 'وضع الصيانة',
                    value: data!.websiteSettings!.maintenanceMode == true,
                    color: Colors.red,
                  ),
                  _buildInfoItem(
                    icon: Icons.language,
                    title: 'اللغة الافتراضية',
                    value: data.websiteSettings!.defaultLanguage ?? 'غير محدد',
                    color: Colors.purple,
                  ),
                  _buildToggleItem(
                    icon: Icons.app_registration,
                    title: 'السماح بالتسجيل',
                    value: data.websiteSettings!.allowRegistration == true,
                    color: Colors.teal,
                  ),
                  _buildToggleItem(
                    icon: Icons.verified_user,
                    title: 'تفعيل البريد الإلكتروني',
                    value: data.websiteSettings!.requireEmailVerification == true,
                    color: Colors.indigo,
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Business Hours
            if (data?.businessHours != null)
              _buildSection(
                title: 'ساعات العمل',
                icon: Icons.schedule_rounded,
                children: [
                  _buildInfoItem(
                    icon: Icons.access_time_rounded,
                    title: 'المنطقة الزمنية',
                    value: data!.businessHours!.timezone ?? 'غير محدد',
                    color: Colors.cyan,
                  ),
                  if (data.businessHours!.workingDays != null && data.businessHours!.workingDays!.isNotEmpty)
                    ...data.businessHours!.workingDays!.map((day) =>
                      _buildInfoItem(
                        icon: Icons.calendar_today,
                        title: 'يوم ${day.day}',
                        value: day.isOpen == true ? '${day.openTime} - ${day.closeTime}' : 'مغلق',
                        color: day.isOpen == true ? Colors.green : Colors.red,
                      ),
                    ).toList(),
                ],
              ),

            const SizedBox(height: 20),

            // Social Media
            if (data?.socialMedia != null && data!.socialMedia!.isNotEmpty)
              _buildSection(
                title: 'وسائل التواصل الاجتماعي',
                icon: Icons.share_rounded,
                children: data.socialMedia!.map((social) =>
                  _buildSocialMediaItem(
                    platform: social.platform ?? 'غير محدد',
                    url: social.url,
                  ),
                ).toList(),
              ),

            const SizedBox(height: 20),

            // Emergency Contacts
            if (data?.emergencyContacts != null && data!.emergencyContacts!.isNotEmpty)
              _buildSection(
                title: 'جهات الاتصال للطوارئ',
                icon: Icons.emergency_rounded,
                children: data.emergencyContacts!.map((contact) =>
                  _buildInfoItem(
                    icon: Icons.person_rounded,
                    title: contact.name ?? 'غير محدد',
                    value: '${contact.phone ?? ''} - ${contact.role ?? ''}',
                    color: Colors.red,
                  ),
                ).toList(),
              ),

            const SizedBox(height: 20),

            // Contact Info
            if (data?.contactInfo != null && data!.contactInfo!.isNotEmpty)
              _buildSection(
                title: 'معلومات الاتصال',
                icon: Icons.info_rounded,
                children: data.contactInfo!.map((contact) =>
                  _buildInfoItem(
                    icon: _getContactInfoIcon(contact.type),
                    title: contact.type ?? 'غير محدد',
                    value: _getContactInfoValue(contact.value),
                    color: Colors.blueAccent,
                  ),
                ).toList(),
              ),

            const SizedBox(height: 20),

            // Default Currency
            if (data?.defaultCurrency != null)
              _buildSection(
                title: 'العملة الافتراضية',
                icon: Icons.currency_exchange_rounded,
                children: [
                  _buildInfoItem(
                    icon: Icons.attach_money_rounded,
                    title: 'العملة',
                    value: '${data!.defaultCurrency!.code} (${data.defaultCurrency!.symbol})',
                    color: Colors.amber,
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Default Language
            if (data?.defaultLanguageInfo != null)
              _buildSection(
                title: 'اللغة الافتراضية',
                icon: Icons.translate_rounded,
                children: [
                  _buildInfoItem(
                    icon: Icons.language,
                    title: 'اللغة',
                    value: (data!.defaultLanguageInfo!.name ?? data.defaultLanguageInfo!.code) ?? 'غير محدد',
                    color: Colors.deepPurple,
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Supported Currencies
            if (data?.websiteSettings?.supportedCurrencies != null && data!.websiteSettings!.supportedCurrencies!.isNotEmpty)
              _buildSection(
                title: 'العملات المدعومة',
                icon: Icons.attach_money_rounded,
                children: data.websiteSettings!.supportedCurrencies!.map((currency) =>
                  _buildInfoItem(
                    icon: Icons.money,
                    title: '${currency.code} (${currency.symbol})',
                    value: 'سعر الصرف: ${currency.exchangeRate}',
                    color: Colors.amber,
                  ),
                ).toList(),
              ),

            const SizedBox(height: 20),

            // Supported Languages
            if (data?.websiteSettings?.supportedLanguages != null && data!.websiteSettings!.supportedLanguages!.isNotEmpty)
              _buildSection(
                title: 'اللغات المدعومة',
                icon: Icons.public_rounded,
                children: data.websiteSettings!.supportedLanguages!.map((language) =>
                  _buildLanguageChip(
                    language.name ?? language.code ?? 'غير محدد',
                    language.isDefault == true,
                  ),
                ).toList(),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue.shade600, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: List.generate(
              children.length,
              (index) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: children[index],
                  ),
                  if (index < children.length - 1)
                    Divider(height: 1, color: Colors.grey.shade300),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value.isNotEmpty ? value : 'غير محدد',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required bool value,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: value ? Colors.green.shade100 : Colors.red.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value ? 'مفعل' : 'معطل',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: value ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaItem({required String platform, required String? url}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getSocialMediaColor(platform).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getSocialMediaIcon(platform),
            size: 20,
            color: _getSocialMediaColor(platform),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                platform,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (url != null && url.isNotEmpty)
                Text(
                  url,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageChip(String language, bool isDefault) {
    return Chip(
      label: Text(language),
      backgroundColor: isDefault ? Colors.blue.shade100 : Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isDefault ? Colors.blue.shade700 : Colors.grey.shade700,
        fontWeight: FontWeight.w600,
      ),
      avatar: isDefault ? Icon(Icons.check_circle, color: Colors.blue.shade700, size: 18) : null,
    );
  }

  IconData _getSocialMediaIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt;
      case 'twitter':
        return Icons.chat;
      case 'youtube':
        return Icons.videocam;
      case 'linkedin':
        return Icons.business;
      case 'whatsapp':
        return Icons.chat_bubble;
      default:
        return Icons.public;
    }
  }

  IconData _getContactInfoIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'phone':
        return Icons.phone;
      case 'email':
        return Icons.email;
      case 'address':
        return Icons.location_on;
      case 'whatsapp':
        return Icons.chat;
      default:
        return Icons.contact_page;
    }
  }

  String _getContactInfoValue(Value? value) {
    if (value == null) return 'غير محدد';

    if (value.number != null) return value.number!;
    if (value.email != null) return value.email!;
    if (value.street != null) return '${value.street}, ${value.city}, ${value.country}';

    return 'غير محدد';
  }

  Color _getSocialMediaColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'instagram':
        return const Color(0xFFE4405F);
      case 'twitter':
        return const Color(0xFF1DA1F2);
      case 'youtube':
        return const Color(0xFFFF0000);
      case 'linkedin':
        return const Color(0xFF0A66C2);
      case 'whatsapp':
        return const Color(0xFF25D366);
      default:
        return Colors.grey;
    }
  }
}