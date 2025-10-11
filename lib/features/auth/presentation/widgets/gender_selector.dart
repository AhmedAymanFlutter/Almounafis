import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../localization/manager/localization_cubit.dart';

class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key});

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? gender;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  activeColor: AppColor.secondaryblue,
                  title: Text(isArabic ? "ذكر" : "Male"),
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) => setState(() => gender = value),
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  activeColor: AppColor.secondaryblue,
                  title: Text(isArabic ? "أنثى" : "Female"),
                  value: "female",
                  groupValue: gender,
                  onChanged: (value) => setState(() => gender = value),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
