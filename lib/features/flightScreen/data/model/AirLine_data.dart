class AirLineModel {
  String? status;
  int? results;
  List<AirLineData>? data;

  AirLineModel({this.status, this.results, this.data});

  AirLineModel.fromJson(Map<String, dynamic> json) {
    // Some APIs return 'status' as boolean or string, handling safely is good but let's stick to existing type if known
    // Based on log: "success":true. The model has String? status.
    // If 'success' is the status indicator, we might want to map it, but 'status' field might be separate.
    // Let's just fix the data parsing structure first.

    if (json['data'] != null) {
      data = <AirLineData>[];
      if (json['data'] is List) {
        json['data'].forEach((v) {
          data!.add(AirLineData.fromJson(v));
        });
      } else if (json['data'] is Map && json['data']['airlines'] != null) {
        json['data']['airlines'].forEach((v) {
          data!.add(AirLineData.fromJson(v));
        });
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

class AirLineData {
  String? sId;
  String? name;
  String? nameAr;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? slugAr;
  String? alt;
  String? altAr;
  String? id;
  String? image;
  String? updatedBy;

  AirLineData({
    this.sId,
    this.name,
    this.nameAr,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.slugAr,
    this.alt,
    this.altAr,
    this.id,
    this.image,
    this.updatedBy,
  });

  AirLineData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    createdBy = _parseStringOrMap(json['createdBy']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    alt = json['alt'];
    altAr = json['altAr'];
    id = json['id'];

    // ✅ Handle image object or string
    if (json['image'] is Map) {
      image = json['image']['url'];
    } else {
      image = json['image'];
    }

    updatedBy = _parseStringOrMap(json['updatedBy']);
  }

  String? _parseStringOrMap(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map) return value['name'] ?? value['username'] ?? value['_id'];
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['slug'] = this.slug;
    data['slugAr'] = this.slugAr;
    data['alt'] = this.alt;
    data['altAr'] = this.altAr;
    data['id'] = this.id;
    data['image'] = this.image;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}

class FlightFilter {
  String? airline;
  String? passengerCount;
  String? travelClass;
  double? minPrice;
  double? maxPrice;
  String? departureTime;
  String? arrivalTime;

  FlightFilter({
    this.airline,
    this.passengerCount,
    this.travelClass,
    this.minPrice,
    this.maxPrice,
    this.departureTime,
    this.arrivalTime,
  });

  FlightFilter copyWith({
    String? airline,
    String? passengerCount,
    String? travelClass,
    double? minPrice,
    double? maxPrice,
    String? departureTime,
    String? arrivalTime,
  }) {
    return FlightFilter(
      airline: airline ?? this.airline,
      passengerCount: passengerCount ?? this.passengerCount,
      travelClass: travelClass ?? this.travelClass,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
    );
  }

  bool get hasActiveFilters {
    return airline != null ||
        passengerCount != null ||
        travelClass != null ||
        minPrice != null ||
        maxPrice != null ||
        departureTime != null ||
        arrivalTime != null;
  }

  @override
  String toString() {
    return 'FlightFilter(airline: $airline, passengerCount: $passengerCount, travelClass: $travelClass)';
  }
}
