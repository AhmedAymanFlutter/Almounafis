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
    data = json['data'] != null && json['data']['city'] != null
        ? CityDetails.fromJson(json['data']['city'])
        : null;
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
  CitySeo? seo;
  Country? country;
  List<RelatedCity>? relatedCities;
  List<ImageItem>? images;
  List<pkg.Data>? packages;
  List<tour.CityTourData>? cityTours;

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

    // Parse SEO data
    seo = json['seo'] != null ? CitySeo.fromJson(json['seo']) : null;

    // Parse country
    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;

    // Images
    if (json['images'] != null && json['images'] is List) {
      images = [];
      json['images'].forEach((v) {
        images!.add(ImageItem.fromJson(v));
      });
    }

    // Related Cities
    if (json['relatedCities'] != null && json['relatedCities'] is List) {
      relatedCities = [];
      json['relatedCities'].forEach((v) {
        relatedCities!.add(RelatedCity.fromJson(v));
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

// SEO Data Model
class CitySeo {
  String? metaTitle;
  String? metaTitleAr;
  String? metaDescription;
  String? metaDescriptionAr;
  String? slugUrl;

  CitySeo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
    metaTitleAr = json['metaTitleAr'];
    metaDescription = json['metaDescription'];
    metaDescriptionAr = json['metaDescriptionAr'];
    slugUrl = json['slugUrl'];
  }
}

// Related City Model
class RelatedCity {
  String? id;
  String? name;
  String? nameAr;
  String? slug;
  CoverImage? coverImage;

  RelatedCity.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    slug = json['slug'];
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
  }
}

class CoverImage {
  String? url;
  String? alt;
  String? altAr;

  CoverImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    alt = json['alt'];
    altAr = json['altAr'];
  }
}
