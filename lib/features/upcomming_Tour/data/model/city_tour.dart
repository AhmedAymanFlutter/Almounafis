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
      if (json['data'] is List) {
        json['data'].forEach((v) {
          data!.add(Data.fromJson(v));
        });
      } else if (json['data'] is Map<String, dynamic>) {
        if (json['data']['data'] != null && json['data']['data'] is List) {
          json['data']['data'].forEach((v) {
            data!.add(Data.fromJson(v));
          });
        } else if (json['data']['docs'] != null &&
            json['data']['docs'] is List) {
          json['data']['docs'].forEach((v) {
            data!.add(new Data.fromJson(v));
          });
        } else if (json['data']['tours'] != null &&
            json['data']['tours'] is List) {
          json['data']['tours'].forEach((v) {
            data!.add(new Data.fromJson(v));
          });
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['results'] = results;
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

  Data({
    this.duration,
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
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    duration = json['duration'] != null
        ? Duration.fromJson(json['duration'])
        : null;
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    if (seo != null) {
      data['seo'] = seo!.toJson();
    }
    data['_id'] = sId;
    data['title'] = title;
    data['titleAr'] = titleAr;
    data['description'] = description;
    data['descriptionAr'] = descriptionAr;
    data['descriptionFlutter'] = descriptionFlutter;
    data['descriptionArFlutter'] = descriptionArFlutter;
    data['city'] = city;
    data['images'] = images;
    data['coverImage'] = coverImage;
    if (includes != null) {
      data['includes'] = includes;
    }
    if (includesAr != null) {
      data['includesAr'] = includesAr;
    }
    if (excludes != null) {
      data['excludes'] = excludes;
    }
    if (excludesAr != null) {
      data['excludesAr'] = excludesAr;
    }
    data['totalReviews'] = totalReviews;
    data['tags'] = tags;
    data['tagsAr'] = tagsAr;
    data['slug'] = slug;
    data['createdBy'] = createdBy;
    if (activities != null) {
      data['activities'] = activities;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['slugAr'] = slugAr;
    data['id'] = id;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hours'] = hours;
    data['type'] = type;
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

  Seo({
    this.keywords,
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
    this.canonicalUrl,
  });

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['keywords'] = keywords;
    data['keywordsAr'] = keywordsAr;
    data['priority'] = priority;
    data['changeFrequency'] = changeFrequency;
    data['noIndex'] = noIndex;
    data['noFollow'] = noFollow;
    data['noArchive'] = noArchive;
    data['noSnippet'] = noSnippet;
    data['slugUrl'] = slugUrl;
    data['metaTitle'] = metaTitle;
    data['metaTitleAr'] = metaTitleAr;
    data['metaDescription'] = metaDescription;
    data['metaDescriptionAr'] = metaDescriptionAr;
    data['canonicalUrl'] = canonicalUrl;
    return data;
  }
}
