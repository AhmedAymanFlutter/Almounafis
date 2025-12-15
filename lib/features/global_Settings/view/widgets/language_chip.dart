import 'package:almonafs_flutter/features/global_Settings/data/model/Ar_setting.dart';
import 'package:flutter/material.dart';

class LanguageChip extends StatelessWidget {
  final String label;
  final bool isDefault;

  const LanguageChip({super.key, required this.label, required this.isDefault});

  @override
  Widget build(BuildContext context) {
    final displayText = label.trim().isNotEmpty
        ? label
        : GlobalStrings.tr(context, 'not_specified');

    return Chip(
      label: Text(displayText),
      backgroundColor: isDefault ? Colors.blue.shade100 : Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isDefault ? Colors.blue.shade700 : Colors.grey.shade700,
        fontWeight: FontWeight.w600,
      ),
      avatar: isDefault
          ? Icon(Icons.check_circle, color: Colors.blue.shade700, size: 18)
          : null,
    );
  }
}
