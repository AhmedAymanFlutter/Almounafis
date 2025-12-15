import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildDrawerHeader(bool isArabic) {
  return DrawerHeader(
    decoration: const BoxDecoration(color: AppColor.secondaryblue),
    child: Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/splash/main_logo.png',
            width: 48,
            height: 48,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isArabic ? 'مرحبًا بك' : 'Welcome User',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget buildDrawerItem(
  BuildContext context, {
  required String iconPath,
  required String title,
  required VoidCallback onTap,
  Color? textColor,
}) {
  return ListTile(
    leading: SvgPicture.asset(
      iconPath,
      width: 24,
      height: 24,
      fit: BoxFit.scaleDown,
      color: textColor ?? const Color(0xff0e2e4f),
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 16, color: textColor ?? Colors.black87),
    ),
    onTap: onTap,
    hoverColor: Colors.grey.shade100,
  );
}

Widget buildSocialMediaIcon(
  BuildContext context, {
  required String platform,
  required String url,
  String? iconUrl,
}) {
  return InkWell(
    onTap: () async {
      if (url.isNotEmpty) {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Cannot open $platform')));
        }
      }
    },
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _getSocialMediaColor(platform).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getSocialMediaColor(platform).withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Center(child: _buildIconWidget(platform, iconUrl)),
    ),
  );
}

// Build icon widget - use backend SVG if available, otherwise use default icon
Widget _buildIconWidget(String platform, String? iconUrl) {
  // Special handling for Snapchat - use image with fallback
  if (platform.toLowerCase() == 'snapchat') {
    print('🎯 Building Snapchat icon with image');
    return _buildSnapchatIcon();
  }

  if (iconUrl != null && iconUrl.isNotEmpty) {
    return _SafeSvgIcon(
      iconUrl: iconUrl,
      platform: platform,
      fallbackIcon: _getSocialMediaIcon(platform),
      fallbackColor: _getSocialMediaColor(platform),
    );
  } else {
    return Icon(
      _getSocialMediaIcon(platform),
      color: _getSocialMediaColor(platform),
      size: 24,
    );
  }
}

// Build Snapchat icon with image and fallback
// Build Snapchat icon with PNG and fallback
Widget _buildSnapchatIcon() {
  return Image.asset(
    'assets/images/snapchat.png',
    width: 24,
    height: 24,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      // Fallback to FontAwesome icon
      return Icon(
        FontAwesomeIcons.snapchat,
        color: _getSocialMediaColor('snapchat'),
        size: 24,
      );
    },
  );
}

IconData _getSocialMediaIcon(String platform) {
  switch (platform.toLowerCase()) {
    case 'facebook':
      return FontAwesomeIcons.facebook;
    case 'instagram':
      return FontAwesomeIcons.instagram;
    case 'twitter':
      return FontAwesomeIcons.twitter;
    case 'youtube':
      return FontAwesomeIcons.youtube;
    case 'linkedin':
      return FontAwesomeIcons.linkedin;
    case 'whatsapp':
      return FontAwesomeIcons.whatsapp;
    case 'tiktok':
      return FontAwesomeIcons.tiktok;
    case 'snapchat':
      return FontAwesomeIcons.snapchat;
    default:
      return FontAwesomeIcons.debian;
  }
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
    case 'tiktok':
      return Colors.black;
    case 'snapchat':
      return const Color(0xFFFFB300);

    default:
      return Colors.grey;
  }
}

// Safe SVG Icon Widget with error handling
class _SafeSvgIcon extends StatelessWidget {
  final String iconUrl;
  final String platform;
  final IconData fallbackIcon;
  final Color fallbackColor;

  const _SafeSvgIcon({
    required this.iconUrl,
    required this.platform,
    required this.fallbackIcon,
    required this.fallbackColor,
  });

  @override
  Widget build(BuildContext context) {
    if (iconUrl.toLowerCase().endsWith('.svg') && !iconUrl.contains('%')) {
      return FutureBuilder(
        future: _loadSvgSafely(iconUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == true) {
            return SvgPicture.network(
              iconUrl,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            );
          } else {
            return Icon(fallbackIcon, color: fallbackColor, size: 24);
          }
        },
      );
    } else {
      // non-SVG images
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          iconUrl,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(fallbackIcon, color: fallbackColor, size: 24);
          },
        ),
      );
    }
  }

  /// Try loading SVG and return success/fail without crashing
  Future<bool> _loadSvgSafely(String url) async {
    try {
      final response = await NetworkAssetBundle(Uri.parse(url)).load(url);
      if (response.lengthInBytes == 0) return false;
      // just to test if it's valid text
      final data = String.fromCharCodes(response.buffer.asUint8List());
      if (data.contains('%')) return false; // SVG with % values
      return true;
    } catch (_) {
      return false;
    }
  }
}
