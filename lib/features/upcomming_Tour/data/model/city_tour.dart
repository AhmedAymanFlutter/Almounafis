class AllCityTour {
  bool? success;
  String? message;
  int? results;
  List<CityTourData>? data;

  AllCityTour({this.success, this.message, this.results, this.data});

  AllCityTour.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    // ✅ الوصول الصحيح: data -> tours
    if (json['data'] != null && json['data'] is Map) {
      if (json['data']['tours'] != null) {
        data = <CityTourData>[];
        json['data']['tours'].forEach((v) {
          data!.add(CityTourData.fromJson(v));
        });
      }
      // أحياناً يكون العدد في total أو results
      results = json['data']['total'] ?? json['results'];
    }
  }
}

class CityTourData {
  String? sId;
  String? title;
  String? titleAr;
  String? description;
  String? descriptionAr;
  String? descriptionFlutter;
  String? descriptionArFlutter;

  // ✅ تم التعديل: نستخرج اسم المدينة من الكائن
  String? cityName;
  String? cityNameAr;

  // ✅ تم التعديل: قائمة صور جاهزة للعرض
  List<String>? images;
  String? coverImageUrl;
  // Alias for UI compatibility
  String? get coverImage => coverImageUrl;

  List<String>? includes;
  List<String>? includesAr;
  List<String>? excludes;
  List<String>? excludesAr;
  List<String>? tags;
  List<String>? tagsAr;

  TourDuration? duration;
  Seo? seo;

  // حقول إضافية قد تحتاجها
  double? price;
  String? id;

  CityTourData({
    this.sId,
    this.title,
    this.titleAr,
    this.description,
    this.descriptionAr,
    this.descriptionFlutter,
    this.descriptionArFlutter,
    this.cityName,
    this.cityNameAr,
    this.images,
    this.coverImageUrl,
    this.duration,
    this.seo,
    this.price,
    this.id,
  });

  CityTourData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = _safeString(json['title']);
    titleAr = _safeString(json['titleAr']);

    // معالجة النصوص بأمان
    description = _safeString(json['description']);
    descriptionAr = _safeString(json['descriptionAr']);
    descriptionFlutter = _safeString(json['descriptionFlutter']);
    descriptionArFlutter = _safeString(json['descriptionArFlutter']);

    // ✅ 1. معالجة المدينة (City Object -> String)
    if (json['city'] != null && json['city'] is Map) {
      cityName = json['city']['name'];
      cityNameAr = json['city']['nameAr'];
    } else if (json['city'] is String) {
      cityName = json['city'];
    }

    // ✅ 2. معالجة الصور (Images Object -> List<String>)
    images = [];
    if (json['images'] != null && json['images'] is Map) {
      // استخراج صورة الغلاف
      if (json['images']['coverImage'] != null &&
          json['images']['coverImage']['url'] != null) {
        String url = json['images']['coverImage']['url'];
        coverImageUrl = url; // حفظها كصورة غلاف
        images!.add(url); // إضافتها للقائمة
      }

      // استخراج المعرض
      if (json['images']['gallery'] != null &&
          json['images']['gallery'] is List) {
        json['images']['gallery'].forEach((img) {
          if (img['url'] != null) {
            images!.add(img['url']);
          }
        });
      }
    }

    // ✅ 3. معالجة السعر (من الباقات Packages إن وجدت)
    if (json['packages'] != null && (json['packages'] as List).isNotEmpty) {
      // نأخذ سعر أول باقة كـ سعر افتراضي
      var firstPackage = json['packages'][0];
      if (firstPackage['price'] != null) {
        // التأكد من أنه رقم (double أو int)
        price = double.tryParse(firstPackage['price'].toString());
      }
    }

    // Parsing new fields
    includes = _parseList(json['includes']);
    includesAr = _parseList(json['includesAr']);
    excludes = _parseList(json['excludes']);
    excludesAr = _parseList(json['excludesAr']);
    tags = _parseList(json['tags']);
    tagsAr = _parseList(json['tagsAr']);

    duration = json['duration'] != null
        ? TourDuration.fromJson(json['duration'])
        : null;
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    id = json['id'];
  }

  // دالة مساعدة
  static String? _safeString(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.join(' ');
    return value.toString();
  }

  static List<String>? _parseList(dynamic json) {
    if (json == null) return null;
    if (json is List) {
      return json.map((e) => e.toString()).toList();
    }
    return null;
  }
}

class TourDuration {
  int? hours;
  String? type;

  TourDuration({this.hours, this.type});

  TourDuration.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    type = json['type'];
  }
}

class Seo {
  String? metaTitle;
  String? metaTitleAr;
  String? metaDescription;
  String? metaDescriptionAr;
  String? keywords;
  String? keywordsAr;

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
    metaTitleAr = json['metaTitleAr'];
    metaDescription = json['metaDescription'];
    metaDescriptionAr = json['metaDescriptionAr'];

    // معالجة الكلمات المفتاحية سواء كانت نص أو قائمة
    if (json['keywords'] is List) {
      keywords = (json['keywords'] as List).join(', ');
    } else {
      keywords = json['keywords']?.toString();
    }

    if (json['keywordsAr'] is List) {
      keywordsAr = (json['keywordsAr'] as List).join(', ');
    } else {
      keywordsAr = json['keywordsAr']?.toString();
    }
  }
}
