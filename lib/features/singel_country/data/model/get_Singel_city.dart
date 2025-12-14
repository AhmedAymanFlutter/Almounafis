// get_single_country.dart
import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart';

class GetSingleCountry {
  String? status;
  CountryData? data;

  GetSingleCountry({this.status, this.data});

  GetSingleCountry.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CountryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}
