import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class SafeSvgNetwork extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const SafeSvgNetwork({
    super.key,
    required this.url,
    this.width = 80,
    this.height = 80,
  });

  Future<String> _fetchAndCleanSvg() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String svgString = response.body;

      // 🧹 امسح أي تاغ <style> ... </style>
      svgString = svgString.replaceAll(RegExp(r'<style[^>]*>[\s\S]*?<\/style>'), '');

      // لو في مسافات أو تاغات فاضية
      svgString = svgString.trim();

      return svgString;
    } else {
      throw Exception('Failed to load SVG');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchAndCleanSvg(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Icon(Icons.broken_image, color: Colors.red, size: 40);
        } else {
          return SvgPicture.string(
            snapshot.data!,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }
}
