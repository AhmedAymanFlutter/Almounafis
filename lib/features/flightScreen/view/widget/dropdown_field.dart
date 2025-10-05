import 'package:flutter/material.dart';
import '../../data/model/filter_model.dart';

class DropdownField extends StatefulWidget {
  final String label;
  final FlightFilter? currentFilter;
  final Function(FlightFilter)? onFilterChanged;

  const DropdownField({
    Key? key,
    required this.label,
    this.currentFilter,
    this.onFilterChanged,
  }) : super(key: key);

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? _selectedValue;

  List<String> get _options {
    switch (widget.label) {
      case 'Passengers':
        return ['Any', '1 Passenger', '2 Passengers', '3 Passengers', '4+ Passengers'];
      case 'Airlines':
        return ['Any', 'EgyptAir', 'Emirates', 'Qatar Airways', 'Turkish Airlines'];
      case 'Class':
        return ['Any', 'Economy', 'Business', 'First Class'];
      default:
        return ['Any', 'Option 1', 'Option 2', 'Option 3'];
    }
  }

  @override
  void initState() {
    super.initState();
    _updateSelectedValueFromFilter();
  }

  @override
  void didUpdateWidget(covariant DropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedValueFromFilter();
  }

  void _updateSelectedValueFromFilter() {
    if (widget.currentFilter != null) {
      switch (widget.label) {
        case 'Passengers':
          _selectedValue = widget.currentFilter!.passengerCount;
          break;
        case 'Airlines':
          _selectedValue = widget.currentFilter!.airline;
          break;
        case 'Class':
          _selectedValue = widget.currentFilter!.travelClass;
          break;
      }
    }
  }

  void _onValueChanged(String? newValue) {
    setState(() {
      _selectedValue = newValue;
    });

    if (widget.onFilterChanged != null && newValue != null && newValue != 'Any') {
      final updatedFilter = widget.currentFilter?.copyWith() ?? FlightFilter();
      
      switch (widget.label) {
        case 'Passengers':
          widget.onFilterChanged!(updatedFilter.copyWith(passengerCount: newValue));
          break;
        case 'Airlines':
          widget.onFilterChanged!(updatedFilter.copyWith(airline: newValue));
          break;
        case 'Class':
          widget.onFilterChanged!(updatedFilter.copyWith(travelClass: newValue));
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedValue,
          isExpanded: true,
          isDense: true,
          hint: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          items: _options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: value == 'Any' ? Colors.grey : Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: _onValueChanged,
          icon: Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.grey[700]),
        ),
      ),
    );
  }
}