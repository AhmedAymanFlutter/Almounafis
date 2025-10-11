class GitHotelModel {
  String? status;
  int? results;
  List<Data>? data;

  GitHotelModel({this.status, this.results, this.data});

  GitHotelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  PriceRange? priceRange;
  Rating? rating;
  Seo? seo;
  String? sId;
  String? name;
  String? nameAr;
  List<String>? images;
  Null imageCover;
  String? alt;
  String? altAr;
  String? description;
  String? descriptionAr;
  String? descriptionFlutter;
  String? descriptionArFlutter;
  String? country;
  String? city;
  String? address;
  String? addressAr;
  String? category;
  String? categoryAr;
  int? starRating;
  String? phone;
  String? email;
  String? website;
  List<Amenities>? amenities;
  int? totalRooms;
  List<RoomType>? roomTypes;
  bool? isActive;
  bool? isFeatured;
  bool? isVerified;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? slugAr;
  String? fullAddress;
  RatingDisplay? ratingDisplay;
  String? id;

  Data(
      {this.priceRange,
      this.rating,
      this.seo,
      this.sId,
      this.name,
      this.nameAr,
      this.images,
      this.imageCover,
      this.alt,
      this.altAr,
      this.description,
      this.descriptionAr,
      this.descriptionFlutter,
      this.descriptionArFlutter,
      this.country,
      this.city,
      this.address,
      this.addressAr,
      this.category,
      this.categoryAr,
      this.starRating,
      this.phone,
      this.email,
      this.website,
      this.amenities,
      this.totalRooms,
      this.roomTypes,
      this.isActive,
      this.isFeatured,
      this.isVerified,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.slug,
      this.slugAr,
      this.fullAddress,
      this.ratingDisplay,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    priceRange = json['priceRange'] != null
        ? new PriceRange.fromJson(json['priceRange'])
        : null;
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    seo = json['seo'] != null ? new Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    images = json['images'].cast<String>();
    imageCover = json['imageCover'];
    alt = json['alt'];
    altAr = json['altAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    descriptionFlutter = json['descriptionFlutter'];
    descriptionArFlutter = json['descriptionArFlutter'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    addressAr = json['addressAr'];
    category = json['category'];
    categoryAr = json['categoryAr'];
    starRating = json['starRating'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
    totalRooms = json['totalRooms'];
    if (json['roomTypes'] != null) {
      roomTypes = <RoomType>[];
      json['roomTypes'].forEach((v) {
        roomTypes!.add(new RoomType.fromJson(v));
      });
    }
    isActive = json['isActive'];
    isFeatured = json['isFeatured'];
    isVerified = json['isVerified'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    fullAddress = json['fullAddress'];
    ratingDisplay = json['ratingDisplay'] != null
        ? new RatingDisplay.fromJson(json['ratingDisplay'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.priceRange != null) {
      data['priceRange'] = this.priceRange!.toJson();
    }
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    if (this.seo != null) {
      data['seo'] = this.seo!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['images'] = this.images;
    data['imageCover'] = this.imageCover;
    data['alt'] = this.alt;
    data['altAr'] = this.altAr;
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['descriptionFlutter'] = this.descriptionFlutter;
    data['descriptionArFlutter'] = this.descriptionArFlutter;
    data['country'] = this.country;
    data['city'] = this.city;
    data['address'] = this.address;
    data['addressAr'] = this.addressAr;
    data['category'] = this.category;
    data['categoryAr'] = this.categoryAr;
    data['starRating'] = this.starRating;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['website'] = this.website;
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    data['totalRooms'] = this.totalRooms;
    if (this.roomTypes != null) {
      data['roomTypes'] = this.roomTypes!.map((v) => v.toJson()).toList();
    }
    data['isActive'] = this.isActive;
    data['isFeatured'] = this.isFeatured;
    data['isVerified'] = this.isVerified;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['slug'] = this.slug;
    data['slugAr'] = this.slugAr;
    data['fullAddress'] = this.fullAddress;
    if (this.ratingDisplay != null) {
      data['ratingDisplay'] = this.ratingDisplay!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class PriceRange {
  int? min;
  int? max;
  String? currency;

  PriceRange({this.min, this.max, this.currency});

  PriceRange.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    data['currency'] = this.currency;
    return data;
  }
}

class Rating {
  int? average;
  int? totalReviews;

  Rating({this.average, this.totalReviews});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    totalReviews = json['totalReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this.average;
    data['totalReviews'] = this.totalReviews;
    return data;
  }
}

class Seo {
  String? metaTitle;
  String? metaTitleAr;
  String? metaDescription;
  String? metaDescriptionAr;
  String? keywords;
  String? keywordsAr;
  String? slugUrl;
  String? priority;
  String? changeFrequency;
  bool? noIndex;
  bool? noFollow;
  bool? noArchive;
  bool? noSnippet;

  Seo(
      {this.metaTitle,
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
      this.noSnippet});

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
    metaTitleAr = json['metaTitleAr'];
    metaDescription = json['metaDescription'];
    metaDescriptionAr = json['metaDescriptionAr'];
    keywords = json['keywords'];
    keywordsAr = json['keywordsAr'];
    slugUrl = json['slugUrl'];
    priority = json['priority'];
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metaTitle'] = this.metaTitle;
    data['metaTitleAr'] = this.metaTitleAr;
    data['metaDescription'] = this.metaDescription;
    data['metaDescriptionAr'] = this.metaDescriptionAr;
    data['keywords'] = this.keywords;
    data['keywordsAr'] = this.keywordsAr;
    data['slugUrl'] = this.slugUrl;
    data['priority'] = this.priority;
    data['changeFrequency'] = this.changeFrequency;
    data['noIndex'] = this.noIndex;
    data['noFollow'] = this.noFollow;
    data['noArchive'] = this.noArchive;
    data['noSnippet'] = this.noSnippet;
    return data;
  }
}

class Amenities {
  String? key;
  String? name;
  String? nameAr;
  String? sId;
  String? id;

  Amenities({this.key, this.name, this.nameAr, this.sId, this.id});

  Amenities.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    nameAr = json['nameAr'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class RatingDisplay {
  int? average;
  int? total;
  int? stars;

  RatingDisplay({this.average, this.total, this.stars});

  RatingDisplay.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    total = json['total'];
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this.average;
    data['total'] = this.total;
    data['stars'] = this.stars;
    return data;
  }
}

class RoomType {
  String? id;
  String? name;
  String? description;

  RoomType({this.id, this.name, this.description});

  RoomType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}