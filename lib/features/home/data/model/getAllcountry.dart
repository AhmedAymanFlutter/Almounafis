class GetAllCountry {
  String? status;
  int? results;
  List<Data>? data;

  GetAllCountry({this.status, this.results, this.data});

  GetAllCountry.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.seo,
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
      this.id});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seo != null) {
      data['seo'] = this.seo!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['code'] = this.code;
    data['continent'] = this.continent;
    data['currency'] = this.currency;
    data['language'] = this.language;
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['isActive'] = this.isActive;
    data['imageCover'] = this.imageCover;
    data['images'] = this.images;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['slug'] = this.slug;
    data['slugAr'] = this.slugAr;
    data['alt'] = this.alt;
    data['altAr'] = this.altAr;
    data['descriptionFlutter'] = this.descriptionFlutter;
    data['descriptionArFlutter'] = this.descriptionArFlutter;
    data['id'] = this.id;
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
      this.noSnippet,
      this.ogTitle,
      this.ogTitleAr,
      this.ogDescription,
      this.ogDescriptionAr,
      this.ogImage});

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
    data['ogTitle'] = this.ogTitle;
    data['ogTitleAr'] = this.ogTitleAr;
    data['ogDescription'] = this.ogDescription;
    data['ogDescriptionAr'] = this.ogDescriptionAr;
    data['ogImage'] = this.ogImage;
    return data;
  }
}