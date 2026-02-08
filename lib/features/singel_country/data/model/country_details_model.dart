class CountryDetailsResponse {
  bool? success;
  String? message;
  CountryDetailsData? data;
  bool? fromCache;

  CountryDetailsResponse({
    this.success,
    this.message,
    this.data,
    this.fromCache,
  });

  CountryDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? CountryDetailsData.fromJson(json['data'])
        : null;
    fromCache = json['fromCache'];
  }
}

class CountryDetailsData {
  ImagesData? images;
  SeoData? seo;
  String? sId;
  String? name;
  String? nameAr;
  String? code;
  String? continent;
  String? currency;
  String? language;
  String? description;
  String? descriptionAr;
  double? averageRating;
  int? totalRatings;
  String? descriptionArFlutter;
  String? descriptionFlutter;
  List<RelatedCountry>? relatedCountries;
  List<CityPreview>? cities;
  String? id;

  CountryDetailsData({
    this.images,
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
    this.averageRating,
    this.totalRatings,
    this.descriptionArFlutter,
    this.descriptionFlutter,
    this.relatedCountries,
    this.cities,
    this.id,
  });

  CountryDetailsData.fromJson(Map<String, dynamic> json) {
    images = json['images'] != null
        ? ImagesData.fromJson(json['images'])
        : null;
    seo = json['seo'] != null ? SeoData.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    code = json['code'];
    continent = json['continent'];
    currency = json['currency'];
    language = json['language'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    averageRating = json['averageRating']?.toDouble();
    totalRatings = json['totalRatings'];
    descriptionArFlutter = json['descriptionArFlutter'];
    descriptionFlutter = json['descriptionFlutter'];
    id = json['id'];

    // Parse related countries
    if (json['relatedCountries'] != null) {
      relatedCountries = <RelatedCountry>[];
      json['relatedCountries'].forEach((v) {
        relatedCountries!.add(RelatedCountry.fromJson(v));
      });
    }

    // Parse cities
    if (json['cities'] != null) {
      cities = <CityPreview>[];
      json['cities'].forEach((v) {
        cities!.add(CityPreview.fromJson(v));
      });
    }
  }
}

class ImagesData {
  CoverImage? coverImage;
  List<GalleryImage>? gallery;

  ImagesData({this.coverImage, this.gallery});

  ImagesData.fromJson(Map<String, dynamic> json) {
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
    if (json['gallery'] != null) {
      gallery = <GalleryImage>[];
      json['gallery'].forEach((v) {
        gallery!.add(GalleryImage.fromJson(v));
      });
    }
  }
}

class CoverImage {
  String? url;
  String? alt;
  String? altAr;

  CoverImage({this.url, this.alt, this.altAr});

  CoverImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    alt = json['alt'];
    altAr = json['altAr'];
  }
}

class GalleryImage {
  String? url;
  String? alt;
  String? altAr;

  GalleryImage({this.url, this.alt, this.altAr});

  GalleryImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    alt = json['alt'];
    altAr = json['altAr'];
  }
}

class SeoData {
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
  String? ogImage;

  SeoData({
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
    this.ogImage,
  });

  SeoData.fromJson(Map<String, dynamic> json) {
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
    ogImage = json['ogImage'];
  }
}

class RelatedCountry {
  String? sId;
  String? name;
  String? nameAr;
  String? slug;
  CoverImage? coverImage;

  RelatedCountry({
    this.sId,
    this.name,
    this.nameAr,
    this.slug,
    this.coverImage,
  });

  RelatedCountry.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    slug = json['slug'];
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
  }
}

class CityPreview {
  String? sId;
  String? name;
  String? nameAr;
  String? slug;
  CoverImage? coverImage;

  CityPreview({this.sId, this.name, this.nameAr, this.slug, this.coverImage});

  CityPreview.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    slug = json['slug'];
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
  }
}
