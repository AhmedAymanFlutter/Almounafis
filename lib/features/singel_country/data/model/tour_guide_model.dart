class TourGuideResponse {
  bool? success;
  String? lang;
  TourGuideData? data;

  TourGuideResponse({this.success, this.lang, this.data});

  TourGuideResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    lang = json['lang'];
    data = json['data'] != null ? TourGuideData.fromJson(json['data']) : null;
  }
}

class TourGuideData {
  BaseEntity? city;
  BaseEntity? country;
  String? introduction;
  List<Place>? restaurants;
  List<Place>? attractions;
  List<Place>? placesToVisit;
  List<Place>? thingsToDo;

  TourGuideData({
    this.city,
    this.country,
    this.introduction,
    this.restaurants,
    this.attractions,
    this.placesToVisit,
    this.thingsToDo,
  });

  TourGuideData.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? BaseEntity.fromJson(json['city']) : null;
    country = json['country'] != null
        ? BaseEntity.fromJson(json['country'])
        : null;
    introduction = json['introduction'];
    if (json['restaurants'] != null) {
      restaurants = <Place>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(Place.fromJson(v));
      });
    }
    if (json['attractions'] != null) {
      attractions = <Place>[];
      json['attractions'].forEach((v) {
        attractions!.add(Place.fromJson(v));
      });
    }
    if (json['placesToVisit'] != null) {
      placesToVisit = <Place>[];
      json['placesToVisit'].forEach((v) {
        placesToVisit!.add(Place.fromJson(v));
      });
    }
    if (json['thingsToDo'] != null) {
      thingsToDo = <Place>[];
      json['thingsToDo'].forEach((v) {
        thingsToDo!.add(Place.fromJson(v));
      });
    }
  }
}

class BaseEntity {
  String? sId;
  String? name;

  BaseEntity({this.sId, this.name});

  BaseEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }
}

class Place {
  String? sId;
  String? name;
  String? description;
  String? type;
  num? rating;
  int? reviewsCount;
  Location? location;
  List<PlaceImage>? images;
  String? duration;
  String? bookingUrl;

  Place({
    this.sId,
    this.name,
    this.description,
    this.type,
    this.rating,
    this.reviewsCount,
    this.location,
    this.images,
    this.duration,
    this.bookingUrl,
  });

  Place.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    rating = json['rating'];
    reviewsCount = json['reviewsCount'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    if (json['images'] != null) {
      images = <PlaceImage>[];
      json['images'].forEach((v) {
        images!.add(PlaceImage.fromJson(v));
      });
    }
    duration = json['duration'];
    bookingUrl = json['bookingUrl'];
  }
}

class Location {
  double? latitude;
  double? longitude;
  String? address;
  String? googleMapsUrl;

  Location({this.latitude, this.longitude, this.address, this.googleMapsUrl});

  Location.fromJson(Map<String, dynamic> json) {
    // Handle both int/double
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
    address = json['address'];
    googleMapsUrl = json['googleMapsUrl'];
  }
}

class PlaceImage {
  String? url;
  String? alt;
  bool? isCover;

  PlaceImage({this.url, this.alt, this.isCover});

  PlaceImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    alt = json['alt'];
    isCover = json['isCover'];
  }
}
