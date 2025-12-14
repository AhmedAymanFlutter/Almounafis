class PackageModel {
  String? status;
  int? results;
  List<Data>? data;

  PackageModel({this.status, this.results, this.data});

  PackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];

    if (json['data'] != null) {
      data = <Data>[];

      // معالجة البيانات سواء كانت قائمة أو كائن مفرد
      if (json['data'] is List) {
        (json['data'] as List).forEach((v) {
          if (v != null) {
            data!.add(Data.fromJson(v as Map<String, dynamic>));
          }
        });
      } else if (json['data'] is Map<String, dynamic>) {
        data!.add(Data.fromJson(json['data'] as Map<String, dynamic>));
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
  Seo? seo;
  String? sId;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  String? imageCover;
  String? alt;
  String? altAr;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? slugAr;
  String? id;
  dynamic price;

  Data({
    this.seo,
    this.sId,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
    this.imageCover,
    this.alt,
    this.altAr,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.slugAr,
    this.id,
    this.price,
  });

  Data.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];

    // معالجة الصور (قد تأتي ككائن في بعض الأحيان)
    if (json['imageCover'] is Map) {
      imageCover = json['imageCover']['url'];
    } else {
      imageCover = json['imageCover'];
    }

    alt = json['alt'];
    altAr = json['altAr'];

    // ✅✅ الحل الجذري لمشكلة Map is not String
    createdBy = _parseNameFromObject(json['createdBy']);
    updatedBy = _parseNameFromObject(json['updatedBy']);

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    id = json['id'];
    price = json['price'];
  }

  // دالة مساعدة لاستخراج الاسم سواء كان نصاً أو كائناً
  String? _parseNameFromObject(dynamic val) {
    if (val == null) return null;
    if (val is String) return val;
    if (val is Map) {
      return val['name'] ?? val['username'] ?? val['email'];
    }
    return val.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (seo != null) {
      data['seo'] = seo!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['nameAr'] = nameAr;
    data['description'] = description;
    data['descriptionAr'] = descriptionAr;
    data['imageCover'] = imageCover;
    data['alt'] = alt;
    data['altAr'] = altAr;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['slug'] = slug;
    data['slugAr'] = slugAr;
    data['id'] = id;
    data['price'] = price;
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
  String? ogTitle;
  String? ogDescription;
  String? canonicalUrl;
  String? ogImage;

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
    this.ogTitle,
    this.ogDescription,
    this.canonicalUrl,
    this.ogImage,
  });

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
    metaTitleAr = json['metaTitleAr'];
    metaDescription = json['metaDescription'];
    metaDescriptionAr = json['metaDescriptionAr'];

    // ✅✅ معالجة الكلمات المفتاحية لتجنب خطأ القائمة
    keywords = _parseList(json['keywords']);
    keywordsAr = _parseList(json['keywordsAr']);

    slugUrl = json['slugUrl'];
    priority = json['priority'];
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
    ogTitle = json['ogTitle'];
    ogDescription = json['ogDescription'];
    canonicalUrl = json['canonicalUrl'];
    ogImage = json['ogImage'];
  }

  // دالة لتحويل القوائم إلى نصوص بأمان
  String? _parseList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value.join(', ');
    }
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['metaTitle'] = metaTitle;
    data['metaTitleAr'] = metaTitleAr;
    data['metaDescription'] = metaDescription;
    data['metaDescriptionAr'] = metaDescriptionAr;
    data['keywords'] = keywords;
    data['keywordsAr'] = keywordsAr;
    data['slugUrl'] = slugUrl;
    data['priority'] = priority;
    data['changeFrequency'] = changeFrequency;
    data['noIndex'] = noIndex;
    data['noFollow'] = noFollow;
    data['noArchive'] = noArchive;
    data['noSnippet'] = noSnippet;
    data['ogTitle'] = ogTitle;
    data['ogDescription'] = ogDescription;
    data['canonicalUrl'] = canonicalUrl;
    data['ogImage'] = ogImage;
    return data;
  }
}
