import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/router/routes.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../features/localization/manager/localization_cubit.dart';

class CountryCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final String currency;
  final String countryId;
  final String location;

  const CountryCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.currency,
    required this.countryId,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.countryDetails,
              arguments: {
                'countryIdOrSlug': countryId,
                'countryName': location,
              },
            );
          },
          child: Stack(
            children: [
              /// 🖼️ Background image
              Image.network(
                imageUrl,
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 500,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported, size: 40),
                ),
              ),

              /// 🎨 Gradient overlay
              Container(
                height: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              /// 📝 Text content
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyle.setPoppinsTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description.isNotEmpty
                          ? description
                          : (isArabic
                              ? 'لا يوجد وصف متاح'
                              : 'No description available'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setPoppinsTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            isArabic ? 'العملة: $currency' : 'Currency: $currency',
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
