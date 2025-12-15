import 'package:almonafs_flutter/features/global_Settings/data/model/Ar_setting.dart';
import 'package:flutter/material.dart';

class SettingsToggleItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final Color color;

  const SettingsToggleItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final statusText = value
        ? GlobalStrings.tr(context, 'enabled')
        : GlobalStrings.tr(context, 'disabled');

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
            statusText,
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
}
