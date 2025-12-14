class GitHotelModel {
  String? status;
  int? results;
  List<Data>? data;

  GitHotelModel({this.status, this.results, this.data});

  GitHotelModel.fromJson(Map<String, dynamic> json) {
    status = json['success']?.toString();

    // استخراج العدد الكلي
    if (json['data'] != null && json['data'] is Map) {
      results = json['data']['total'];
    } else {
      results = json['results'];
    }

    // استخراج الفنادق
    if (json['data'] != null) {
      if (json['data'] is Map && json['data']['hotels'] != null) {
        data = <Data>[];
        json['data']['hotels'].forEach((v) {
          data!.add(Data.fromJson(v));
        });
      } else if (json['data'] is List) {
        data = <Data>[];
        json['data'].forEach((v) {
          data!.add(Data.fromJson(v));
        });
      }
      // حالة خاصة: تفاصيل فندق واحد داخل "data" مباشرة
      else if (json['data'] is Map && json['data']['name'] != null) {
        data = [];
        data!.add(Data.fromJson(json['data']));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['results'] = results;
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
  String? imageCover;
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

  Data({
    this.priceRange,
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
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    priceRange = json['priceRange'] != null
        ? PriceRange.fromJson(json['priceRange'])
        : null;
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];

    // ✅ معالجة الصور بذكاء
    images = [];
    if (json['images'] != null) {
      if (json['images'] is List) {
        images = json['images'].cast<String>();
      } else if (json['images'] is Map) {
        // استخراج صورة الغلاف
        if (json['images']['coverImage'] != null) {
          var cover = json['images']['coverImage'];
          if (cover is Map && cover['url'] != null) {
            String url = cover['url'].toString();
            images!.add(url);
            imageCover = url;
          } else if (cover is String) {
            images!.add(cover);
            imageCover = cover;
          }
        }
        // استخراج المعرض
        if (json['images']['gallery'] != null &&
            json['images']['gallery'] is List) {
          json['images']['gallery'].forEach((img) {
            if (img is Map && img['url'] != null) {
              images!.add(img['url'].toString());
            } else if (img is String) {
              images!.add(img);
            }
          });
        }
      }
    }

    // ✅ التأكد من imageCover (قد يأتي كنص أو كائن)
    if (imageCover == null && json['imageCover'] != null) {
      if (json['imageCover'] is String) {
        imageCover = json['imageCover'];
      } else if (json['imageCover'] is Map &&
          json['imageCover']['url'] != null) {
        imageCover = json['imageCover']['url'].toString();
      }
    }

    alt = json['alt'];
    altAr = json['altAr'];
    description = _safeString(json['description']);
    descriptionAr = _safeString(json['descriptionAr']);
    descriptionFlutter = _safeString(json['descriptionFlutter']);
    descriptionArFlutter = _safeString(json['descriptionArFlutter']);

    // ✅✅ الحل الجذري للخطأ: استخراج الاسم إذا كان الحقل كائناً
    country = _extractName(json['country']);
    city = _extractName(json['city']);

    // دعم إضافي لهيكلة locationInfo
    if (country == null && json['locationInfo'] != null) {
      country = _extractName(json['locationInfo']['country']);
      city = _extractName(json['locationInfo']['city']);
      if (address == null) address = json['locationInfo']['address'];
    }

    address = json['address'];
    addressAr = json['addressAr'];
    category = json['category'];
    categoryAr = json['categoryAr'];
    starRating = json['starRating'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];

    if (json['amenities'] != null && json['amenities'] is List) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(Amenities.fromJson(v));
      });
    }

    totalRooms = json['totalRooms'];

    if (json['roomTypes'] != null && json['roomTypes'] is List) {
      roomTypes = <RoomType>[];
      json['roomTypes'].forEach((v) {
        roomTypes!.add(RoomType.fromJson(v));
      });
    }

    isActive = json['isActive'];
    isFeatured = json['isFeatured'];
    isVerified = json['isVerified'];

    // ✅ إصلاح CreatedBy
    createdBy = _extractName(json['createdBy']);
    updatedBy = _extractName(json['updatedBy']);

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    fullAddress = json['fullAddress'];
    ratingDisplay = json['ratingDisplay'] != null
        ? RatingDisplay.fromJson(json['ratingDisplay'])
        : null;
    id = json['id'];
  }

  // 🛠️ دوال مساعدة لمنع الأخطاء

  // دالة لاستخراج الاسم من كائن أو إرجاع النص كما هو
  String? _extractName(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map) {
      return value['name'] ?? value['nameAr'] ?? value['username'];
    }
    return value.toString();
  }

  // دالة لتحويل أي قيمة (مثل القوائم) إلى نص
  String? _safeString(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.join('\n');
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    // ... (نفس كود الـ toJson السابق)
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    // ... أكمل باقي الحقول كما هي
    return data;
  }
}

// ... (باقي الكلاسات: PriceRange, Rating, Seo, Amenities, RatingDisplay, RoomType تبقى كما هي)
class PriceRange {
  int? min;
  int? max;
  String? currency;
  PriceRange.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
    currency = json['currency'];
  }
  Map<String, dynamic> toJson() => {};
}

class Rating {
  dynamic average;
  int? totalReviews;
  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    totalReviews = json['totalReviews'];
  }
  Map<String, dynamic> toJson() => {};
}

class Seo {
  String? metaTitle;
  // ... باقي الحقول
  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
  }
  Map<String, dynamic> toJson() => {};
}

class Amenities {
  String? name;
  String? sId;
  Amenities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
  }
  Map<String, dynamic> toJson() => {};
}

class RatingDisplay {
  dynamic average;
  RatingDisplay.fromJson(Map<String, dynamic> json) {
    average = json['average'];
  }
  Map<String, dynamic> toJson() => {};
}

class RoomType {
  String? name;
  RoomType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
  Map<String, dynamic> toJson() => {};
}
