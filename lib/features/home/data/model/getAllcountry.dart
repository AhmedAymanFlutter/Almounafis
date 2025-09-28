class GetAllcountry {
  bool? success;
  String? message;
  Data? data;
  SeoPage? seoPage;

  GetAllcountry({this.success, this.message, this.data, this.seoPage});

  GetAllcountry.fromJson(Map<String, dynamic> json) {
    print('🔍 Parsing GetAllcountry from JSON...');
    print('JSON keys: ${json.keys}');
    print('JSON data: $json');
    
    success = json['success'];
    message = json['message'];
    
    // Handle the data field - it should contain countries directly
    if (json['data'] != null) {
      print('📊 Data field exists: ${json['data']}');
      print('📊 Data field type: ${json['data'].runtimeType}');
      
      // Check if data is already in the expected format
      if (json['data'] is Map<String, dynamic>) {
        final dataMap = json['data'] as Map<String, dynamic>;
        print('📊 Data map keys: ${dataMap.keys}');
        
        // Create Data object with the countries
        data = Data.fromJson(dataMap);
      }
    }
    
    seoPage = json['seoPage'] != null ? SeoPage.fromJson(json['seoPage']) : null;
    
    print('✅ Parsed GetAllcountry:');
    print('- success: $success');
    print('- message: $message');
    print('- data: $data');
    print('- data.countries length: ${data?.countries?.length}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (seoPage != null) {
      data['seoPage'] = seoPage!.toJson();
    }
    return data;
  }
}

class Data {
  List<Countries>? countries;
  int? total;
  Filters? filters;
  Pagination? pagination;

  Data({this.countries, this.total, this.filters, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    print('🔍 Parsing Data from JSON...');
    print('Data JSON keys: ${json.keys}');
    print('Countries field: ${json['countries']}');
    print('Countries field type: ${json['countries'].runtimeType}');
    print('Countries length: ${json['countries'] is List ? (json['countries'] as List).length : 'Not a List'}');
    
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        try {
          countries!.add(Countries.fromJson(v));
        } catch (e) {
          print('❌ Error parsing country: $e');
          print('Country data: $v');
        }
      });
      print('✅ Parsed ${countries!.length} countries');
    } else {
      print('❌ No countries field found');
    }
    
    total = json['total'];
    filters = json['filters'] != null ? Filters.fromJson(json['filters']) : null;
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    
    print('✅ Data parsing complete:');
    print('- Countries count: ${countries?.length ?? 0}');
    print('- Total: $total');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Countries {
  Images? images;
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
  bool? isPopular;
  int? averageRating;
  int? totalRatings;
  CreatedBy? createdBy;
  List<dynamic>? ratings;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  Countries({
    this.images, this.seo, this.sId, this.name, this.nameAr, this.code,
    this.continent, this.currency, this.language, this.description,
    this.descriptionAr, this.isActive, this.isPopular, this.averageRating,
    this.totalRatings, this.createdBy, this.ratings, this.createdAt,
    this.updatedAt, this.iV, this.id
  });

  Countries.fromJson(Map<String, dynamic> json) {
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
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
    isPopular = json['isPopular'];
    averageRating = json['averageRating'];
    totalRatings = json['totalRatings'];
    createdBy = json['createdBy'] != null ? CreatedBy.fromJson(json['createdBy']) : null;
    
    if (json['ratings'] != null) {
      ratings = <dynamic>[];
      json['ratings'].forEach((v) {
        ratings!.add(v);
      });
    }
    
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (images != null) {
      data['images'] = images!.toJson();
    }
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
    data['isPopular'] = isPopular;
    data['averageRating'] = averageRating;
    data['totalRatings'] = totalRatings;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    if (ratings != null) {
      data['ratings'] = ratings;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}

class Images {
  CoverImage? coverImage;
  List<Gallery>? gallery;

  Images({this.coverImage, this.gallery});

  Images.fromJson(Map<String, dynamic> json) {
    coverImage = json['coverImage'] != null ? CoverImage.fromJson(json['coverImage']) : null;
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (coverImage != null) {
      data['coverImage'] = coverImage!.toJson();
    }
    if (gallery != null) {
      data['gallery'] = gallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallery {
  String? sId;
  String? filename;
  String? originalName;
  String? url;
  String? alt;
  String? altAr;
  String? fullUrl;
  String? thumbnailUrl;
  String? id;

  Gallery({
    this.sId, this.filename, this.originalName, this.url, this.alt,
    this.altAr, this.fullUrl, this.thumbnailUrl, this.id,
  });

  Gallery.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    filename = json['filename'];
    originalName = json['originalName'];
    url = json['url'];
    alt = json['alt'];
    altAr = json['altAr'];
    fullUrl = json['fullUrl'];
    
    // تصحيح: معالجة thumbnailUrl المكرر
    thumbnailUrl = _fixThumbnailUrl(json['thumbnailUrl']);
    
    id = json['id'];
  }

  // دالة لتصحيح thumbnailUrl
  String? _fixThumbnailUrl(String? url) {
    if (url == null) return null;
    
    // إذا كان هناك http://192.168.1.4:5000https:// نقوم بإزالة الجزء الأول
    if (url.contains('http://192.168.1.4:5000https://')) {
      return url.replaceFirst('http://192.168.1.4:5000', '');
    }
    
    return url;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['filename'] = filename;
    data['originalName'] = originalName;
    data['url'] = url;
    data['alt'] = alt;
    data['altAr'] = altAr;
    data['fullUrl'] = fullUrl;
    data['thumbnailUrl'] = thumbnailUrl;
    data['id'] = id;
    return data;
  }
}

class CoverImage {
  Metadata? metadata;
  String? sId;
  String? filename;
  String? originalName;
  String? url;
  String? alt;
  String? altAr;
  String? fullUrl;
  String? thumbnailUrl;
  String? id;

  CoverImage({
    this.metadata, this.sId, this.filename, this.originalName, this.url,
    this.alt, this.altAr, this.fullUrl, this.thumbnailUrl, this.id
  });

  CoverImage.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    sId = json['_id'];
    filename = json['filename'];
    originalName = json['originalName'];
    url = json['url'];
    alt = json['alt'];
    altAr = json['altAr'];
    fullUrl = json['fullUrl'];
    
    // تصحيح: معالجة thumbnailUrl المكرر
    thumbnailUrl = _fixThumbnailUrl(json['thumbnailUrl']);
    
    id = json['id'];
  }

  // دالة لتصحيح thumbnailUrl
  String? _fixThumbnailUrl(String? url) {
    if (url == null) return null;
    
    if (url.contains('http://192.168.1.4:5000https://')) {
      return url.replaceFirst('http://192.168.1.4:5000', '');
    }
    
    return url;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['_id'] = sId;
    data['filename'] = filename;
    data['originalName'] = originalName;
    data['url'] = url;
    data['alt'] = alt;
    data['altAr'] = altAr;
    data['fullUrl'] = fullUrl;
    data['thumbnailUrl'] = thumbnailUrl;
    data['id'] = id;
    return data;
  }
}

class Metadata {
  int? width;
  int? height;
  String? format;
  String? colorSpace;
  bool? hasAlpha;

  Metadata({this.width, this.height, this.format, this.colorSpace, this.hasAlpha});

  Metadata.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    format = json['format'];
    colorSpace = json['colorSpace'];
    hasAlpha = json['hasAlpha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['width'] = width;
    data['height'] = height;
    data['format'] = format;
    data['colorSpace'] = colorSpace;
    data['hasAlpha'] = hasAlpha;
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
  String? ogImage;

  Seo({
    this.metaTitle, this.metaTitleAr, this.metaDescription, this.metaDescriptionAr,
    this.keywords, this.keywordsAr, this.slugUrl, this.priority, this.changeFrequency,
    this.noIndex, this.noFollow, this.noArchive, this.noSnippet, this.ogTitle,
    this.ogDescription, this.ogImage
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
    ogDescription = json['ogDescription'];
    ogImage = json['ogImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['ogImage'] = ogImage;
    return data;
  }
}

class CreatedBy {
  String? sId;
  String? name;
  String? email;

  CreatedBy({this.sId, this.name, this.email});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class Filters {
  Available? available;
  Active? active;

  Filters({this.available, this.active});

  Filters.fromJson(Map<String, dynamic> json) {
    available = json['available'] != null ? Available.fromJson(json['available']) : null;
    active = json['active'] != null ? Active.fromJson(json['active']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (available != null) {
      data['available'] = available!.toJson();
    }
    if (active != null) {
      data['active'] = active!.toJson();
    }
    return data;
  }
}

class Available {
  List<String>? continents;
  List<String>? continentsAr;
  List<SortOptions>? sortOptions;

  Available({this.continents, this.continentsAr, this.sortOptions});

  Available.fromJson(Map<String, dynamic> json) {
    continents = json['continents'].cast<String>();
    continentsAr = json['continentsAr'].cast<String>();
    if (json['sortOptions'] != null) {
      sortOptions = <SortOptions>[];
      json['sortOptions'].forEach((v) {
        sortOptions!.add(SortOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['continents'] = continents;
    data['continentsAr'] = continentsAr;
    if (sortOptions != null) {
      data['sortOptions'] = sortOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SortOptions {
  String? value;
  String? label;
  String? labelAr;
  String? order;

  SortOptions({this.value, this.label, this.labelAr, this.order});

  SortOptions.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
    labelAr = json['labelAr'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['label'] = label;
    data['labelAr'] = labelAr;
    data['order'] = order;
    return data;
  }
}

class Active {
  dynamic continent;
  dynamic search;
  dynamic isPopular;
  dynamic hasPackages;
  dynamic packageType;
  String? sortBy;
  String? sortOrder;

  Active({
    this.continent, this.search, this.isPopular, this.hasPackages,
    this.packageType, this.sortBy, this.sortOrder
  });

  Active.fromJson(Map<String, dynamic> json) {
    continent = json['continent'];
    search = json['search'];
    isPopular = json['isPopular'];
    hasPackages = json['hasPackages'];
    packageType = json['packageType'];
    sortBy = json['sortBy'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['continent'] = continent;
    data['search'] = search;
    data['isPopular'] = isPopular;
    data['hasPackages'] = hasPackages;
    data['packageType'] = packageType;
    data['sortBy'] = sortBy;
    data['sortOrder'] = sortOrder;
    return data;
  }
}

class Pagination {
  int? current;
  int? pages;
  int? total;
  int? limit;

  Pagination({this.current, this.pages, this.total, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    pages = json['pages'];
    total = json['total'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    data['pages'] = pages;
    data['total'] = total;
    data['limit'] = limit;
    return data;
  }
}

class SeoPage {
  Hero? hero;
  Header? header;
  String? sId;
  String? pageKey;
  String? pageName;
  String? pageNameAr;
  String? metaTitle;
  String? metaTitleAr;
  String? metaDescription;
  String? metaDescriptionAr;
  String? keywords;
  String? keywordsAr;
  String? slugUrl;
  String? canonicalUrl;
  bool? isActive;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? updatedBy;

  SeoPage({
    this.hero, this.header, this.sId, this.pageKey, this.pageName, this.pageNameAr,
    this.metaTitle, this.metaTitleAr, this.metaDescription, this.metaDescriptionAr,
    this.keywords, this.keywordsAr, this.slugUrl, this.canonicalUrl, this.isActive,
    this.createdBy, this.createdAt, this.updatedAt, this.iV, this.updatedBy
  });

  SeoPage.fromJson(Map<String, dynamic> json) {
    hero = json['hero'] != null ? Hero.fromJson(json['hero']) : null;
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    sId = json['_id'];
    pageKey = json['pageKey'];
    pageName = json['pageName'];
    pageNameAr = json['pageNameAr'];
    metaTitle = json['metaTitle'];
    metaTitleAr = json['metaTitleAr'];
    metaDescription = json['metaDescription'];
    metaDescriptionAr = json['metaDescriptionAr'];
    keywords = json['keywords'];
    keywordsAr = json['keywordsAr'];
    slugUrl = json['slugUrl'];
    canonicalUrl = json['canonicalUrl'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hero != null) {
      data['hero'] = hero!.toJson();
    }
    if (header != null) {
      data['header'] = header!.toJson();
    }
    data['_id'] = sId;
    data['pageKey'] = pageKey;
    data['pageName'] = pageName;
    data['pageNameAr'] = pageNameAr;
    data['metaTitle'] = metaTitle;
    data['metaTitleAr'] = metaTitleAr;
    data['metaDescription'] = metaDescription;
    data['metaDescriptionAr'] = metaDescriptionAr;
    data['keywords'] = keywords;
    data['keywordsAr'] = keywordsAr;
    data['slugUrl'] = slugUrl;
    data['canonicalUrl'] = canonicalUrl;
    data['isActive'] = isActive;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['updatedBy'] = updatedBy;
    return data;
  }
}

class Hero {
  String? heroTitle;
  String? heroTitleAr;
  String? heroDescription;
  String? heroDescriptionAr;
  String? heroButtonText;
  String? heroButtonTextAr;
  String? heroMobileTitle;
  String? heroMobileTitleAr;
  String? heroMobileSubtitle;
  String? heroMobileSubtitleAr;

  Hero({
    this.heroTitle, this.heroTitleAr, this.heroDescription, this.heroDescriptionAr,
    this.heroButtonText, this.heroButtonTextAr, this.heroMobileTitle,
    this.heroMobileTitleAr, this.heroMobileSubtitle, this.heroMobileSubtitleAr
  });

  Hero.fromJson(Map<String, dynamic> json) {
    heroTitle = json['hero_Title'];
    heroTitleAr = json['hero_TitleAr'];
    heroDescription = json['hero_Description'];
    heroDescriptionAr = json['hero_DescriptionAr'];
    heroButtonText = json['hero_ButtonText'];
    heroButtonTextAr = json['hero_ButtonTextAr'];
    heroMobileTitle = json['hero_MobileTitle'];
    heroMobileTitleAr = json['hero_MobileTitleAr'];
    heroMobileSubtitle = json['hero_MobileSubtitle'];
    heroMobileSubtitleAr = json['hero_MobileSubtitleAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hero_Title'] = heroTitle;
    data['hero_TitleAr'] = heroTitleAr;
    data['hero_Description'] = heroDescription;
    data['hero_DescriptionAr'] = heroDescriptionAr;
    data['hero_ButtonText'] = heroButtonText;
    data['hero_ButtonTextAr'] = heroButtonTextAr;
    data['hero_MobileTitle'] = heroMobileTitle;
    data['hero_MobileTitleAr'] = heroMobileTitleAr;
    data['hero_MobileSubtitle'] = heroMobileSubtitle;
    data['hero_MobileSubtitleAr'] = heroMobileSubtitleAr;
    return data;
  }
}

class Header {
  String? headerTitle;
  String? headerTitleAr;
  String? headerDescription;
  String? headerDescriptionAr;

  Header({this.headerTitle, this.headerTitleAr, this.headerDescription, this.headerDescriptionAr});

  Header.fromJson(Map<String, dynamic> json) {
    headerTitle = json['header_Title'];
    headerTitleAr = json['header_TitleAr'];
    headerDescription = json['header_Description'];
    headerDescriptionAr = json['header_DescriptionAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['header_Title'] = headerTitle;
    data['header_TitleAr'] = headerTitleAr;
    data['header_Description'] = headerDescription;
    data['header_DescriptionAr'] = headerDescriptionAr;
    return data;
  }
}