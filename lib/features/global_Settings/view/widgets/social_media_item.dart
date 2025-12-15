import 'package:flutter/material.dart';
import '../../data/model/global_Setting_model.dart'; // Ensure correct import path for SocialPlatform

class SocialMediaItem extends StatelessWidget {
  final String platform;
  final SocialPlatform data;

  const SocialMediaItem({
    super.key,
    required this.platform,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getSocialMediaColor(platform);
    final icon = _getSocialMediaIcon(platform);

    return Row(
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
                platform,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (data.url != null && data.url!.isNotEmpty)
                Text(
                  data.url!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
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
      case 'tiktok':
        return Icons.music_note;
      case 'snapchat':
        return Icons.snapchat;
      default:
        return Icons.public;
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
        return Colors.yellow.shade800;
      default:
        return Colors.grey;
    }
  }
}
