import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../localization/manager/localization_cubit.dart';
import '../../manager/AirLine_cubit.dart';
import '../../manager/Airine_state.dart';

class DropdownField extends StatefulWidget {
  final String label;
  final Function(String?)? onChanged; // ✅ parameter واحد بس

  const DropdownField({
    super.key,
    required this.label,
    this.onChanged,
  });

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.label == 'Airlines' || widget.label == 'شركات الطيران') {
      context.read<FilterCubit>().loadFilterOptions('Airlines', false);
    }
  }

  void _onValueChanged(String? newValue) {
    setState(() {
      _selectedValue = newValue;
    });

    // ✅ استدعي الـ callback مباشرة
    if (widget.onChanged != null) {
      widget.onChanged!(newValue);
    }
  }

  List<String> _getStaticOptions(bool isArabic) {
    switch (widget.label) {
      case 'Passengers':
      case 'الركاب':
        return isArabic
            ? ['أي', 'راكب واحد', 'راكبان', '3 ركاب', '4+ ركاب']
            : ['Any', '1 Passenger', '2 Passengers', '3 Passengers', '4+ Passengers'];
      case 'Class':
      case 'الدرجة':
        return isArabic
            ? ['أي', 'اقتصادي', 'اقتصادي ممتاز', 'رجال الأعمال ', ' الأولى']
            : ['Any', 'economy', 'premium-economy', 'business', 'first'];
      default:
        return isArabic
            ? ['أي', 'خيار 1', 'خيار 2', 'خيار 3']
            : ['Any', 'Option 1', 'Option 2', 'Option 3'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: (widget.label == 'Airlines' || widget.label == 'شركات الطيران')
              ? _buildAirlineDropdown(context, isArabic)
              : _buildStaticDropdown(isArabic),
        );
      },
    );
  }

  Widget _buildStaticDropdown(bool isArabic) {
    final options = _getStaticOptions(isArabic);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: options.contains(_selectedValue) ? _selectedValue : null,
          isExpanded: true,
          isDense: true,
          hint: Text(
            isArabic ? _translateLabel(widget.label) : widget.label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: value == 'Any' || value == 'أي'
                      ? Colors.grey
                      : Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: _onValueChanged,
          icon: Icon(Icons.keyboard_arrow_down,
              size: 14, color: Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _buildAirlineDropdown(BuildContext context, bool isArabic) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state is FilterLoading) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const SizedBox(
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        } else if (state is AirlinesLoaded) {
          final airlines = state.airlines;

          // ✅ Build Map of airlineId → displayName
          final Map<String, String> airlineOptions = {
            'Any': isArabic ? 'أي' : 'Any',
            for (var a in airlines)
              (a.id ?? a.sId ?? ''): // ✅ استخدم id أو sId كـ value
                  isArabic ? (a.nameAr ?? a.name ?? '') : (a.name ?? ''),
          };

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: airlineOptions.keys.contains(_selectedValue)
                    ? _selectedValue
                    : null,
                isExpanded: true,
                isDense: true,
                hint: Text(
                  isArabic ? 'شركات الطيران' : 'Airlines',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                items: airlineOptions.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key, // ✅ الـ value هو الـ id
                    child: Text(
                      entry.value, // ✅ الـ display name
                      style: TextStyle(
                        fontSize: 12,
                        color: entry.key == 'Any'
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: _onValueChanged,
                icon: Icon(Icons.keyboard_arrow_down,
                    size: 14, color: Colors.grey[700]),
              ),
            ),
          );
        } else if (state is FilterError) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.red[300]!),
            ),
            child: Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red[700], fontSize: 12),
              ),
            ),
          );
        }

        return _buildStaticDropdown(isArabic);
      },
    );
  }

  String _translateLabel(String label) {
    switch (label) {
      case 'Passengers':
        return 'الركاب';
      case 'Airlines':
        return 'شركات الطيران';
      case 'Class':
        return 'الدرجة';
      default:
        return label;
    }
  }
}