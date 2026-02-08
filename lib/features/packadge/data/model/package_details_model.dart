class PackageDetailsResponse {
  bool? success;
  String? message;
  PackageDetailsData? data;

  PackageDetailsResponse({this.success, this.message, this.data});

  PackageDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? PackageDetailsData.fromJson(json['data'])
        : null;
  }
}

class PackageDetailsData {
  String? sId;
  String? title;
  String? titleAr;
  String? description;
  String? descriptionAr;
  String? descriptionFlutter;
  String? descriptionArFlutter;
  PackageDuration? duration;
  Pricing? pricing;
  Availability? availability;
  Requirements? requirements;
  Seo? seo;
  PackageType? packageType;
  List<Destination>? destinations;
  List<String>? includes;
  List<String>? excludes;
  List<Itinerary>? itinerary;
  Images? images;
  double? averageRating;
  int? totalReviews;
  bool? isActive;
  bool? isFeatured;
  bool? isPopular;
  List<String>? tags;
  List<String>? tagsAr;
  CreatedBy? createdBy;
  String? createdAt;
  String? updatedAt;

  PackageDetailsData({
    this.sId,
    this.title,
    this.titleAr,
    this.description,
    this.descriptionAr,
    this.descriptionFlutter,
    this.descriptionArFlutter,
    this.duration,
    this.pricing,
    this.availability,
    this.requirements,
    this.seo,
    this.packageType,
    this.destinations,
    this.includes,
    this.excludes,
    this.itinerary,
    this.images,
    this.averageRating,
    this.totalReviews,
    this.isActive,
    this.isFeatured,
    this.isPopular,
    this.tags,
    this.tagsAr,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  PackageDetailsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    titleAr = json['titleAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    descriptionFlutter = json['descriptionFlutter'];
    descriptionArFlutter = json['descriptionArFlutter'];
    duration = json['duration'] != null
        ? PackageDuration.fromJson(json['duration'])
        : null;
    pricing = json['pricing'] != null
        ? Pricing.fromJson(json['pricing'])
        : null;
    availability = json['availability'] != null
        ? Availability.fromJson(json['availability'])
        : null;
    requirements = json['requirements'] != null
        ? Requirements.fromJson(json['requirements'])
        : null;
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    packageType = json['packageType'] != null
        ? PackageType.fromJson(json['packageType'])
        : null;

    if (json['destinations'] != null) {
      destinations = <Destination>[];
      json['destinations'].forEach((v) {
        destinations!.add(Destination.fromJson(v));
      });
    }

    includes = json['includes'] != null
        ? List<String>.from(json['includes'])
        : null;
    excludes = json['excludes'] != null
        ? List<String>.from(json['excludes'])
        : null;

    if (json['itinerary'] != null) {
      itinerary = <Itinerary>[];
      json['itinerary'].forEach((v) {
        itinerary!.add(Itinerary.fromJson(v));
      });
    }

    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    averageRating = (json['averageRating'] as num?)?.toDouble();
    totalReviews = json['totalReviews'];
    isActive = json['isActive'];
    isFeatured = json['isFeatured'];
    isPopular = json['isPopular'];
    tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
    tagsAr = json['tagsAr'] != null ? List<String>.from(json['tagsAr']) : null;
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class PackageDuration {
  int? days;
  int? nights;

  PackageDuration({this.days, this.nights});

  PackageDuration.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    nights = json['nights'];
  }
}

class Pricing {
  String? currency;
  num? price; // Using num for price to accommodate int or double
  List<String>? priceIncludes;
  List<String>? priceIncludesAr;
  List<String>? priceExcludes;
  List<String>? priceExcludesAr;
  num? discountPercentage;

  Pricing({
    this.currency,
    this.price,
    this.priceIncludes,
    this.priceIncludesAr,
    this.priceExcludes,
    this.priceExcludesAr,
    this.discountPercentage,
  });

  Pricing.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    price = json['price'];
    priceIncludes = json['priceIncludes'] != null
        ? List<String>.from(json['priceIncludes'])
        : null;
    priceIncludesAr = json['priceIncludesAr'] != null
        ? List<String>.from(json['priceIncludesAr'])
        : null;
    priceExcludes = json['priceExcludes'] != null
        ? List<String>.from(json['priceExcludes'])
        : null;
    priceExcludesAr = json['priceExcludesAr'] != null
        ? List<String>.from(json['priceExcludesAr'])
        : null;
    discountPercentage = json['discountPercentage'];
  }
}

class Availability {
  int? minGroupSize;
  List<String>? availableDates;

  Availability({this.minGroupSize, this.availableDates});

  Availability.fromJson(Map<String, dynamic> json) {
    minGroupSize = json['minGroupSize'];
    availableDates = json['availableDates'] != null
        ? List<String>.from(json['availableDates'])
        : null;
  }
}

class Requirements {
  List<String>? documents;
  List<String>? documentsAr;
  List<String>? restrictions;
  List<String>? restrictionsAr;

  Requirements({
    this.documents,
    this.documentsAr,
    this.restrictions,
    this.restrictionsAr,
  });

  Requirements.fromJson(Map<String, dynamic> json) {
    documents = json['documents'] != null
        ? List<String>.from(json['documents'])
        : null;
    documentsAr = json['documentsAr'] != null
        ? List<String>.from(json['documentsAr'])
        : null;
    restrictions = json['restrictions'] != null
        ? List<String>.from(json['restrictions'])
        : null;
    restrictionsAr = json['restrictionsAr'] != null
        ? List<String>.from(json['restrictionsAr'])
        : null;
  }
}

class Seo {
  String? metaTitle;
  String? metaTitleAr;
  String? metaDescription;
  String? metaDescriptionAr;
  List<String>? keywords;
  List<String>? keywordsAr;
  String? slugUrl;
  String? priority;
  String? changeFrequency;
  bool? noIndex;
  bool? noFollow;
  bool? noArchive;
  bool? noSnippet;

  Seo({
    this.metaTitle,
    this.metaTitleAr,
    this.metaDescription,
    this.metaDescriptionAr,
    this.keywords,
    this.keywordsAr,
    this.slugUrl,
    this.priority,
    this.changeFrequency,
    this.noIndex,
    this.noFollow,
    this.noArchive,
    this.noSnippet,
  });

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
    metaTitleAr = json['metaTitleAr'];
    metaDescription = json['metaDescription'];
    metaDescriptionAr = json['metaDescriptionAr'];
    keywords = json['keywords'] != null
        ? List<String>.from(json['keywords'])
        : null;
    keywordsAr = json['keywordsAr'] != null
        ? List<String>.from(json['keywordsAr'])
        : null;
    slugUrl = json['slugUrl'];
    priority = json['priority'];
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
  }
}

class PackageType {
  String? sId;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;

  PackageType({
    this.sId,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
  });

  PackageType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
  }
}

class Destination {
  Coordinates? coordinates;
  Weather? weather;
  String? sId;
  String? name;
  String? nameAr;
  String? slugUrl;
  String? coverImage;

  Destination({
    this.coordinates,
    this.weather,
    this.sId,
    this.name,
    this.nameAr,
    this.slugUrl,
    this.coverImage,
  });

  Destination.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
    weather = json['weather'] != null
        ? Weather.fromJson(json['weather'])
        : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    slugUrl = json['slugUrl'];
    coverImage = json['coverImage'];
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
  num? currentTemp;
  String? condition;
  num? humidity;
  num? windSpeed;
  String? lastUpdated;

  Weather({
    this.currentTemp,
    this.condition,
    this.humidity,
    this.windSpeed,
    this.lastUpdated,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    currentTemp = json['currentTemp'];
    condition = json['condition'];
    humidity = json['humidity'];
    windSpeed = json['windSpeed'];
    lastUpdated = json['lastUpdated'];
  }
}

class Itinerary {
  int? day;
  String? title;
  String? titleAr;
  String? description;
  String? descriptionAr;
  List<Activity>? activities;
  String? sId;

  Itinerary({
    this.day,
    this.title,
    this.titleAr,
    this.description,
    this.descriptionAr,
    this.activities,
    this.sId,
  });

  Itinerary.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    title = json['title'];
    titleAr = json['titleAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    if (json['activities'] != null) {
      activities = <Activity>[];
      json['activities'].forEach((v) {
        activities!.add(Activity.fromJson(v));
      });
    }
    sId = json['_id'];
  }
}

class Activity {
  String? name;
  String? nameAr;
  String? sId;

  Activity({this.name, this.nameAr, this.sId});

  Activity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameAr = json['nameAr'];
    sId = json['_id'];
  }
}

class Images {
  ImageDetail? coverImage;
  List<ImageDetail>? gallery;

  Images({this.coverImage, this.gallery});

  Images.fromJson(Map<String, dynamic> json) {
    coverImage = json['coverImage'] != null
        ? ImageDetail.fromJson(json['coverImage'])
        : null;
    if (json['gallery'] != null) {
      gallery = <ImageDetail>[];
      json['gallery'].forEach((v) {
        gallery!.add(ImageDetail.fromJson(v));
      });
    }
  }
}

class ImageDetail {
  String? sId;
  String? filename;
  String? originalName;
  String? url;
  String? alt;
  String? altAr;
  String? fullUrl;
  String? thumbnailUrl;

  ImageDetail({
    this.sId,
    this.filename,
    this.originalName,
    this.url,
    this.alt,
    this.altAr,
    this.fullUrl,
    this.thumbnailUrl,
  });

  ImageDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    filename = json['filename'];
    originalName = json['originalName'];
    url = json['url'];
    alt = json['alt'];
    altAr = json['altAr'];
    fullUrl = json['fullUrl'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}

class CreatedBy {
  String? sId;
  String? name;
  String? email;

  CreatedBy({this.sId, this.name, this.email});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }
}
