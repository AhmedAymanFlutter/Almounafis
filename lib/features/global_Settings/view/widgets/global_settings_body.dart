import 'package:almonafs_flutter/features/global_Settings/data/model/Ar_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/global_Setting_model.dart';
import '../../manager/global_cubit.dart';
import 'settings_section.dart';
import 'settings_info_item.dart';
import 'settings_toggle_item.dart';
import 'social_media_item.dart';
import 'language_chip.dart';

class GlobalSettingsBody extends StatelessWidget {
  final GlobalSettingModel globalSettings;

  const GlobalSettingsBody({super.key, required this.globalSettings});

  @override
  Widget build(BuildContext context) {
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
            SettingsSection(
              title: GlobalStrings.tr(context, 'basic_contact'),
              icon: Icons.contact_page,
              children: [
                if (data?.primaryPhone != null)
                  SettingsInfoItem(
                    icon: Icons.phone_rounded,
                    title: GlobalStrings.tr(context, 'primary_phone'),
                    value: data!.primaryPhone!.number ?? '',
                    color: Colors.green,
                  ),
                if (data?.primaryEmail != null)
                  SettingsInfoItem(
                    icon: Icons.email_rounded,
                    title: GlobalStrings.tr(context, 'primary_email'),
                    value: data!.primaryEmail!.email ?? '',
                    color: Colors.orange,
                  ),
                if (data?.primaryAddress != null)
                  SettingsInfoItem(
                    icon: Icons.location_on_rounded,
                    title: GlobalStrings.tr(context, 'primary_address'),
                    value:
                        '${data!.primaryAddress!.street ?? ''}, ${data.primaryAddress!.city ?? ''}, ${data.primaryAddress!.country ?? ''}',
                    color: Colors.blue,
                  ),
                if (data?.primaryWhatsApp != null)
                  SettingsInfoItem(
                    icon: Icons.chat_rounded,
                    title: GlobalStrings.tr(context, 'whatsapp'),
                    value: data!.primaryWhatsApp!.number ?? '',
                    color: const Color(0xFF25D366),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Website Settings
            if (data?.websiteSettings != null)
              SettingsSection(
                title: GlobalStrings.tr(context, 'site_settings'),
                icon: Icons.settings_rounded,
                children: [
                  SettingsToggleItem(
                    icon: Icons.settings,
                    title: GlobalStrings.tr(context, 'maintenance_mode'),
                    value: data!.websiteSettings!.maintenanceMode == true,
                    color: Colors.red,
                  ),
                  SettingsInfoItem(
                    icon: Icons.language,
                    title: GlobalStrings.tr(context, 'default_language'),
                    value: data.websiteSettings!.defaultLanguage ?? '',
                    color: Colors.purple,
                  ),
                  SettingsToggleItem(
                    icon: Icons.app_registration,
                    title: GlobalStrings.tr(context, 'allow_registration'),
                    value: data.websiteSettings!.allowRegistration == true,
                    color: Colors.teal,
                  ),
                  SettingsToggleItem(
                    icon: Icons.verified_user,
                    title: GlobalStrings.tr(context, 'email_verification'),
                    value:
                        data.websiteSettings!.requireEmailVerification == true,
                    color: Colors.indigo,
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Business Hours
            if (data?.businessHours != null)
              SettingsSection(
                title: GlobalStrings.tr(context, 'business_hours'),
                icon: Icons.schedule_rounded,
                children: [
                  SettingsInfoItem(
                    icon: Icons.access_time_rounded,
                    title: GlobalStrings.tr(context, 'timezone'),
                    value: data!.businessHours!.timezone ?? '',
                    color: Colors.cyan,
                  ),
                  if (data.businessHours!.workingDays != null &&
                      data.businessHours!.workingDays!.isNotEmpty)
                    ...data.businessHours!.workingDays!
                        .map(
                          (day) => SettingsInfoItem(
                            icon: Icons.calendar_today,
                            title:
                                '${GlobalStrings.tr(context, 'day')} ${day.day}',
                            value: day.isOpen == true
                                ? '${day.openTime} - ${day.closeTime}'
                                : GlobalStrings.tr(context, 'closed'),
                            color: day.isOpen == true
                                ? Colors.green
                                : Colors.red,
                          ),
                        )
                        .toList(),
                ],
              ),

            const SizedBox(height: 20),

            // Social Media
            if (data?.socialMedia != null)
              SettingsSection(
                title: GlobalStrings.tr(context, 'social_media'),
                icon: Icons.share_rounded,
                children: [
                  if (data!.socialMedia!.facebook != null)
                    SocialMediaItem(
                      platform: 'Facebook',
                      data: data.socialMedia!.facebook!,
                    ),
                  if (data.socialMedia!.instagram != null)
                    SocialMediaItem(
                      platform: 'Instagram',
                      data: data.socialMedia!.instagram!,
                    ),
                  if (data.socialMedia!.twitter != null)
                    SocialMediaItem(
                      platform: 'Twitter',
                      data: data.socialMedia!.twitter!,
                    ),
                  if (data.socialMedia!.youtube != null)
                    SocialMediaItem(
                      platform: 'YouTube',
                      data: data.socialMedia!.youtube!,
                    ),
                  if (data.socialMedia!.linkedin != null)
                    SocialMediaItem(
                      platform: 'LinkedIn',
                      data: data.socialMedia!.linkedin!,
                    ),
                  if (data.socialMedia!.snapchat != null)
                    SocialMediaItem(
                      platform: 'Snapchat',
                      data: data.socialMedia!.snapchat!,
                    ),
                  if (data.socialMedia!.tiktok != null)
                    SocialMediaItem(
                      platform: 'TikTok',
                      data: data.socialMedia!.tiktok!,
                    ),
                ],
              ),

            const SizedBox(height: 20),

            // Emergency Contacts
            if (data?.emergencyContacts != null &&
                data!.emergencyContacts!.isNotEmpty)
              SettingsSection(
                title: GlobalStrings.tr(context, 'emergency_contacts'),
                icon: Icons.emergency_rounded,
                children: data.emergencyContacts!
                    .map(
                      (contact) => SettingsInfoItem(
                        icon: Icons.person_rounded,
                        title: contact.name ?? '',
                        value: '${contact.phone ?? ''} - ${contact.role ?? ''}',
                        color: Colors.red,
                      ),
                    )
                    .toList(),
              ),

            const SizedBox(height: 20),

            // Contact Info
            if (data?.contactInfo != null)
              SettingsSection(
                title: GlobalStrings.tr(context, 'contact_info'),
                icon: Icons.info_rounded,
                children: [
                  if (data!.contactInfo!.phones != null)
                    ...data.contactInfo!.phones!.map(
                      (phone) => SettingsInfoItem(
                        icon: Icons.phone,
                        title:
                            phone.label ?? GlobalStrings.tr(context, 'phone'),
                        value: phone.number ?? '',
                        color: Colors.blueAccent,
                      ),
                    ),
                  if (data.contactInfo!.emails != null)
                    ...data.contactInfo!.emails!.map(
                      (email) => SettingsInfoItem(
                        icon: Icons.email,
                        title:
                            email.label ?? GlobalStrings.tr(context, 'email'),
                        value: email.email ?? '',
                        color: Colors.orangeAccent,
                      ),
                    ),
                  if (data.contactInfo!.addresses != null)
                    ...data.contactInfo!.addresses!.map(
                      (addr) => SettingsInfoItem(
                        icon: Icons.location_city,
                        title:
                            addr.label ?? GlobalStrings.tr(context, 'address'),
                        value: '${addr.street ?? ''}, ${addr.city ?? ''}',
                        color: Colors.greenAccent,
                      ),
                    ),
                ],
              ),

            const SizedBox(height: 20),

            // Supported Languages
            if (data?.websiteSettings?.supportedLanguages != null &&
                data!.websiteSettings!.supportedLanguages!.isNotEmpty)
              SettingsSection(
                title: GlobalStrings.tr(context, 'supported_languages'),
                icon: Icons.public_rounded,
                children: data.websiteSettings!.supportedLanguages!
                    .map(
                      (language) => LanguageChip(
                        label: language.name ?? language.code ?? '',
                        isDefault: language.isDefault == true,
                      ),
                    )
                    .toList(),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
