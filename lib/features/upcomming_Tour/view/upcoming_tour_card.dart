import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UpcomingTourCard extends StatelessWidget {
  final String title, subtitle, imageUrl, tag;
  

  const UpcomingTourCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.tag,
    
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageUrl.isNotEmpty;
    return Container(
      width: 370,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 80, 
            height: double.infinity,
            padding: const EdgeInsets.only(
              top: 3,
              left: 3,
              right: 3,
              bottom: 3,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // border-radius: 20px
              child: SizedBox(
                width: 74, // exact width
                height: 70, // exact height
                child: hasImage
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 74,
                        height: 70,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 74,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return _buildPlaceholder();
                        }, 
                      )
                    : _buildPlaceholder(),
              ),
            ),
          ),
          
          // Content Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tag.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Subtitle
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),               
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔄 Placeholder when image is not available
  Widget _buildPlaceholder() {
    return Container(
      width: 74,
      height: 81,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, color: Colors.grey, size: 20),
          SizedBox(height: 4),
          Text(
            'No Image',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}