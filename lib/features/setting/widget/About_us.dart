import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/auth/presentation/widgets/account_info_header.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e2e4f),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AccountInfoHeader(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'About Us',
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Al Monafes Travel & Tourism is a leading travel company dedicated to delivering exceptional tourism experiences that combine quality, affordability, and unforgettable memories. Since 2015, we have proudly served more than 50,000 satisfied customers, offering trips to over 100 global destinations and building a reputation for excellence in the travel industry. With 9 years of experience, we understand what makes a journey truly special and we strive to create tailored packages that cater to every traveler’s needs and preferences.\n\n'
                      'We believe that travel is more than just moving from one place to another — it’s a journey of self-discovery, cultural exploration, and creating lifelong memories. Our passionate and professional team works around the clock to ensure every detail of your trip is seamless and stress-free. Whether you’re seeking budget-friendly adventures or luxury getaways, Al Monafes offers a diverse range of packages, guided tours, and customer support to make your travel dreams a reality. Join thousands of happy travelers who chose Al Monafes and let us plan the trip of a lifetime for you.',
                      style: AppTextStyle.setPoppinsSecondlightGrey(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                      softWrap: true,
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
