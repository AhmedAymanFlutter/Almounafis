import 'package:flutter/material.dart';

class SimpleLocationCard extends StatelessWidget {
  final bool isArabic;
  final TextEditingController fromController;
  final TextEditingController toController;

  const SimpleLocationCard({
    super.key,
    required this.isArabic,
    required this.fromController,
    required this.toController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'بلد المغادرة والعودة' : 'Departure and Return Country',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: fromController,
                    label: isArabic ? 'من' : 'From',
                    hint: isArabic
                        ? 'أدخل مدينة المغادرة'
                        : 'Enter Departure City',
                    icon: Icons.flight_takeoff_outlined,
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: _buildTextField(
                    controller: toController,
                    label: isArabic ? 'إلى' : 'To',
                    hint: isArabic
                        ? 'أدخل مدينة الوصول'
                        : 'Enter Destination City',
                    icon: Icons.flight_land_outlined,
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: 50.38 * 3.1415926535 / 180,
                  child: Image.asset(
                    'assets/images/airplane.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFBBBBBB),
              ),
              prefixIcon: Icon(icon, color: const Color(0xFF0077B6), size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
