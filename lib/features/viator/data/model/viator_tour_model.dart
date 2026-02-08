class ViatorTourResponse {
  bool? success;
  String? source;
  int? count;
  int? total;
  Pagination? pagination;
  List<ViatorTour>? tours;

  ViatorTourResponse({
    this.success,
    this.source,
    this.count,
    this.total,
    this.pagination,
    this.tours,
  });

  ViatorTourResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    source = json['source'];
    count = json['count'];
    total = json['total'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['tours'] != null) {
      tours = <ViatorTour>[];
      json['tours'].forEach((v) {
        tours!.add(ViatorTour.fromJson(v));
      });
    }
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? limit;

  Pagination({this.currentPage, this.totalPages, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    limit = json['limit'];
  }
}

class ViatorTour {
  String? sId;
  String? productCode;
  String? title;
  String? titleAr; // Adding support for potential localization
  String? description;
  String? descriptionAr; // Adding support for potential localization
  Rating? rating;
  City? city;
  Price? price;
  String? coverImage;
  CancellationPolicy? cancellationPolicy;
  String? slug;

  ViatorTour({
    this.sId,
    this.productCode,
    this.title,
    this.titleAr,
    this.description,
    this.descriptionAr,
    this.rating,
    this.city,
    this.price,
    this.coverImage,
    this.cancellationPolicy,
    this.slug,
  });

  ViatorTour.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productCode = json['productCode'];
    title = json['title'];
    titleAr = json['titleAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    coverImage = json['coverImage'];
    cancellationPolicy = json['cancellationPolicy'] != null
        ? CancellationPolicy.fromJson(json['cancellationPolicy'])
        : null;
    slug = json['slug'];
  }
}

class Rating {
  num? average;
  int? count;

  Rating({this.average, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    count = json['count'];
  }
}

class City {
  String? name;
  String? slug;

  City({this.name, this.slug});

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
  }
}

class Price {
  num? amount;
  String? currency;

  Price({this.amount, this.currency});

  Price.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }
}

class CancellationPolicy {
  String? type;
  String? description;

  CancellationPolicy({this.type, this.description});

  CancellationPolicy.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
  }
}
