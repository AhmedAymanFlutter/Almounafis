class AirlineModel {
  String? status;
  int? results;
  List<Data>? data;

  AirlineModel({this.status, this.results, this.data});

  AirlineModel.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.sId,
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
      this.updatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    alt = json['alt'];
    altAr = json['altAr'];
    id = json['id'];
    image = json['image'];
    updatedBy = json['updatedBy'];
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