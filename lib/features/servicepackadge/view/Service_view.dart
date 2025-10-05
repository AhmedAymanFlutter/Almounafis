import 'package:almonafs_flutter/features/servicepackadge/data/model/getAllcountry.dart'; // Add hide Icon here
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../../home/presentation/widgets/search_bar.dart';
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
    return Scaffold(
      
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          CustomSearchBar(),
          Expanded(
            child: BlocBuilder<ServicesCubit, ServicesState>(
              builder: (context, state) {
                return _buildBody(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ServicesState state) {
    if (state is ServicesLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ServicesError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.message}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadInitialServices,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else if (state is ServicesLoaded) {
      final services = state.services.data ?? [];
      if (services.isEmpty) {
        return const Center(child: Text('No services found'));
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
            return _buildServiceCard(service);
          },
        ),
      );
    } else {
      return const Center(child: Text('Pull to refresh'));
    }
  }

 Widget _buildServiceCard(Data service) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFFFFF),
          Colors.blue.withOpacity(0.65),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color(0x4D1A8EEA), 
          offset: const Offset(7, 2), 
          blurRadius: 10, 
          spreadRadius: 0, 
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name ?? 'Service',
                  style: AppTextStyle.setPoppinsTextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.w500, 
                    color: Color(0xFF102E4F)
                  )
                ),
                const SizedBox(height: 8),
                Text(
                  service.summary ?? 'Service description',
                  style: AppTextStyle.setPoppinsTextStyle(
                    fontSize: 8, 
                    fontWeight: FontWeight.w300, 
                    color: Color(0xFF4A6785)
                  ),
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
                    children: [
                      Text(
                        'Continue',
                        style: AppTextStyle.setPoppinsTextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w400, 
                          color: AppColor.mainBlack
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/icons/forrowd serves.svg',
                        width: 26,
                        height: 17,
                        fit: BoxFit.scaleDown,
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
                    child: SvgPicture.network(
                      service.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image, 
                          size: 40, 
                          color: Colors.white54
                        );
                      },
                    ),
                  )
                : Icon(
                    Icons.image_not_supported, 
                    size: 40, 
                    color: Colors.white54
                  ),
          ),
        ],
      ),
    ),
  );
}
}
