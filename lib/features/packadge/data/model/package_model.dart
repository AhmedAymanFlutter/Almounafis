class PackageModel {
  String? status;
  int? results;
  List<Data>? data;

  PackageModel({this.status, this.results, this.data});

  PackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    
    // Fixed: Handle both array and single object responses
    if (json['data'] != null) {
      data = <Data>[];
      
      // If data is a list
      if (json['data'] is List) {
        (json['data'] as List).forEach((v) {
          if (v != null) {
            data!.add(Data.fromJson(v as Map<String, dynamic>));
          }
        });
      } 
      // If data is a single object
      else if (json['data'] is Map<String, dynamic>) {
        data!.add(Data.fromJson(json['data'] as Map<String, dynamic>));
      }
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
  dynamic price; // Added price field

  Data(
      {this.seo,
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
      this.price});

  Data.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo'] as Map<String, dynamic>) : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    imageCover = json['imageCover'];
    alt = json['alt'];
    altAr = json['altAr'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    id = json['id'];
    price = json['price']; // Added price field
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seo != null) {
      data['seo'] = this.seo!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['imageCover'] = this.imageCover;
    data['alt'] = this.alt;
    data['altAr'] = this.altAr;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['slug'] = this.slug;
    data['slugAr'] = this.slugAr;
    data['id'] = this.id;
    data['price'] = this.price;
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
      this.ogDescription,
      this.canonicalUrl,
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
    ogDescription = json['ogDescription'];
    canonicalUrl = json['canonicalUrl'];
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
    data['ogDescription'] = this.ogDescription;
    data['canonicalUrl'] = this.canonicalUrl;
    data['ogImage'] = this.ogImage;
    return data;
  }
}