import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../localization/manager/localization_cubit.dart';

class LocationField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;

  const LocationField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
  });

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(widget.icon, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    isArabic
                        ? _translateLabel(widget.label)
                        : widget.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: _controller,
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  decoration: InputDecoration(
                    hintText: isArabic
                        ? _translateHint(widget.hint)
                        : widget.hint,
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[400],
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔸 ترجمة النصوص للعربية
  String _translateLabel(String label) {
    switch (label.toLowerCase()) {
      case 'from':
        return 'من';
      case 'to':
        return 'إلى';
      case 'location':
        return 'الموقع';
      default:
        return label;
    }
  }

  String _translateHint(String hint) {
    switch (hint.toLowerCase()) {
      case 'enter departure city':
        return 'أدخل مدينة المغادرة';
      case 'enter destination city':
        return 'أدخل مدينة الوصول';
      case 'search location':
        return 'ابحث عن الموقع';
      default:
        return hint;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
