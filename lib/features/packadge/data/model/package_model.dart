class PackageModel {
  String? status;
  int? results;
  List<Data>? data;

  PackageModel({this.status, this.results, this.data});

  PackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString(); // Safely convert to string if needed
    results = json['results'];

    if (json['data'] != null) {
      data = <Data>[];
      // Handle data whether it is a List or a Map
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
  String? imageCover; // The parsed URL will be stored here
  List<Destination>? destinations;
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
    this.destinations,
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

    // ✅✅ FIXED IMAGE PARSING LOGIC ✅✅
    // Priority 1: Check nested "images.coverImage.url" (New API Standard)
    if (json['images'] != null && 
        json['images'] is Map && 
        json['images']['coverImage'] != null) {
      imageCover = json['images']['coverImage']['url'];
    }
    // Priority 2: Check "image" object
    else if (json['image'] != null) {
      if (json['image'] is Map) {
        imageCover = json['image']['url'];
      } else if (json['image'] is String) {
        imageCover = json['image'];
      }
    }
    // Priority 3: Check "imageCover" (Old Standard or fallback)
    else if (json['imageCover'] != null) {
      if (json['imageCover'] is Map) {
        imageCover = json['imageCover']['url'];
      } else if (json['imageCover'] is String) {
        imageCover = json['imageCover'];
      }
    }
    // Priority 4: Check "icon"
    else if (json['icon'] != null && json['icon'] is Map) {
      imageCover = json['icon']['url'];
    }

    // Safely parse destinations
    if (json['destinations'] != null && json['destinations'] is List) {
      destinations = <Destination>[];
      json['destinations'].forEach((v) {
        destinations!.add(Destination.fromJson(v));
      });
    }

    alt = json['alt'];
    altAr = json['altAr'];
    createdBy = _parseNameFromObject(json['createdBy']);
    updatedBy = _parseNameFromObject(json['updatedBy']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    id = json['id'];
    
    // Fix Price Parsing if it comes inside 'pricing' object
    if (json['pricing'] != null && json['pricing'] is Map) {
       // Assuming pricing might have a 'amount' or 'price' field, 
       // or if you just want to store the currency/base price.
       // Adjust based on exact pricing structure if needed.
       price = json['pricing']['price'] ?? json['price']; 
    } else {
       price = json['price'];
    }
  }

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
    if (destinations != null) {
      data['destinations'] = destinations!.map((v) => v.toJson()).toList();
    }
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
    metaTitle = json['metaTitle'];
    metaTitleAr = json['metaTitleAr'];
    metaDescription = json['metaDescription'];
    metaDescriptionAr = json['metaDescriptionAr'];
    keywords = _parseList(json['keywords']);
    keywordsAr = _parseList(json['keywordsAr']);
    slugUrl = json['slugUrl'];
  }

  String? _parseList(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.join(', ');
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
    return data;
  }
}

class Destination {
  String? sId;
  String? name;
  String? nameAr;
  String? coverImage;

  Destination({this.sId, this.name, this.nameAr, this.coverImage});

  Destination.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    coverImage = json['coverImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['nameAr'] = nameAr;
    data['coverImage'] = coverImage;
    return data;
  }
}