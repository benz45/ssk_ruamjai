class HospitalModel {
  HospitalModel({
    this.hospitals,
  });

  List<Hospital>? hospitals;

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
        hospitals: json["hospitals"] == null
            ? null
            : List<Hospital>.from(
                json["hospitals"].map((x) => Hospital.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hospitals": hospitals == null
            ? null
            : List<dynamic>.from(hospitals!.map((x) => x.toJson())),
      };
}

class Hospital {
  Hospital({
    this.id,
    this.name,
    this.type,
    this.totalBed,
    this.district,
    this.staff,
  });

  int? id;
  String? name;
  int? type;
  int? totalBed;
  District? district;
  List<dynamic>? staff;

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        totalBed: json["total_bed"] == null ? null : json["total_bed"],
        district: json["district"] == null
            ? null
            : districtValues.map?[json["district"]],
        staff: json["staff"] == null
            ? null
            : List<dynamic>.from(json["staff"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "total_bed": totalBed == null ? null : totalBed,
        "district": district == null ? null : districtValues.reverse![district],
        "staff":
            staff == null ? null : List<dynamic>.from(staff!.map((x) => x)),
      };
}

enum District {
  Kantharalak,
  Kanthararom,
  Khukhan,
  KhunHan,
  NamKliang,
  NonKhun,
  BuengBun,
  Benchalak,
  PrangKu,
  Phayu,
  PhoSiSuwan,
  PhraiBueng,
  PhuSing,
  MueangChan,
  MueangSiSaKet,
  YangChumNoi,
  RasiSalai,
  WangHin,
  SiRattana,
  SilaLat,
  HuaiThapThan,
  UthumphonPhisai,
}

final districtValues = EnumValues({
  "??????????????????????????????": District.Kanthararom,
  "??????????????????": District.NonKhun,
  "?????????????????????????????????": District.MueangChan,
  "?????????????????????": District.RasiSalai,
  "???????????????": District.MueangSiSaKet,
  "??????????????????????????????": District.Kantharalak,
  "????????????????????????????????????": District.UthumphonPhisai,
  "???????????????????????????": District.Benchalak,
  "?????????????????????": District.PhuSing,
  "???????????????????????????": District.PrangKu,
  "??????????????????": District.PhraiBueng,
  "?????????????????????": District.Khukhan,
  "??????????????????????????????????????????": District.PhoSiSuwan,
  "???????????????": District.Phayu,
  "??????????????????????????????": District.YangChumNoi,
  "??????????????????": District.KhunHan,
  "????????????????????????": District.BuengBun,
  "??????????????????????????????": District.HuaiThapThan,
  "????????????????????????": District.SiRattana,
  "?????????????????????": District.SilaLat,
  "??????????????????????????????": District.NamKliang,
  "??????????????????": District.WangHin
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map?.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

final hospitalType = {
  "0": '????????????????????????????????????????????????????????????',
  "1": '???????????????????????????????????????????????????????????????',
  "2": '??????.??????????????????????????????????????????',
  "3": '?????????????????????????????????????????????????????????',
  "4": '???????????????????????????????????????????????????????????????',
  "5": 'Hospitel',
};
