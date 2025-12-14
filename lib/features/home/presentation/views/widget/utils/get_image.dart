import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart';

/// Extract the image URL from country data
String getCountryImageUrl(CountryData country) {
  try {
    // Helper function to fix malformed URLs
    String fixUrl(String? url) {
      if (url == null || url.isEmpty) return '';
      if (url.contains('http://192.168.1.4:5000https://')) {
        return url.replaceFirst('http://192.168.1.4:5000', '');
      }
      // إصلاح مشاكل URL الأخرى إذا وجدت
      if (url.contains('http://') && url.contains('https://')) {
        return url.replaceFirst('http://', 'https://');
      }
      return url;
    }

    // 1. أولاً جرب imageCover (الخاصية الأساسية في موديل Data)
    if (country.images != null && country.images!.isNotEmpty) {
      final fixedUrl = fixUrl(country.images!.first);
      if (fixedUrl.isNotEmpty) return fixedUrl;
    }

    // 2. إذا imageCover مش شغالة، جرب images list
    if (country.images != null && country.images!.isNotEmpty) {
      for (String imageUrl in country.images!) {
        if (imageUrl.isNotEmpty) {
          final fixedUrl = fixUrl(imageUrl);
          if (fixedUrl.isNotEmpty) return fixedUrl;
        }
      }
    }

    // 3. إذا مفيش صور متاحة، رجع الصورة الافتراضية
    return 'assets/images/download.png';
  } catch (e) {
    print('Error getting country image: $e');
    return 'assets/images/download.png';
  }
}

String getTourImageUrl(tour) {
  try {
    final images = tour["images"] as List? ?? [];

    if (images.isNotEmpty) {
      // لو الصور فيها قيمة → خد أول صورة
      final firstImage = images.first;

      // ممكن يكون فيها fullUrl أو url
      if (firstImage["fullUrl"] != null &&
          firstImage["fullUrl"].toString().isNotEmpty) {
        return firstImage["fullUrl"];
      }
      if (firstImage["url"] != null &&
          firstImage["url"].toString().isNotEmpty) {
        return firstImage["url"];
      }
    }

    // لو مفيش صور → Placeholder
    return "https://via.placeholder.com/150x150.png?text=No+Image";
  } catch (e) {
    return "https://via.placeholder.com/150x150.png?text=No+Image";
  }
}
