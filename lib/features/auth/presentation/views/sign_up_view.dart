import 'package:almonafs_flutter/core/helper/text_helper.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/account_info_header.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/custom_text_form_feild.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/gender_selector.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/header_text.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/header_of_view.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/photo_section.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/router/routes.dart';
import '../../../localization/manager/localization_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: const Color(0xff0e2e4f),
            body: SafeArea(
              child: Column(
                children: [
                  const AccountInfoHeader(),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderOfView(
                              text: isArabic
                                  ? TextHelperAr.accountInfo
                                  : TextHelperEn.accountInfo,
                            ),
                            SizedBox(height: 28.h),
                            const PhotoSection(),
                            SizedBox(height: 22.h),
                            HeaderText(
                              text: isArabic
                                  ? TextHelperAr.gender
                                  : TextHelperEn.gender,
                            ),
                            SizedBox(height: 10.h),
                            const GenderSelector(),
                            SizedBox(height: 22.h),
                            HeaderText(
                              text: isArabic
                                  ? TextHelperAr.firstName
                                  : TextHelperEn.firstName,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              label: isArabic
                                  ? "أدخل الاسم الأول"
                                  : "Enter your First Name",
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 22.h),
                            HeaderText(
                              text: isArabic
                                  ? TextHelperAr.lastName
                                  : TextHelperEn.lastName,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              label: isArabic
                                  ? "أدخل الاسم الأخير"
                                  : "Enter your Last Name",
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 22.h),
                            HeaderText(
                              text: isArabic
                                  ? TextHelperAr.email
                                  : TextHelperEn.email,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              label: isArabic
                                  ? "أدخل البريد الإلكتروني"
                                  : "Enter your Email",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 22.h),
                            HeaderText(
                              text: isArabic
                                  ? TextHelperAr.phoneNumber
                                  : TextHelperEn.phoneNumber,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              label: isArabic
                                  ? "رقم الهاتف"
                                  : "Phone Number",
                              isPhoneField: true,
                            ),
                            SizedBox(height: 35.h),
                            CustomButton(
                              text: isArabic
                                  ? TextHelperAr.save
                                  : TextHelperEn.save,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.home,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
