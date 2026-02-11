import 'package:almonafs_flutter/features/singel_country/data/model/country_details_model.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryDetailsHeader extends StatefulWidget {
  final CountryDetailsData country;
  final bool isArabic;

  const CountryDetailsHeader({
    super.key,
    required this.country,
    required this.isArabic,
  });

  @override
  State<CountryDetailsHeader> createState() => _CountryDetailsHeaderState();
}

class _CountryDetailsHeaderState extends State<CountryDetailsHeader> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Collect all available images (gallery + cover)
    // Collect all available images (gallery + cover)
    final List<String> imageUrls = [];
    final Set<String> uniqueUrls = {};

    void addImage(String? url) {
      if (url != null && url.isNotEmpty && !uniqueUrls.contains(url)) {
        uniqueUrls.add(url);
        imageUrls.add(url);
      }
    }

    // Add cover image first (as priority)
    addImage(widget.country.images?.coverImage?.url);

    // Add gallery images
    if (widget.country.images?.gallery != null) {
      for (var img in widget.country.images!.gallery!) {
        addImage(img.url);
      }
    }

    return SliverAppBar(
      expandedHeight: 450.h,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white, // Solid color for pinned state
      iconTheme: const IconThemeData(color: Colors.black),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
        ),
        child: const BackButton(color: Colors.white),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image Carousel
              if (imageUrls.isNotEmpty)
                PageView.builder(
                  itemCount: imageUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    );
                  },
                )
              else
                Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "No Images Available",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Gradient Overlay
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black12,
                      Colors.transparent,
                      Colors.black54,
                      Colors.black87,
                    ],
                    stops: [0.0, 0.4, 0.8, 1.0],
                  ),
                ),
              ),

              // Content Overlay
              Positioned(
                bottom: 20.h,
                left: 20.w,
                right: 20.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Country Name & Continent
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.isArabic
                                    ? (widget.country.nameAr ??
                                          widget.country.name ??
                                          "")
                                    : (widget.country.name ?? ""),
                                style: AppTextStyle.setPoppinsWhite(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (widget.country.continent != null)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.public,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: Text(
                                        widget.country.continent!,
                                        style: AppTextStyle.setPoppinsWhite(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),

                        // Weather (Placeholder if not available in model)
                        // Assuming we don't have real weather in Country model yet,
                        // keeping it simple or removed. If you want to keep the dummy "25", uncomment below:
                        /*
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.wb_sunny, size: 20.sp, color: Colors.orange),
                              SizedBox(width: 4.w),
                              Text(
                                '25°',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        */
                      ],
                    ),

                    // Page Indicator
                    if (imageUrls.length > 1) ...[
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          imageUrls.length,
                          (index) => Container(
                            width: 8.w,
                            height: 8.w,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
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
