import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalStrings {
  static String tr(BuildContext context, String key) {
    final isArabic = context.watch<LanguageCubit>().isArabic;
    return _values[key]?[isArabic ? 'ar' : 'en'] ?? key;
  }

  static const Map<String, Map<String, String>> _values = {
    // Sections
    'basic_contact': {
      'ar': 'معلومات الاتصال الأساسية',
      'en': 'Basic Contact Info',
    },
    'site_settings': {'ar': 'إعدادات الموقع', 'en': 'Website Settings'},
    'business_hours': {'ar': 'ساعات العمل', 'en': 'Business Hours'},
    'social_media': {'ar': 'وسائل التواصل الاجتماعي', 'en': 'Social Media'},
    'emergency_contacts': {
      'ar': 'جهات الاتصال للطوارئ',
      'en': 'Emergency Contacts',
    },
    'contact_info': {'ar': 'معلومات الاتصال', 'en': 'Contact Information'},
    'supported_languages': {
      'ar': 'اللغات المدعومة',
      'en': 'Supported Languages',
    },

    // Labels
    'primary_phone': {'ar': 'الهاتف الأساسي', 'en': 'Primary Phone'},
    'primary_email': {'ar': 'البريد الإلكتروني الأساسي', 'en': 'Primary Email'},
    'primary_address': {'ar': 'العنوان الأساسي', 'en': 'Primary Address'},
    'whatsapp': {'ar': 'واتساب', 'en': 'WhatsApp'},
    'maintenance_mode': {'ar': 'وضع الصيانة', 'en': 'Maintenance Mode'},
    'default_language': {'ar': 'اللغة الافتراضية', 'en': 'Default Language'},
    'allow_registration': {'ar': 'السماح بالتسجيل', 'en': 'Allow Registration'},
    'email_verification': {
      'ar': 'تفعيل البريد الإلكتروني',
      'en': 'Email Verification',
    },
    'timezone': {'ar': 'المنطقة الزمنية', 'en': 'Timezone'},
    'day': {'ar': 'يوم', 'en': 'Day'},
    'closed': {'ar': 'مغلق', 'en': 'Closed'},
    'phone': {'ar': 'هاتف', 'en': 'Phone'},
    'email': {'ar': 'بريد إلكتروني', 'en': 'Email'},
    'address': {'ar': 'عنوان', 'en': 'Address'},

    // Common
    'not_specified': {'ar': 'غير محدد', 'en': 'Not Specified'},
    'enabled': {'ar': 'مفعل', 'en': 'Enabled'},
    'disabled': {'ar': 'معطل', 'en': 'Disabled'},
  };
}
