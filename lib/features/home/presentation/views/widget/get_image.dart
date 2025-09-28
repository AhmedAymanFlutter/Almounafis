/// Extract the image URL from country data
  String getCountryImageUrl(country) {
    try {
      // Helper function to fix malformed URLs
      String fixUrl(String? url) {
        if (url == null) return '';
        if (url.contains('http://192.168.1.4:5000https://')) {
          return url.replaceFirst('http://192.168.1.4:5000', '');
        }
        return url;
      }

      // First try to get the cover image URL
      if (country.images?.coverImage?.fullUrl != null) {
        final fixedUrl = fixUrl(country.images.coverImage.fullUrl);
        return fixedUrl;
      }
      
      // If cover image is not available, try the regular URL
      if (country.images?.coverImage?.url != null) {
        final fixedUrl = fixUrl(country.images.coverImage.url);
        return fixedUrl;
      }
      
      // If no cover image, try to get the first gallery image
      if (country.images?.gallery != null && country.images.gallery.isNotEmpty) {
        final firstGalleryImage = country.images.gallery.first;
        if (firstGalleryImage.fullUrl != null) {
          final fixedUrl = fixUrl(firstGalleryImage.fullUrl);
          return fixedUrl;
        }
        if (firstGalleryImage.url != null) {
          final fixedUrl = fixUrl(firstGalleryImage.url);
          return fixedUrl;
        }
      }
      
      // If no image found, return default image
      return 'assets/images/download.png';
      
    } catch (e) {
      return 'assets/images/download.png';
    }
  }
