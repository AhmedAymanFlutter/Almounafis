import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../localization/manager/localization_cubit.dart';

class DateField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onDateSelected; // optional callback for API format

  const DateField({
    super.key,
    required this.label,
    required this.controller,
    this.onDateSelected,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  Future<void> _selectDate(BuildContext context, bool isArabic) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      
    );

    if (picked != null) {
      // 1️⃣ For UI (localized display)
      final displayDate = DateFormat('dd-MM-yyyy').format(picked);

      // 2️⃣ For backend (ISO format)
      final apiDate = DateFormat('yyyy-MM-dd').format(picked);

      setState(() {
        widget.controller.text = displayDate;
      });

      // 3️⃣ Trigger callback if parent needs the backend format
      widget.onDateSelected?.call(apiDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return GestureDetector(
          onTap: () => _selectDate(context, isArabic),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    widget.label,
                    style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_month, size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      widget.controller.text.isEmpty
                          ? (isArabic ? "اختر التاريخ" : "Select date")
                          : widget.controller.text,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
