import 'package:ssk_ruamjai/model/hospital.model.dart';

class DistrictModel {
  DistrictModel({
    this.name,
    this.totalBed,
  });

  District? name;
  int? totalBed;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        name: json["name"] == null ? null : json["name"],
        totalBed: json["total_bed"] == null ? null : json["total_bed"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "total_bed": totalBed == null ? null : totalBed,
      };
}
