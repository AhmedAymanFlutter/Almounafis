import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../localization/manager/localization_cubit.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPhoneField;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.isPhoneField = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: isPhoneField
              ? Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.secondaryGrey),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: "+20",
                          items: const [
                            DropdownMenuItem(
                                value: "+20", child: Text("🇪🇬 +20")),
                            DropdownMenuItem(
                                value: "+1", child: Text("🇺🇸 +1")),
                            DropdownMenuItem(
                                value: "+44", child: Text("🇬🇧 +44")),
                            DropdownMenuItem(
                                value: "+966", child: Text("🇸🇦 +966")),
                            DropdownMenuItem(
                                value: "+971", child: Text("🇦🇪 +971")),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: label,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                              color: AppColor.secondaryGrey,
                              width: 2.w,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                              color: AppColor.secondaryblue,
                              width: 2.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: label,
                    labelStyle: AppTextStyle.setPoppinssecondaryGery(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(
                        color: AppColor.secondaryblue,
                        width: 2.w,
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
