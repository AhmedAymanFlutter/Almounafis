import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/servicepackadge/data/model/getAllcountry.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../manager/country_cubit.dart';
import '../manager/country_state.dart';
import 'widget/details_serves.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialServices();
    _setupScrollController();
  }

  void _loadInitialServices() {
    context.read<ServicesCubit>().getServices();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreServices();
      }
    });
  }

  void _loadMoreServices() {
    context.read<ServicesCubit>().getServices(loadMore: true);
  }

  Future<void> _onRefresh() async {
    await context.read<ServicesCubit>().refreshServices();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Scaffold(
      backgroundColor: AppColor.mainWhite,
      appBar: AppBar(
        title: Text(
          isArabic ? 'الخدمات' : 'Services',
          style: AppTextStyle.setPoppinsTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.mainBlack,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isArabic ? 3.14159 : 0),
            child: SvgPicture.asset(
              'assets/icons/arrowback.svg',
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ServicesCubit, ServicesState>(
                builder: (context, state) {
                  return _buildBody(state, isArabic);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(ServicesState state, bool isArabic) {
    if (state is ServicesLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ServicesError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isArabic ? 'حدث خطأ: ${state.message}' : 'Error: ${state.message}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadInitialServices,
              child: Text(isArabic ? 'إعادة المحاولة' : 'Retry'),
            ),
          ],
        ),
      );
    } else if (state is ServicesLoaded) {
      final services = state.services.data ?? [];
      if (services.isEmpty) {
        return Center(
            child: Text(
          isArabic ? 'لا توجد خدمات' : 'No services found',
        ));
      }

      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: services.length + (state.hasReachedMax ? 0 : 1),
          itemBuilder: (context, index) {
            if (index == services.length && !state.hasReachedMax) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
              );
            }

            final service = services[index];
            return _buildServiceCard(service, isArabic);
          },
        ),
      );
    } else {
      return Center(
          child: Text(isArabic ? 'اسحب للتحديث' : 'Pull to refresh'));
    }
  }

  Widget _buildServiceCard(Data service, bool isArabic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFFFFF),
            Colors.blue.withOpacity(0.65),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D1A8EEA),
            offset: Offset(7, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic
                        ? (service.nameAr ?? service.name ?? 'الخدمة')
                        : (service.name ?? 'Service'),
                    style: AppTextStyle.setPoppinsTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF102E4F),
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isArabic
                        ? (service.summaryAr ??
                            service.summary ??
                            'وصف الخدمة')
                        : (service.summary ?? 'Service description'),
                    style: AppTextStyle.setPoppinsTextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF4A6785),
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => showServiceDetails(context, service),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.mainWhite,
                      foregroundColor: AppColor.mainBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                      children: [
                        Text(
                          isArabic ? 'متابعة' : 'Continue',
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColor.mainBlack,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(isArabic ? 3.14159 : 0),
                          child: SvgPicture.asset(
                            'assets/icons/forrowd serves.svg',
                            width: 26,
                            height: 17,
                            fit: BoxFit.scaleDown,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: service.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        width: 80,
                        height: 80,
                        imageUrl: service.image!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.white54,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.white54,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
