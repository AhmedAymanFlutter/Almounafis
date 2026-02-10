import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlContentWidget extends StatelessWidget {
  final String htmlContent;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;

  const HtmlContentWidget({
    super.key,
    required this.htmlContent,
    this.fontSize,
    this.fontWeight,
    this.textColor,
  });

  // Helper to convert TextStyle to fontFamily string
  String get _poppinsFontFamily => GoogleFonts.poppins().fontFamily!;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlContent,
      onLinkTap: (url, _, __) async {
        if (url != null) {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        }
      },
      style: {
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize((fontSize ?? 14).sp),
          fontWeight: fontWeight ?? FontWeight.w400,
          color: textColor ?? AppColor.secondaryBlack,
          lineHeight: const LineHeight(1.6),
          fontFamily: _poppinsFontFamily,
        ),
        "p": Style(
          margin: Margins.only(bottom: 12.sp),
          fontSize: FontSize((fontSize ?? 14).sp),
          color: textColor ?? AppColor.secondaryBlack,
          fontFamily: _poppinsFontFamily,
        ),
        "span": Style(fontFamily: _poppinsFontFamily),
        "div": Style(fontFamily: _poppinsFontFamily),
        "h1": Style(
          fontSize: FontSize(24.sp),
          fontWeight: FontWeight.bold,
          color: AppColor.mainBlack,
          margin: Margins.only(bottom: 8.sp, top: 16.sp),
          fontFamily: _poppinsFontFamily,
        ),
        "h2": Style(
          fontSize: FontSize(20.sp),
          fontWeight: FontWeight.bold,
          color: AppColor.mainBlack,
          margin: Margins.only(bottom: 8.sp, top: 16.sp),
          fontFamily: _poppinsFontFamily,
        ),
        "h3": Style(
          fontSize: FontSize(18.sp),
          fontWeight: FontWeight.w600,
          color: AppColor.mainBlack,
          margin: Margins.only(bottom: 8.sp, top: 16.sp),
          fontFamily: _poppinsFontFamily,
        ),
        "h4": Style(
          fontSize: FontSize(16.sp),
          fontWeight: FontWeight.w600,
          color: AppColor.mainBlack,
          margin: Margins.only(bottom: 6.sp, top: 12.sp),
          fontFamily: _poppinsFontFamily,
        ),
        "h5": Style(
          fontSize: FontSize(14.sp),
          fontWeight: FontWeight.w600,
          color: AppColor.mainBlack,
          fontFamily: _poppinsFontFamily,
        ),
        "h6": Style(
          fontSize: FontSize(13.sp),
          fontWeight: FontWeight.w600,
          color: AppColor.mainBlack,
          fontFamily: _poppinsFontFamily,
        ),
        "strong": Style(
          fontWeight: FontWeight.bold,
          color: AppColor.mainBlack,
          fontFamily: _poppinsFontFamily,
        ),
        "b": Style(
          fontWeight: FontWeight.bold,
          color: AppColor.mainBlack,
          fontFamily: _poppinsFontFamily,
        ),
        "em": Style(
          fontStyle: FontStyle.italic,
          fontFamily: _poppinsFontFamily,
        ),
        "i": Style(fontStyle: FontStyle.italic, fontFamily: _poppinsFontFamily),
        "ul": Style(
          margin: Margins.only(left: 16.sp, bottom: 12.sp),
          fontFamily: _poppinsFontFamily,
        ),
        "ol": Style(
          margin: Margins.only(left: 16.sp, bottom: 12.sp),
          fontFamily: _poppinsFontFamily,
        ),
        "li": Style(
          margin: Margins.only(bottom: 6.sp),
          fontSize: FontSize((fontSize ?? 14).sp),
          fontFamily: _poppinsFontFamily,
        ),
        "a": Style(
          color: AppColor.mainColor,
          textDecoration: TextDecoration.underline,
          fontFamily: _poppinsFontFamily,
        ),
        "blockquote": Style(
          border: Border(left: BorderSide(color: AppColor.mainColor, width: 4)),
          margin: Margins.only(left: 8.sp, bottom: 12.sp),
          padding: HtmlPaddings.only(left: 12.sp),
          backgroundColor: AppColor.offWhite,
          fontFamily: _poppinsFontFamily,
        ),
        "code": Style(
          backgroundColor: AppColor.offWhite,
          color: AppColor.mainColor,
          fontFamily: 'monospace',
          fontSize: FontSize(13.sp),
          padding: HtmlPaddings.symmetric(horizontal: 4.sp, vertical: 2.sp),
        ),
        "pre": Style(
          backgroundColor: AppColor.offWhite,
          padding: HtmlPaddings.all(12.sp),
          margin: Margins.only(bottom: 12.sp),
          fontFamily: 'monospace',
        ),
      },
    );
  }
}
