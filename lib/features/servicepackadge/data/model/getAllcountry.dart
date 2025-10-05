class ServicesModel {
  String? status;
  int? results;
  List<Data>? data;

  ServicesModel({this.status, this.results, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json) {
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
  String? phoneNum;
  String? image;
  String? alt;
  String? altAr;
  String? summary;
  String? summaryAr;
  String? method;
  String? methodAr;
  String? createdBy;
  Null? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? slugAr;
  String? id;

  Data(
      {this.sId,
      this.name,
      this.nameAr,
      this.phoneNum,
      this.image,
      this.alt,
      this.altAr,
      this.summary,
      this.summaryAr,
      this.method,
      this.methodAr,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.slug,
      this.slugAr,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    phoneNum = json['phoneNum'];
    image = json['image'];
    alt = json['alt'];
    altAr = json['altAr'];
    summary = json['summary'];
    summaryAr = json['summaryAr'];
    method = json['method'];
    methodAr = json['methodAr'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    slugAr = json['slugAr'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['phoneNum'] = this.phoneNum;
    data['image'] = this.image;
    data['alt'] = this.alt;
    data['altAr'] = this.altAr;
    data['summary'] = this.summary;
    data['summaryAr'] = this.summaryAr;
    data['method'] = this.method;
    data['methodAr'] = this.methodAr;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['slug'] = this.slug;
    data['slugAr'] = this.slugAr;
    data['id'] = this.id;
    return data;
  }
}