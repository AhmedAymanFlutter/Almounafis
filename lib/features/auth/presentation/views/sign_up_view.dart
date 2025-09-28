import 'package:almonafs_flutter/core/helper/text_helper.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/account_info_header.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/custom_text_form_feild.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/gender_selector.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/header_text.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/header_of_view.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/photo_section.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/custom_button.dart';
import 'package:almonafs_flutter/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderOfView(text: TextHelper.accountInfo),
                      SizedBox(height: 28.h),
                      PhotoSection(),
                      SizedBox(height: 22.h),
                      HeaderText(text: TextHelper.gender),
                      SizedBox(height: 10.h),
                      GenderSelector(),
                      SizedBox(height: 22.h),
                      HeaderText(text: TextHelper.firstName),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        label: "Enter your First Name",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 22.h),
                      HeaderText(text: TextHelper.lastName),
                      SizedBox(height: 10.h),

                      CustomTextFormField(
                        label: "Enter your Last Name",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 22.h),
                      HeaderText(text: TextHelper.email),
                      SizedBox(height: 10.h),

                      CustomTextFormField(
                        label: "Enter your Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 22.h),
                      HeaderText(text: TextHelper.phoneNumber),
                      SizedBox(height: 10.h),

                      CustomTextFormField(
                        label: "Phone Number",
                        isPhoneField: true,
                      ),
                      SizedBox(height: 35.h),
                      CustomButton(
                        text: TextHelper.save,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ),
                            (route) => false,
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
    );
  }
}
