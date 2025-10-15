import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/global_Settings/data/model/global_Setting_model.dart';

class WhatsAppService {
 static Future<void> launchWhatsApp(
  BuildContext context, {
  required bool isArabic,
  String? customMessage,
  GlobalSettingModel? settings, // Add this parameter
}) async {
  // Use passed settings or fallback to static
  final whatsappNumber = settings?.data?.primaryWhatsapp?.number ?? 
                         globalSettings?.data?.primaryWhatsapp?.number;
  
  print('WhatsApp Number: $whatsappNumber');
  print('Settings available: ${settings != null}');
  print('Global settings available: ${globalSettings != null}');
  
  // Validate phone number
  if (whatsappNumber == null || whatsappNumber.isEmpty) {
    _showSnackBar(
      context,
      isArabic 
        ? "رقم الواتس غير متوفر" 
        : "WhatsApp number not available",
    );
    return;
  }

  final message = customMessage ??
      (isArabic 
        ? "السلام عليكم، أرغب في الحجز" 
        : "Hello, I would like to book");

  final whatsappUrl =
      "https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(message)}";

  try {
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      _showSnackBar(
        context,
        isArabic 
          ? "تطبيق الواتس غير مثبت" 
          : "WhatsApp is not installed",
      );
    }
  } catch (e) {
    _showSnackBar(context, "Error: $e");
  }
}

 static void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
 }

 // Static variable to hold global settings
 static GlobalSettingModel? globalSettings;

 // Method to set global settings
 static void setGlobalSettings(GlobalSettingModel? settings) {
  globalSettings = settings;
 }
}