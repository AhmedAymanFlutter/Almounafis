import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key});

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            activeColor: AppColor.secondaryblue,
            title: const Text("male"),
            value: "male",
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value),
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text("female"),
            value: "female",
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value),
          ),
        ),
      ],
    );
  }
}
