import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';

class CityGuideResponse {
  bool? success;
  String? lang;
  CityGuideData? data;

  CityGuideResponse({this.success, this.lang, this.data});

  CityGuideResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    lang = json['lang'];
    data = json['data'] != null ? CityGuideData.fromJson(json['data']) : null;
  }
}

class CityGuideData {
  GuideCity? city;
  GuideCountry? country;
  String? introduction;
  List<GuidePlace>? restaurants;
  List<GuidePlace>? attractions;
  List<GuidePlace>? placesToVisit;
  List<GuidePlace>? thingsToDo;

  CityGuideData({
    this.city,
    this.country,
    this.introduction,
    this.restaurants,
    this.attractions,
    this.placesToVisit,
    this.thingsToDo,
  });

  CityGuideData.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? GuideCity.fromJson(json['city']) : null;
    country = json['country'] != null
        ? GuideCountry.fromJson(json['country'])
        : null;
    introduction = json['introduction'];
    if (json['restaurants'] != null) {
      restaurants = <GuidePlace>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(GuidePlace.fromJson(v));
      });
    }
    if (json['attractions'] != null) {
      attractions = <GuidePlace>[];
      json['attractions'].forEach((v) {
        attractions!.add(GuidePlace.fromJson(v));
      });
    }
    if (json['placesToVisit'] != null) {
      placesToVisit = <GuidePlace>[];
      json['placesToVisit'].forEach((v) {
        placesToVisit!.add(GuidePlace.fromJson(v));
      });
    }
    if (json['thingsToDo'] != null) {
      thingsToDo = <GuidePlace>[];
      json['thingsToDo'].forEach((v) {
        thingsToDo!.add(GuidePlace.fromJson(v));
      });
    }
  }
}

class GuideCity {
  String? id;
  String? name;

  GuideCity({this.id, this.name});

  GuideCity.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }
}

class GuideCountry {
  String? id;
  String? name;

  GuideCountry({this.id, this.name});

  GuideCountry.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }
}

class GuidePlace {
  String? id;
  String? name;
  String? description;
  String? type;
  num? rating;
  int? reviewsCount;
  GuideLocation? location;
  String? bookingUrl;
  List<ImageItem>? images;
  PriceLevel? priceLevel;

  GuidePlace({
    this.id,
    this.name,
    this.description,
    this.type,
    this.rating,
    this.reviewsCount,
    this.location,
    this.bookingUrl,
    this.images,
    this.priceLevel,
  });

  GuidePlace.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    rating = json['rating'];
    reviewsCount = json['reviewsCount'];
    location = json['location'] != null
        ? GuideLocation.fromJson(json['location'])
        : null;
    bookingUrl = json['bookingUrl'];
    if (json['images'] != null) {
      images = <ImageItem>[];
      json['images'].forEach((v) {
        images!.add(ImageItem.fromJson(v));
      });
    }
    priceLevel = json['priceLevel'] != null
        ? PriceLevel.fromJson(json['priceLevel'])
        : null;
  }
}

class GuideLocation {
  num? latitude;
  num? longitude;
  String? address;
  String? googleMapsUrl;

  GuideLocation({
    this.latitude,
    this.longitude,
    this.address,
    this.googleMapsUrl,
  });

  GuideLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    googleMapsUrl = json['googleMapsUrl'];
  }
}

class PriceLevel {
  String? currency;
  num? amount;

  PriceLevel({this.currency, this.amount});

  PriceLevel.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    amount = json['amount'];
  }
}
