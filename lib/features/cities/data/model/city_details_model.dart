import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
// Import other necessary models if they are in different files, or redefine if they are slightly different.
// For simplicity and avoiding circular deps or complex imports, I might redefine some or use the existing ones if they match perfectly.
// The JSON shows structure similar to City but with more fields like 'packages' and 'cityTours'.

import 'package:almonafs_flutter/features/packadge/data/model/package_model.dart'
    as pkg;
import 'package:almonafs_flutter/features/upcomming_Tour/data/model/city_tour.dart'
    as tour;

class CityDetailsResponse {
  bool? success;
  String? message;
  CityDetails? data;

  CityDetailsResponse({this.success, this.message, this.data});

  CityDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CityDetails.fromJson(json['data']) : null;
  }
}

class CityDetails {
  String? id;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  String? descriptionFlutter;
  String? descriptionArFlutter;
  Coordinates? coordinates;
  Weather? weather;
  BestTimeToVisit? bestTimeToVisit;
  SeoPage?
  seo; // Note: In CityResponse it was SeoPage, in JSON it is 'seo' with meta tags. The provided JSON has 'seo' object which looks like 'Seo' class in package_model, but let's check.
  // In the provided JSON: "seo": { "metaTitle": ... } -> This matches 'Seo' class in package_model.dart or similar.
  // In existing cities_model.dart, 'SeoPage' has 'hero' and 'header'.
  // The provided JSON has "seo" (meta) AND "seoPage" is NOT in the top level data of single city? Wait, let's check JSON again.
  // JSON has 'seo' inside 'data'. It does NOT show 'seoPage' (hero/header) in the 'data' of the single city JSON provided by user.
  // However, the user might want to show hero section?
  // The provided JSON has 'images', 'packages', 'cityTours'.

  List<ImageItem>? images;
  List<pkg.Data>? packages; // reusing Package Data model
  List<tour.CityTourData>? cityTours; // reusing CityTourData model

  CityDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    descriptionFlutter = json['descriptionFlutter'];
    descriptionArFlutter = json['descriptionArFlutter'];

    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
    weather = json['weather'] != null
        ? Weather.fromJson(json['weather'])
        : null;
    bestTimeToVisit = json['bestTimeToVisit'] != null
        ? BestTimeToVisit.fromJson(json['bestTimeToVisit'])
        : null;

    // Images
    if (json['images'] != null && json['images'] is List) {
      images = [];
      json['images'].forEach((v) {
        images!.add(ImageItem.fromJson(v));
      });
    }

    // Packages
    if (json['packages'] != null && json['packages'] is List) {
      packages = [];
      json['packages'].forEach((v) {
        packages!.add(pkg.Data.fromJson(v));
      });
    }

    // City Tours
    if (json['cityTours'] != null && json['cityTours'] is List) {
      cityTours = [];
      json['cityTours'].forEach((v) {
        cityTours!.add(tour.CityTourData.fromJson(v));
      });
    }
  }
}
