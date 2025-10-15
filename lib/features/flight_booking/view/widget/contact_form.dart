import 'package:flutter/material.dart';

class ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController whatsappController;
  final String selectedCountryCode;
  final ValueChanged<String> onCountryCodeChanged;
  final bool isLoading;

  const ContactForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.phoneController,
    required this.whatsappController,
    required this.selectedCountryCode,
    required this.onCountryCodeChanged,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'معلومات الاتصال',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        // ===== البريد =====
        TextFormField(
          controller: emailController,
          enabled: !isLoading,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'البريد الإلكتروني',
            hintText: 'example@email.com',
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) return 'البريد الإلكتروني مطلوب';
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
              return 'البريد الإلكتروني غير صحيح';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // ===== الهاتف =====
        Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                value: selectedCountryCode,
                decoration: InputDecoration(
                  labelText: 'رمز الدولة',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.flag),
                ),
                items: const [
                  DropdownMenuItem(value: '+20', child: Text('🇪🇬 +20')),
                  DropdownMenuItem(value: '+966', child: Text('🇸🇦 +966')),
                  DropdownMenuItem(value: '+971', child: Text('🇦🇪 +971')),
                  DropdownMenuItem(value: '+216', child: Text('🇹🇳 +216')),
                  DropdownMenuItem(value: '+212', child: Text('🇲🇦 +212')),
                ],
                onChanged: (value) => onCountryCodeChanged(value!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: phoneController,
                enabled: !isLoading,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                  hintText: '1001234567',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'مطلوب';
                  if (value!.length < 9) return 'غير صحيح';
                  return null;
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // ===== واتساب =====
        TextFormField(
          controller: whatsappController,
          enabled: !isLoading,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'رقم واتساب (اختياري)',
            prefixIcon: const Icon(Icons.chat_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
