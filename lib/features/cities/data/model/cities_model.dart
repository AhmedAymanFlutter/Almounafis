class CityResponse {
  bool? success;
  String? message;
  Data? data;
  SeoPage? seoPage;

  CityResponse({this.success, this.message, this.data, this.seoPage});

  CityResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    seoPage = json['seoPage'] != null
        ? SeoPage.fromJson(json['seoPage'])
        : null;
  }
}

class Data {
  List<City>? cities;
  Pagination? pagination;

  Data({this.cities, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <City>[];
      json['cities'].forEach((v) {
        cities!.add(City.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class City {
  String? id;
  String? slug;
  String? name;
  String? nameAr;
  String? description; // HTML content
  String? descriptionFlutter; // Clean content
  String? descriptionArFlutter; // Clean content AR
  Coordinates? coordinates;
  Weather? weather;
  BestTimeToVisit? bestTimeToVisit;
  Country? country;
  ImagesObject? imagesObject;

  City({
    this.id,
    this.slug,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionFlutter,
    this.descriptionArFlutter,
    this.coordinates,
    this.weather,
    this.bestTimeToVisit,
    this.country,
    this.imagesObject,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['_id']; // MongoDB uses _id
    // Slug is nested in seo.slugUrl
    slug = json['seo'] != null ? json['seo']['slugUrl'] : null;
    name = json['name'];
    nameAr = json['nameAr'];
    description = json['description'];
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
    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;
    imagesObject = json['imagesObject'] != null
        ? ImagesObject.fromJson(json['imagesObject'])
        : null;
  }
}

class Coordinates {
  double? latitude;
  double? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
  }
}

class Weather {
  double? currentTemp;
  String? condition;
  int? humidity;
  double? windSpeed;

  Weather({this.currentTemp, this.condition, this.humidity, this.windSpeed});

  Weather.fromJson(Map<String, dynamic> json) {
    currentTemp = (json['currentTemp'] as num?)?.toDouble();
    condition = json['condition'];
    humidity = json['humidity'];
    windSpeed = (json['windSpeed'] as num?)?.toDouble();
  }
}

class BestTimeToVisit {
  List<String>? months;
  String? description;
  String? descriptionAr;

  BestTimeToVisit({this.months, this.description, this.descriptionAr});

  BestTimeToVisit.fromJson(Map<String, dynamic> json) {
    months = json['months'] != null ? List<String>.from(json['months']) : [];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
  }
}

class Country {
  String? name;
  String? nameAr;
  String? code;

  Country({this.name, this.nameAr, this.code});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameAr = json['nameAr'];
    code = json['code'];
  }
}

class ImagesObject {
  ImageItem? coverImage;
  List<ImageItem>? gallery;

  ImagesObject({this.coverImage, this.gallery});

  ImagesObject.fromJson(Map<String, dynamic> json) {
    coverImage = json['coverImage'] != null
        ? ImageItem.fromJson(json['coverImage'])
        : null;
    if (json['gallery'] != null) {
      gallery = <ImageItem>[];
      json['gallery'].forEach((v) {
        gallery!.add(ImageItem.fromJson(v));
      });
    }
  }
}

class ImageItem {
  String? url;
  String? thumbnailUrl;
  String? alt;
  String? altAr;

  ImageItem({this.url, this.thumbnailUrl, this.alt, this.altAr});

  ImageItem.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
    alt = json['alt'];
    altAr = json['altAr'];
  }
}

class Pagination {
  int? current;
  int? pages;
  int? total;

  Pagination({this.current, this.pages, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    pages = json['pages'];
    total = json['total'];
  }
}

class SeoPage {
  HeroSection? hero;
  HeaderSection? header;

  SeoPage({this.hero, this.header});

  SeoPage.fromJson(Map<String, dynamic> json) {
    hero = json['hero'] != null ? HeroSection.fromJson(json['hero']) : null;
    header = json['header'] != null
        ? HeaderSection.fromJson(json['header'])
        : null;
  }
}

class HeroSection {
  String? heroTitle;
  String? heroDescription;
  String? heroButtonText;

  HeroSection({this.heroTitle, this.heroDescription, this.heroButtonText});

  HeroSection.fromJson(Map<String, dynamic> json) {
    heroTitle = json['hero_Title'];
    heroDescription = json['hero_Description'];
    heroButtonText = json['hero_ButtonText'];
  }
}

class HeaderSection {
  String? headerTitle;
  String? headerDescription;

  HeaderSection({this.headerTitle, this.headerDescription});

  HeaderSection.fromJson(Map<String, dynamic> json) {
    headerTitle = json['header_Title'];
    headerDescription = json['header_Description'];
  }
}
