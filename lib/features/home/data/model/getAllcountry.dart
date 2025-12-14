class GetAllCountry {
  String? status;
  int? results;
  List<Data>? data;

  GetAllCountry({this.status, this.results, this.data});

  GetAllCountry.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];

    print('🔍 Parsing GetAllCountry...');
    if (json['data'] == null) {
      print('❌ json["data"] is NULL');
    } else {
      print('🔍 json["data"] type: ${json['data'].runtimeType}');
      if (json['data'] is Map) {
        print('🔍 json["data"] keys: ${(json['data'] as Map).keys}');
      }
    }

    if (json['data'] != null) {
      data = <Data>[];
      if (json['data'] is List) {
        print('✅ json["data"] is List');
        json['data'].forEach((v) {
          data!.add(new Data.fromJson(v));
        });
      } else if (json['data'] is Map<String, dynamic>) {
        print('✅ json["data"] is Map');
        if (json['data']['data'] != null && json['data']['data'] is List) {
          print('✅ Found "data" key in Map');
          json['data']['data'].forEach((v) {
            data!.add(new Data.fromJson(v));
          });
        } else if (json['data']['results'] != null &&
            json['data']['results'] is List) {
          print('✅ Found "results" key in Map');
          json['data']['results'].forEach((v) {
            data!.add(new Data.fromJson(v));
          });
        } else if (json['data']['docs'] != null &&
            json['data']['docs'] is List) {
          print('✅ Found "docs" key in Map');
          json['data']['docs'].forEach((v) {
            data!.add(new Data.fromJson(v));
          });
        } else if (json['data']['countries'] != null &&
            json['data']['countries'] is List) {
          print('✅ Found "countries" key in Map');
          json['data']['countries'].forEach((v) {
            data!.add(new Data.fromJson(v));
          });
        } else {
          print('❌ No known key found in json["data"] Map');
        }
      } else {
        print('❌ json["data"] is neither List nor Map');
      }
    }
    print('🏁 Parsed data length: ${data?.length}');
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
  String? code;
  String? continent;
  String? currency;
  String? language;
  String? description;
  String? descriptionAr;
  bool? isActive;
  String? imageCover;
  List<String>? images;
  String? createdBy;
  Null updatedBy;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? slugAr;
  String? alt;
  String? altAr;
  String? descriptionFlutter;
  String? descriptionArFlutter;
  String? id;

  Data({
    this.seo,
    this.sId,
    this.name,
    this.nameAr,
    this.code,
    this.continent,
    this.currency,
    this.language,
    this.description,
    this.descriptionAr,
    this.isActive,
    this.imageCover,
    this.images,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.slugAr,
    this.alt,
    this.altAr,
    this.descriptionFlutter,
    this.descriptionArFlutter,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? new Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    code = json['code'];
    continent = json['continent'];
    currency = json['currency'];
    language = json['language'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    isActive = json['isActive'];
    imageCover = json['imageCover'];
    images = json['images'].cast<String>();
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    alt = json['alt'];
    altAr = json['altAr'];
    descriptionFlutter = json['descriptionFlutter'];
    descriptionArFlutter = json['descriptionArFlutter'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (seo != null) {
      data['seo'] = seo!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['nameAr'] = nameAr;
    data['code'] = code;
    data['continent'] = continent;
    data['currency'] = currency;
    data['language'] = language;
    data['description'] = description;
    data['descriptionAr'] = descriptionAr;
    data['isActive'] = isActive;
    data['imageCover'] = imageCover;
    data['images'] = images;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['slug'] = slug;
    data['slugAr'] = slugAr;
    data['alt'] = alt;
    data['altAr'] = altAr;
    data['descriptionFlutter'] = descriptionFlutter;
    data['descriptionArFlutter'] = descriptionArFlutter;
    data['id'] = id;
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
  String? ogTitleAr;
  String? ogDescription;
  String? ogDescriptionAr;
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
    this.ogTitleAr,
    this.ogDescription,
    this.ogDescriptionAr,
    this.ogImage,
  });

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
    ogTitle = json['ogTitle'];
    ogTitleAr = json['ogTitleAr'];
    ogDescription = json['ogDescription'];
    ogDescriptionAr = json['ogDescriptionAr'];
    ogImage = json['ogImage'];
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
    data['ogTitleAr'] = ogTitleAr;
    data['ogDescription'] = ogDescription;
    data['ogDescriptionAr'] = ogDescriptionAr;
    data['ogImage'] = ogImage;
    return data;
  }
}
