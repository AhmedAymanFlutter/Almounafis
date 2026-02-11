import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context, isArabic),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Journey Section
                    _buildSectionTitle(
                      context,
                      isArabic ? "رحلتنا" : "Our Journey",
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      isArabic
                          ? "بدأت قصة شركة المنافس قبل تسع سنوات، حين تأسّس أول فروعنا في المملكة العربية السعودية بهدف واحد واضح: تقديم خدمات سياحية موثوقة، راقية، وبأسعار تنافسية دون المساس بجودة التجربة.\n\nمع مرور الوقت، وبفضل ثقة عملائنا و نجاحات رحلاتهم المتتالية، توسّعت رؤيتنا لتصل إلى الإمارات العربية المتحدة، حيث كان افتتاح فرع المنافس – دبي خطوة طبيعية نحو خدمة نطاق أوسع من المسافرين، خاصة في واحدة من أهم مدن العالم للسياحة والطيران.\n\nاليوم، يشكّل فرع دبي نقطة انطلاق جديدة في رحلتنا، وامتدادًا لخبرة طويلة في تصميم رحلات سياحية عالمية تناسب العائلات والأفراد والشركات، مع توفير أعلى مستويات الجودة في التخطيط، التنفيذ، وخدمة ما بعد البيع."
                          : "Al Mounafes started 9 years ago in Saudi Arabia with a clear goal: providing reliable, high-end tourism services at competitive prices.\n\nExpanding to the UAE with our Dubai branch was a natural step to serve a wider range of travelers in a global tourism hub.\n\nToday, our Dubai branch marks a new chapter, offering world-class travel experiences for families, individuals, and businesses with top-tier planning and support.",
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ).copyWith(height: 1.6),
                    ),
                    SizedBox(height: 32.h),

                    // Vision & Mission
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            icon: Icons.visibility_outlined,
                            title: isArabic ? "رؤيتنا" : "Our Vision",
                            content: isArabic
                                ? "أن نكون الشركة العربية الأكثر موثوقية في مجال السفر والسياحة داخل الخليج."
                                : "To be the most trusted Arab travel and tourism company in the Gulf.",
                            color: AppColor.lightBlue.withOpacity(0.1),
                            iconColor: AppColor.lightBlue,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            icon: Icons.track_changes_outlined,
                            title: isArabic ? "رسالتنا" : "Our Mission",
                            content: isArabic
                                ? "الشفافية، الجودة، الأمان، والدعم المستمر طوال الرحلة."
                                : "Transparency, Quality, Safety, and Continuous Support.",
                            color: AppColor.lightPurple.withOpacity(0.1),
                            iconColor: AppColor.lightPurple,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    // Achievements Stats
                    _buildSectionTitle(
                      context,
                      isArabic ? "إنجازاتنا" : "Our Achievements",
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColor.mainWhite, // Changed from Colors.white
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.mainBlack.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildStatItem(
                                context,
                                "1800+",
                                isArabic ? "عملاء سعداء" : "Happy Clients",
                              ),
                              _buildStatItem(
                                context,
                                "400+",
                                isArabic ? "وجهات سياحية" : "Destinations",
                              ),
                            ],
                          ),
                          Divider(height: 32.h, color: AppColor.lightGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildStatItem(
                                context,
                                "9",
                                isArabic ? "سنوات خبرة" : "Years Experience",
                              ),
                              _buildStatItem(
                                context,
                                "98%",
                                isArabic ? "معدل الرضا" : "Satisfaction Rate",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Why Trust Us
                    _buildSectionTitle(
                      context,
                      isArabic ? "لماذا يثق بنا العملاء؟" : "Why Trust Us?",
                    ),
                    SizedBox(height: 16.h),
                    _buildFeatureTile(
                      context,
                      icon: Icons.history_edu,
                      title: isArabic ? "خبرة 9 سنوات" : "9 Years Experience",
                      subtitle: isArabic
                          ? "تعاملنا مع آلاف العملاء باحترافية والتزام."
                          : "Serving thousands with professionalism.",
                    ),
                    _buildFeatureTile(
                      context,
                      icon: Icons.verified_user_outlined,
                      title: isArabic
                          ? "فرع رسمي مرخّص في دبي"
                          : "Licensed Dubai Branch",
                      subtitle: isArabic
                          ? "سجل تجاري: 2595436 | ترخيص: 1501411"
                          : "CR: 2595436 | License: 1501411",
                    ),
                    _buildFeatureTile(
                      context,
                      icon: Icons.person_outline,
                      title: isArabic
                          ? "إدارة قوية بقيادة خبير"
                          : "Expert Management",
                      subtitle: isArabic
                          ? "بإشراف المهندس محمد نجاح وفريق متكامل."
                          : "Led by Eng. Mohamed Nagah.",
                    ),
                    _buildFeatureTile(
                      context,
                      icon: Icons.headphones_outlined,
                      title: isArabic
                          ? "دعم احترافي شامل 24/7"
                          : "24/7 Professional Support",
                      subtitle: isArabic
                          ? "فريق دعم يهتم بكل التفاصيل قبل وأثناء الرحلة."
                          : "Support team for every detail.",
                    ),
                    SizedBox(height: 32.h),

                    // Services
                    _buildSectionTitle(
                      context,
                      isArabic ? "خدماتنا" : "Our Services",
                    ),
                    SizedBox(height: 16.h),
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: [
                        _buildServiceChip(
                          context,
                          isArabic ? "رحلات سياحية" : "Tourism Trips",
                        ),
                        _buildServiceChip(
                          context,
                          isArabic ? "باقات فاخرة" : "Luxury Packages",
                        ),
                        _buildServiceChip(
                          context,
                          isArabic ? "حجوزات فنادق" : "Hotel Booking",
                        ),
                        _buildServiceChip(
                          context,
                          isArabic ? "طيران" : "Flights",
                        ),
                        _buildServiceChip(
                          context,
                          isArabic ? "كروز" : "Cruises",
                        ),
                        _buildServiceChip(
                          context,
                          isArabic ? "تأشيرات" : "Visas",
                        ),
                        _buildServiceChip(
                          context,
                          isArabic ? "تأجير سيارات" : "Car Rental",
                        ),
                        _buildServiceChip(
                          context,
                          isArabic ? "شهر العسل" : "Honeymoon",
                        ),
                        _buildServiceChip(
                          context,
                          isArabic ? "رخص دولية" : "Intl License",
                        ),
                      ],
                    ),

                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isArabic) {
    return SliverAppBar(
      expandedHeight: 220.h,
      pinned: true,
      backgroundColor: AppColor.secondaryblue,
      iconTheme: const IconThemeData(color: AppColor.mainWhite),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          isArabic ? "من نحن" : "About Us",
          style: AppTextStyle.setPoppinsWhite(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/almonafis_combany.jpeg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyle.setPoppinsBlack(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28.sp),
          SizedBox(height: 12.h),
          Text(
            title,
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: AppTextStyle.setPoppinsSecondaryBlack(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String number, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ).copyWith(color: AppColor.secondaryblue),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyle.setPoppinsSecondaryBlack(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColor.mainWhite, // Changed from Colors.white
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.lightGrey.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColor.secondaryblue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColor.secondaryblue, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: AppTextStyle.setPoppinsSecondaryBlack(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ).copyWith(color: AppColor.secondaryGrey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChip(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.mainWhite, // Changed from Colors.white
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColor.lightBlue.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: AppTextStyle.setPoppinsSecondaryBlack(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
