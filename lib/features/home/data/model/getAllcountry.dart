class GetAllCountriesModel {
  bool? success;
  String? message;
  List<CountryData>? countries; // ✅ الاسم الصحيح للقائمة
  int? total;

  GetAllCountriesModel({
    this.success,
    this.message,
    this.countries,
    this.total,
  });

  GetAllCountriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    // ✅ استخراج البيانات من data -> countries
    if (json['data'] != null && json['data'] is Map) {
      if (json['data']['countries'] != null) {
        countries = <CountryData>[];
        json['data']['countries'].forEach((v) {
          countries!.add(CountryData.fromJson(v));
        });
      }
      total = json['data']['total'];
    }
  }
}

class CountryData {
  String? sId;
  String? name;
  String? nameAr;
  String? code;
  String? continent;
  String? currency;
  String? language;
  String? description;
  String? descriptionAr;
  String? descriptionFlutter;
  String? descriptionArFlutter;
  List<String>? images;
  Seo? seo;
  bool? isActive;
  String? id;

  CountryData({
    this.sId,
    this.name,
    this.nameAr,
    this.code,
    this.continent,
    this.currency,
    this.language,
    this.description,
    this.descriptionAr,
    this.descriptionFlutter,
    this.descriptionArFlutter,
    this.images,
    this.seo,
    this.isActive,
    this.id,
  });

  CountryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = _safeString(json['name']);
    nameAr = _safeString(json['nameAr']);
    code = _safeString(json['code']);
    continent = _safeString(json['continent']);
    currency = _safeString(json['currency']);
    language = _safeString(json['language']);

    // ✅ استخدام _safeString لمنع خطأ List is not String
    description = _safeString(json['description']);
    descriptionAr = _safeString(json['descriptionAr']);
    descriptionFlutter = _safeString(json['descriptionFlutter']);
    descriptionArFlutter = _safeString(json['descriptionArFlutter']);

    // معالجة الصور
    images = [];
    if (json['images'] != null && json['images'] is Map) {
      if (json['images']['coverImage'] != null &&
          json['images']['coverImage']['url'] != null) {
        images!.add(json['images']['coverImage']['url'].toString());
      }
      if (json['images']['gallery'] != null &&
          json['images']['gallery'] is List) {
        json['images']['gallery'].forEach((img) {
          if (img['url'] != null) {
            images!.add(img['url'].toString());
          }
        });
      }
    }

    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    isActive = json['isActive'];
    id = json['id'];
  }

  // ✅ دالة الحماية: تحول أي شيء (حتى القوائم) إلى نص
  static String? _safeString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is List) return value.join(' '); // دمج القائمة في نص واحد
    return value.toString();
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

  Seo({
    this.metaTitle,
    this.metaTitleAr,
    this.metaDescription,
    this.metaDescriptionAr,
    this.keywords,
    this.keywordsAr,
    this.slugUrl,
  });

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = CountryData._safeString(json['metaTitle']);
    metaTitleAr = CountryData._safeString(json['metaTitleAr']);
    metaDescription = CountryData._safeString(json['metaDescription']);
    metaDescriptionAr = CountryData._safeString(json['metaDescriptionAr']);

    // معالجة الكلمات المفتاحية بأمان
    keywords = CountryData._safeString(json['keywords']);
    keywordsAr = CountryData._safeString(json['keywordsAr']);

    slugUrl = CountryData._safeString(json['slugUrl']);
  }
}
