class AllCityTour {
  String? status;
  int? results;
  List<Data>? data;

  AllCityTour({this.status, this.results, this.data});

  AllCityTour.fromJson(Map<String, dynamic> json) {
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
  Duration? duration;
  Seo? seo;
  String? sId;
  String? title;
  String? titleAr;
  String? description;
  String? descriptionAr;
  String? descriptionFlutter;
  String? descriptionArFlutter;
  String? city;
  List<String>? images;
  String? coverImage;
  List<dynamic>? includes;
  List<dynamic>? includesAr;
  List<dynamic>? excludes;
  List<dynamic>? excludesAr;
  int? totalReviews;
  List<String>? tags;
  List<String>? tagsAr;
  String? slug;
  String? createdBy;
  List<dynamic>? activities;
  String? createdAt;
  String? updatedAt;
  String? slugAr;
  String? id;

  Data(
      {this.duration,
      this.seo,
      this.sId,
      this.title,
      this.titleAr,
      this.description,
      this.descriptionAr,
      this.descriptionFlutter,
      this.descriptionArFlutter,
      this.city,
      this.images,
      this.coverImage,
      this.includes,
      this.includesAr,
      this.excludes,
      this.excludesAr,
      this.totalReviews,
      this.tags,
      this.tagsAr,
      this.slug,
      this.createdBy,
      this.activities,
      this.createdAt,
      this.updatedAt,
      this.slugAr,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    duration = json['duration'] != null
        ? new Duration.fromJson(json['duration'])
        : null;
    seo = json['seo'] != null ? new Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    title = json['title'];
    titleAr = json['titleAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    descriptionFlutter = json['descriptionFlutter'];
    descriptionArFlutter = json['descriptionArFlutter'];
    city = json['city'];
    images = json['images'].cast<String>();
    coverImage = json['coverImage'];
    if (json['includes'] != null) {
      includes = <dynamic>[];
      json['includes'].forEach((v) {
        includes!.add(v);
      });
    }
    if (json['includesAr'] != null) {
      includesAr = <dynamic>[];
      json['includesAr'].forEach((v) {
        includesAr!.add(v);
      });
    }
    if (json['excludes'] != null) {
      excludes = <dynamic>[];
      json['excludes'].forEach((v) {
        excludes!.add(v);
      });
    }
    if (json['excludesAr'] != null) {
      excludesAr = <dynamic>[];
      json['excludesAr'].forEach((v) {
        excludesAr!.add(v);
      });
    }
    totalReviews = json['totalReviews'];
    tags = json['tags'].cast<String>();
    tagsAr = json['tagsAr'].cast<String>();
    slug = json['slug'];
    createdBy = json['createdBy'];
    if (json['activities'] != null) {
      activities = <dynamic>[];
      json['activities'].forEach((v) {
        activities!.add(v);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slugAr = json['slugAr'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    if (this.seo != null) {
      data['seo'] = this.seo!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['titleAr'] = this.titleAr;
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['descriptionFlutter'] = this.descriptionFlutter;
    data['descriptionArFlutter'] = this.descriptionArFlutter;
    data['city'] = this.city;
    data['images'] = this.images;
    data['coverImage'] = this.coverImage;
    if (this.includes != null) {
      data['includes'] = this.includes;
    }
    if (this.includesAr != null) {
      data['includesAr'] = this.includesAr;
    }
    if (this.excludes != null) {
      data['excludes'] = this.excludes;
    }
    if (this.excludesAr != null) {
      data['excludesAr'] = this.excludesAr;
    }
    data['totalReviews'] = this.totalReviews;
    data['tags'] = this.tags;
    data['tagsAr'] = this.tagsAr;
    data['slug'] = this.slug;
    data['createdBy'] = this.createdBy;
    if (this.activities != null) {
      data['activities'] = this.activities;
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['slugAr'] = this.slugAr;
    data['id'] = this.id;
    return data;
  }
}

class Duration {
  int? hours;
  String? type;

  Duration({this.hours, this.type, required int seconds});

  Duration.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hours'] = this.hours;
    data['type'] = this.type;
    return data;
  }
}

class Seo {
  String? keywords;
  String? keywordsAr;
  String? priority;
  String? changeFrequency;
  bool? noIndex;
  bool? noFollow;
  bool? noArchive;
  bool? noSnippet;
  String? slugUrl;
  String? metaTitle;
  String? metaTitleAr;
  String? metaDescription;
  String? metaDescriptionAr;
  String? canonicalUrl;

  Seo(
      {this.keywords,
      this.keywordsAr,
      this.priority,
      this.changeFrequency,
      this.noIndex,
      this.noFollow,
      this.noArchive,
      this.noSnippet,
      this.slugUrl,
      this.metaTitle,
      this.metaTitleAr,
      this.metaDescription,
      this.metaDescriptionAr,
      this.canonicalUrl});

  Seo.fromJson(Map<String, dynamic> json) {
    keywords = json['keywords'];
    keywordsAr = json['keywordsAr'];
    priority = json['priority'];
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
    slugUrl = json['slugUrl'];
    metaTitle = json['metaTitle'];
    metaTitleAr = json['metaTitleAr'];
    metaDescription = json['metaDescription'];
    metaDescriptionAr = json['metaDescriptionAr'];
    canonicalUrl = json['canonicalUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keywords'] = this.keywords;
    data['keywordsAr'] = this.keywordsAr;
    data['priority'] = this.priority;
    data['changeFrequency'] = this.changeFrequency;
    data['noIndex'] = this.noIndex;
    data['noFollow'] = this.noFollow;
    data['noArchive'] = this.noArchive;
    data['noSnippet'] = this.noSnippet;
    data['slugUrl'] = this.slugUrl;
    data['metaTitle'] = this.metaTitle;
    data['metaTitleAr'] = this.metaTitleAr;
    data['metaDescription'] = this.metaDescription;
    data['metaDescriptionAr'] = this.metaDescriptionAr;
    data['canonicalUrl'] = this.canonicalUrl;
    return data;
  }
}