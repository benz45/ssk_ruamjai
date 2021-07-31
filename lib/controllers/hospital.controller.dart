import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssk_ruamjai/data/allHospital.dart';
import 'package:ssk_ruamjai/model/district.model.dart';
import 'package:ssk_ruamjai/model/hospital.model.dart';
import 'package:ssk_ruamjai/model/response.model.dart';

enum GetHospitalResponse { GetHospitalSuccess, GetHospitalBadStatus }

class HospitalController extends GetxController {
  final _allHospital = HospitalModel().obs;
  final _allDistrict = <DistrictModel>[].obs;
  final _isLoading = false.obs;
  final _totalbad = 0.obs;

  // รายการทั้งหมด
  List<Hospital>? get allHospital => _allHospital.value.hospitals;

  // รวมเตียงทั้งหมดภายในอำเภอ
  List<DistrictModel>? get allDistrict => _allDistrict;

  bool get isLoading => _isLoading.value;

  // ดึงจะนวนเตียงทั้งหมดภายในจังหมด
  int get getAllTotalBad => _totalbad.value;

  // ดึงเฉพาะจำนวนเตียงทั้งหมดบางอำเภอ
  int getTotalBadFromDistrict(District? district) {
    return _allDistrict
            .firstWhere((e) => e.name == district,
                orElse: () => DistrictModel())
            .totalBed ??
        0;
  }

  List<Hospital>? getInsideDistrict(District districtUser, {int? sort}) {
    final _data = _allHospital.value.hospitals;
    if (sort == null) {
      return _data?.where((e) => e.district == districtUser).toList();
    }

    return _data
        ?.where((e) => e.district == districtUser && e.type == sort + 1)
        .toList();
  }

  // Get all type hospital
  Map<String, String> getAllHospitalType() {
    return hospitalType;
  }

  // Get type hospital from name string
  int? getHospitalTypeFromString(String value) {
    final result = hospitalType.keys.firstWhere(
      (element) => hospitalType[element] == value,
      orElse: () => '',
    );
    if (result != '') {
      return int.parse(result);
    }
    return null;
  }

  // Get type hospital
  String? getHospitalType(int index) {
    return hospitalType.values.elementAt(index - 1);
  }

  @override
  void onInit() async {
    super.onInit();
    final token = GetStorage().read('token');
    if (token != null) {
      await getHospital(token);
    }
  }

  // Get hospital
  Future<Res> getHospital(String token) async {
    try {
      _isLoading.value = true;
      // var url = Uri.parse('${dotenv.env['API_GET_HOSPITAL']}');
      // var response = await http.get(url, headers: {
      //   "Content-Type": "application/json; charset=utf-8",
      //   "Authorization": "Token $token"
      // });

      // if (response.statusCode != 200) {
      //   _isLoading.value = false;
      //   return Res(
      //     status: false,
      //     message: "${GetHospitalResponse.GetHospitalBadStatus}",
      //   );
      // }

      // final responseJson = await json.decode(utf8.decode(response.bodyBytes));

      // ! Test
      final responseJson = await json.decode(jsonEncode(allHospitalData));

      final jsonToRes = await Res.fromJson(responseJson).data;
      final hospitalModel = HospitalModel.fromJson(jsonToRes);
      final hospitals = hospitalModel.hospitals;

      // * เรียงตาจำนวนเตียงที่มากที่สุด
      hospitals?.sort((a, b) => b.totalBed!.compareTo(a.totalBed!));
      _allHospital.value = hospitalModel;

      // * รวมจำนวนเตียงทั้งหมดของแต่ละอำเภอ
      // กรองรายชื่ออำเภอทั้งหมดที่ฐานข้อมูล
      var nameDistrict = [
        for (var i = 0; i < hospitals!.length; i++) hospitals[i].district
      ].toSet().toList();

      var resultDistricts = <DistrictModel>[];
      var resultTotalBads = <int>[];

      // รวมจำเตียงทั้งหมดภายในแต่ละอำเภอ
      for (var i = 0; i < nameDistrict.length; i++) {
        final totalBed = hospitals
            .where((e) => e.district == nameDistrict[i])
            .toList()
            .fold<int>(0, (sum, next) => sum + next.totalBed!);

        final putIntoModel =
            DistrictModel(name: nameDistrict[i], totalBed: totalBed);

        resultTotalBads.add(totalBed);
        resultDistricts.add(putIntoModel);
      }

      // รวมจำรวมเตียงทั้งหมดภายใน result total bad
      final _resultTotalBad =
          resultTotalBads.fold<int>(0, (sum, next) => sum + next);

      // เรียงอำเภอตามจำนวนเตียงที่มากที่สุด
      resultDistricts.sort((a, b) => b.totalBed!.compareTo(a.totalBed!));

      _allDistrict.value = resultDistricts;
      _totalbad.value = _resultTotalBad;

      _isLoading.value = false;
      return Res(
        status: true,
        message: "${GetHospitalResponse.GetHospitalSuccess}",
      );
    } catch (err) {
      _isLoading.value = false;
      print(err);
      return Res(status: false, message: "${err.toString()}");
    }
  }
}
