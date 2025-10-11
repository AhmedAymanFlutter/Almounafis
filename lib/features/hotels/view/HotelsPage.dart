import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../flightScreen/view/widget/filter_chip.dart';
import '../../home/presentation/widgets/search_bar.dart';
import '../../localization/manager/localization_cubit.dart';
import '../data/repo/Hotel_repo_tour.dart';
import '../manager/hotel_cubit.dart';
import '../manager/hotel_state.dart';
import 'widget/hotel_widget.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelCubit(HotelRepository())..getAllHotels(),
      child: const _AllHotelsScreenContent(),
    );
  }
}

class _AllHotelsScreenContent extends StatefulWidget {
  const _AllHotelsScreenContent();

  @override
  State<_AllHotelsScreenContent> createState() => __AllHotelsScreenContentState();
}

class __AllHotelsScreenContentState extends State<_AllHotelsScreenContent> {
  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Scaffold(
      backgroundColor: AppColor.mainWhite,
      body: Column(
        children: [
          // ✅ Search Bar
          const CustomSearchBar(),
          const SizedBox(height: 16),

          // ✅ Filter Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  isArabic ? 'تصفية حسب' : 'Filters by',
                  style: AppTextStyle.setPoppinsSecondaryBlack(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FilterChipWidget(
                  label: isArabic ? 'الخدمات' : 'Facilities',
                  onTap: () {},
                ),
                FilterChipWidget(
                  label: isArabic ? 'التصنيف' : 'Star Rating',
                  onTap: () {},
                ),
                FilterChipWidget(
                  label: isArabic ? 'النطاق السعري' : 'Range',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ✅ Hotels List
          Expanded(
            child: BlocBuilder<HotelCubit, HotelState>(
              builder: (context, state) {
                return buildContent(context, state);
              },
            ),
          ),
        ],
      ),
    );
  }
}
