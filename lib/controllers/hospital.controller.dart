import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssk_ruamjai/model/district.model.dart';
import 'package:ssk_ruamjai/model/hospital.model.dart';
import 'package:ssk_ruamjai/model/response.model.dart';

enum GetHospitalResponse { GetHospitalSuccess, GetHospitalBadStatus }

class HospitalController extends GetxController {
  final _allHospital = HospitalModel().obs;
  final _allDistrict = <DistrictModel>[].obs;
  final _isLoading = false.obs;

  List<Hospital>? get allHospital => _allHospital.value.hospitals;
  List<DistrictModel>? get allDistrict => _allDistrict;
  bool get isLoading => _isLoading.value;

  List<Hospital>? getInsideDistrict(District districtUser) {
    return _allHospital.value.hospitals
        ?.where((e) => e.district == districtUser)
        .toList();
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
      final responseJson = await json.decode(jsonEncode(_data));

      final jsonToRes = await Res.fromJson(responseJson).data;
      final hospitalModel = HospitalModel.fromJson(jsonToRes);
      final hospitals = hospitalModel.hospitals;

      // * เรียงตาจำนวนเตียงที่มากที่สุด
      hospitals?.sort((a, b) => b.totalBed!.compareTo(a.totalBed!));
      _allHospital.value = hospitalModel;

      // * รวมจำนวนเตียงทั้งหมดของแต่ละอำเภอ
      var nameDistrict = [
        for (var i = 0; i < hospitals!.length; i++) hospitals[i].district
      ].toSet().toList();
      var resultDistrict = <DistrictModel>[];
      for (var i = 0; i < nameDistrict.length; i++) {
        var totalBed = hospitals
            .where((e) => e.district == nameDistrict[i])
            .toList()
            .fold<int>(0, (sum, next) => sum + next.totalBed!);
        resultDistrict
            .add(DistrictModel(name: nameDistrict[i], totalBed: totalBed));
      }
      resultDistrict.sort((a, b) => b.totalBed!.compareTo(a.totalBed!));
      _allDistrict.value = resultDistrict;

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

final _data = {
  "status": true,
  "message": "already get hospital",
  "data": {
    "hospitals": [
      {
        "id": 5,
        "name": "โรงพยาบาลศรีสะเกษ",
        "type": 4,
        "total_bed": 69,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 6,
        "name": "โรงพยาบาลราษีไศล",
        "type": 3,
        "total_bed": 70,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 7,
        "name": "โรงพยาบาลโพธิ์ศรีสุวรรณ",
        "type": 3,
        "total_bed": 24,
        "district": "โพธิ์ศรีสุวรรณ",
        "staff": []
      },
      {
        "id": 8,
        "name": "โรงพยาบาลกันทรลักษ์",
        "type": 3,
        "total_bed": 24,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 9,
        "name": "โรงพยาบาลยางชุมน้อย",
        "type": 3,
        "total_bed": 22,
        "district": "ยางชุมน้อย",
        "staff": []
      },
      {
        "id": 10,
        "name": "โรงพยาบาลพยุห์",
        "type": 3,
        "total_bed": 25,
        "district": "พยุห์",
        "staff": []
      },
      {
        "id": 11,
        "name": "โรงพยาบาลปรางค์กู่",
        "type": 3,
        "total_bed": 22,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 12,
        "name": "โรงพยาบาลภูสิงห์",
        "type": 3,
        "total_bed": 22,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 13,
        "name": "โรงพยาบาลเบญจลักษ์",
        "type": 3,
        "total_bed": 21,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 14,
        "name": "โรงพยาบาลกันทรารมย์",
        "type": 3,
        "total_bed": 20,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 15,
        "name": "โรงพยาบาลเมืองจันทร์",
        "type": 3,
        "total_bed": 18,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 16,
        "name": "โรงพยาบาลไพรบึง",
        "type": 3,
        "total_bed": 18,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 17,
        "name": "โรงพยาบาลอุทุมพร",
        "type": 3,
        "total_bed": 21,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 19,
        "name": "โรงพยาบาลขุขันธ์",
        "type": 3,
        "total_bed": 18,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 20,
        "name": "โรงพยาบาลโนนคูณ",
        "type": 3,
        "total_bed": 16,
        "district": "โนนคูณ",
        "staff": []
      },
      {
        "id": 21,
        "name": "โรงพยาบาลขุนหาญ",
        "type": 3,
        "total_bed": 14,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 22,
        "name": "โรงพยาบาลบึงบูรพ์",
        "type": 3,
        "total_bed": 10,
        "district": "บึงบูรพ์",
        "staff": []
      },
      {
        "id": 23,
        "name": "โรงพยาบาลห้วยทับทัน",
        "type": 3,
        "total_bed": 18,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 24,
        "name": "โรงพยาบาลศรีรัตนะ",
        "type": 3,
        "total_bed": 4,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 25,
        "name": "โรงพยาบาลศิลาลาด",
        "type": 3,
        "total_bed": 2,
        "district": "ศิลาลาด",
        "staff": []
      },
      {
        "id": 26,
        "name": "โรงพยาบาลน้ำเกลี้ยง",
        "type": 3,
        "total_bed": 4,
        "district": "น้ำเกลี้ยง",
        "staff": []
      },
      {
        "id": 27,
        "name": "โรงพยาบาลวังหิน",
        "type": 3,
        "total_bed": 2,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 28,
        "name": "Hospitel โรงแรมพรหมพิมาน",
        "type": 5,
        "total_bed": 222,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 293,
        "name": "กองร้อย อส.",
        "type": 1,
        "total_bed": 60,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 294,
        "name": "หอประชุม อบต.คำเนียม",
        "type": 1,
        "total_bed": 20,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 295,
        "name": "โรงปุ๋ย (เดิม)  อบต.หนองหัวช้าง",
        "type": 1,
        "total_bed": 20,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 296,
        "name": "อาคารที่พักสงฆ์หนองบอน บ้านดู่  ต.จาน",
        "type": 1,
        "total_bed": 10,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 297,
        "name": "สถานีสูบน้ำ อบต.ละทาย (บ้านหนองเรือ)",
        "type": 1,
        "total_bed": 10,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 298,
        "name":
            "ศูนย์เรียนรู้ปรัชญาเศรษฐกิจพอเพียง(ศาลาวัฒนธรรม) วัดจำปาต.หนองแก้ว",
        "type": 1,
        "total_bed": 20,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 299,
        "name": "หอประชุม อบต.เมืองน้อย",
        "type": 1,
        "total_bed": 20,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 300,
        "name": "ตลาดนัดหนองข่า ม.1 ต.อีปาด",
        "type": 1,
        "total_bed": 10,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 301,
        "name": "อาคารโรงยิมโรงเรียนหนองถ่มวิทยา ต.ดู่",
        "type": 1,
        "total_bed": 60,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 302,
        "name": "ศาลาวัดบ้านดู่  ต.ดู่",
        "type": 1,
        "total_bed": 10,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 303,
        "name": "ศูนย์พัฒนาเด็กเล็กตำบลยาง ม.7 ต.ยาง",
        "type": 1,
        "total_bed": 20,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 304,
        "name": "บ้านสวนเอกชน  ม.1 ต.หนองแวง",
        "type": 1,
        "total_bed": 10,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 305,
        "name": "หอประชุม อบต.ทาม  ต.ทาม",
        "type": 1,
        "total_bed": 20,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 306,
        "name": "ศูนย์พัฒนาคุณภาพชีวิตผู้สูงอายุ รพ.สต.พันลำ ต.บัวน้อย",
        "type": 1,
        "total_bed": 10,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 307,
        "name": "สำนักปฏิบัติธรรมบ้านท่าช้าง ม.4 ต.หนองบัว",
        "type": 1,
        "total_bed": 10,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 308,
        "name": "ศูนย์พัฒนาคุณภาพผู้สูงอายุตำบลยางชุมน้อย",
        "type": 1,
        "total_bed": 12,
        "district": "ยางชุมน้อย",
        "staff": []
      },
      {
        "id": 309,
        "name": "โกดังเขินวัสดุบ้านสบาย ต.รุ่งระวี",
        "type": 1,
        "total_bed": 40,
        "district": "น้ำเกลี้ยง",
        "staff": []
      },
      {
        "id": 310,
        "name": "อาคารปฏิบัติธรรมวัดป่าดงบก ต.เขิน",
        "type": 1,
        "total_bed": 25,
        "district": "น้ำเกลี้ยง",
        "staff": []
      },
      {
        "id": 311,
        "name": "ศูนย์ชมรมผู้สูงอายุ ต.ละเอาะ",
        "type": 1,
        "total_bed": 10,
        "district": "น้ำเกลี้ยง",
        "staff": []
      },
      {
        "id": 312,
        "name": "ศูนย์พัฒนาเด็กเล็ก อบต.ตองปิด",
        "type": 1,
        "total_bed": 10,
        "district": "น้ำเกลี้ยง",
        "staff": []
      },
      {
        "id": 313,
        "name": "ที่พักสงฆ์ฮ่องโดม ต.คูบ",
        "type": 1,
        "total_bed": 12,
        "district": "น้ำเกลี้ยง",
        "staff": []
      },
      {
        "id": 314,
        "name": "หอประชุมโรงเรียนน้ำเกลี้ยงวิทยา ต.น้ำเกลี้ยง",
        "type": 1,
        "total_bed": 10,
        "district": "น้ำเกลี้ยง",
        "staff": []
      },
      {
        "id": 315,
        "name": "อาคารโรงเรียนผู้สูงอายุเทศบาลต.พยุห์ ม.1 ต.พยุห์",
        "type": 1,
        "total_bed": 10,
        "district": "พยุห์",
        "staff": []
      },
      {
        "id": 316,
        "name": "อาคารโรงเรียนมัธยมบ้านตำแยหนองเม็ก  ม.1 ต.ตำแย",
        "type": 1,
        "total_bed": 20,
        "district": "พยุห์",
        "staff": []
      },
      {
        "id": 317,
        "name": "ศาลาเอนกประสงค์บ้านกระหวัน  ม.5 ต.พรหมสวัสดิ์",
        "type": 1,
        "total_bed": 20,
        "district": "พยุห์",
        "staff": []
      },
      {
        "id": 318,
        "name": "ศูนย์ถ่ายทอดเทคโนโลยีการเกษตร ต.โนนเพ็ก",
        "type": 1,
        "total_bed": 15,
        "district": "พยุห์",
        "staff": []
      },
      {
        "id": 319,
        "name": "อาคารห้องประชุม อบต.หนองค้า ต.หนองค้า",
        "type": 1,
        "total_bed": 30,
        "district": "พยุห์",
        "staff": []
      },
      {
        "id": 320,
        "name": "อาคารอเนกประสงค์สวนน้อมเกล้าฯครองราชย์60 ปี ต.บุสูง",
        "type": 1,
        "total_bed": 20,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 321,
        "name": "หอประชุมอำเภอ (หลังเก่า)",
        "type": 1,
        "total_bed": 30,
        "district": "โนนคูณ",
        "staff": []
      },
      {
        "id": 322,
        "name": "อาคารเอนกประสงค์ อ.ราษีไศล",
        "type": 1,
        "total_bed": 40,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 323,
        "name": "หอประชุมที่ว่าการ อ.บึงบูรพ์(หลังเก่า)",
        "type": 1,
        "total_bed": 20,
        "district": "บึงบูรพ์",
        "staff": []
      },
      {
        "id": 324,
        "name": "OTOP ต.ห้วยทับทัน",
        "type": 1,
        "total_bed": 15,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 325,
        "name": "ศูนย์ปฏบัติธรรมหนองอี่หล่ม ต.แข้",
        "type": 1,
        "total_bed": 8,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 326,
        "name": "บ้านพัก จนท.ปะปา อบต.แข้",
        "type": 1,
        "total_bed": 5,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 327,
        "name": "อาคาร อบต.หลังเก่า ต.ทุ่งไชย",
        "type": 1,
        "total_bed": 5,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 328,
        "name": "ที่พักสงฆ์สำนักสงฆ์ดงตานอ  ต.แขม",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 329,
        "name": "ที่พักสงฆ์สิริมงคล ม.6 ต.แขม",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 330,
        "name": "วัดป่าเทพนิมิตร ม.7 ต.แขม",
        "type": 1,
        "total_bed": 20,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 331,
        "name": "ศาลาประชาคม ม.9 ต.แขม",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 332,
        "name": "หอประชุมเทศบาลตำบลกำแพง",
        "type": 1,
        "total_bed": 30,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 333,
        "name": "ศูนย์พัฒนาเด็กหลังเก่า ม.3 ต.โคกจาน",
        "type": 1,
        "total_bed": 12,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 334,
        "name": "ศาลาวัดบ้านนานวน ต.โคกหล่าม",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 335,
        "name": "พุทธวิหาร วัดสระกำแพงใหญ่",
        "type": 1,
        "total_bed": 30,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 336,
        "name": "สำนักสงฆ์หนองโน ม.10 ต.ปะอาว",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 337,
        "name": "ศาลาวัดป่า บ้านโนนกอง ม.10 ต.โพธิชัย",
        "type": 1,
        "total_bed": 20,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 338,
        "name": "ศูนย์พัฒนาเด็กเล็กตำบลแต้ (หลังเก่า)",
        "type": 1,
        "total_bed": 6,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 339,
        "name": "อบต.หลังเก่า  ต.รังแร้ง",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 340,
        "name": "ร.ร.บ้านหนองลุง ต.ตาเกษ",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 341,
        "name": "วัดป่าตาล  ต.ขะยูง",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 342,
        "name": "อาคารองค์การบริหารส่วนตำบลหนองไฮ (หลังเก่า )",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 343,
        "name": "ลานสนาม อบต.ก้านเหลือง",
        "type": 1,
        "total_bed": 16,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 344,
        "name": "วัดบ้านกอก ม.6 ต.หัวช้าง",
        "type": 1,
        "total_bed": 6,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 345,
        "name": "ศพด.บ้านหนองหญ้าปล้อง  ต.หนองห้าง",
        "type": 1,
        "total_bed": 5,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 346,
        "name": "ศูนย์พัฒนาเด็กเล็กหลังเก่า ม.11  ต.อีหล่ำ",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 347,
        "name": "ศาลาปฏิบัติธรรมวัดศรีอุทุมพร  ต.สำโรง",
        "type": 1,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 348,
        "name": "ศาลาวัดบ้านปลาซิว",
        "type": 1,
        "total_bed": 15,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 349,
        "name": "หอประชุมเก่า อ.เมืองจันทร์",
        "type": 1,
        "total_bed": 15,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 350,
        "name": "ศูนย์นิเวศน์ป่าชุมชนโนนใหญ่",
        "type": 1,
        "total_bed": 40,
        "district": "โพธิ์ศรีสุวรรณ",
        "staff": []
      },
      {
        "id": 351,
        "name": "หอประชุมที่ว่าการ อ.ศิลาลาด",
        "type": 1,
        "total_bed": 20,
        "district": "ศิลาลาด",
        "staff": []
      },
      {
        "id": 352,
        "name": "ศูนย์ผู้สูงอายุหลังเก่า ต.กฤษณา",
        "type": 1,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 353,
        "name": "วัดโคกเพชร  ต.โคกเพชร",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 354,
        "name": "ศูนย์พัฒนาเด็กก่อนเกณฑ์ (วัดโสภณวิหาร)ต.กันทรารมย์",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 355,
        "name": "อาคารสำนักงาน(หลังเก่า) ต.จะกง",
        "type": 1,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 356,
        "name": "วัดบ้านใจดี  ต.ใจดี",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 357,
        "name": "ศาลาวัดบ้านดองกำเม็ด  ต.ดองกำเม็ด",
        "type": 1,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 358,
        "name": "รพ.สต. (หลังเก่า) ต.ตะเคียน",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 359,
        "name": "ศูนย์พัฒนาเด็กเล็ก บ้านตาอุดใต้ (หลังเก่า) ต.ตาอุด",
        "type": 1,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 360,
        "name": "อาคารอเนกประสงค์สนามกีฬา อบต.นิคมพัฒนา",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 361,
        "name": "ห้องประชุม อบต.ปราสาท",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 362,
        "name": "อาคารประชุมสภาอบต.ปรือใหญ่ (หลังเก่า)",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 363,
        "name": "สำนักงาน อบต.ลมศักดิ์ (หลังเก่า)",
        "type": 1,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 364,
        "name": "สำนักสงฆ์สนวนไตรสามัคคี  ต.ศรีตระกูล",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 365,
        "name": "กศน. ต.ศรีสะอาด",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 366,
        "name": "หอประชุมอเนกประสงค์(อบต.) ต.สะเดาใหญ่",
        "type": 1,
        "total_bed": 7,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 367,
        "name": "อาคารอเนกประสงค์ อบต.สำโรงตาเจ็น",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 368,
        "name": "กศน.ตำบลโสน (หลังเก่า)",
        "type": 1,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 369,
        "name": "ศาลาประชาคมบ้านนิคมหนองฉลอง หมู่ที่ 9 ต.หนองฉลอง",
        "type": 1,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 370,
        "name": "อาคารอเนกประสงค์อบต.ห้วยใต้",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 371,
        "name": "รพ.สต. บ้านนาก็อก (หลังเก่า) ต.ห้วยสำราญ",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 425,
        "name": "โรงเรียนผู้สูงอายุ ทต.ขุนหาญ ต.สิ",
        "type": 2,
        "total_bed": 24,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 372,
        "name": "วัดเขียนบูรพา​ราม (อาคารปฏิบัติธรรม ) ต.ห้วยเหนือ",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 373,
        "name": "ศาลาอเนกประสงค์ อบต.หัวเสือ",
        "type": 1,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 374,
        "name": "อาคารเอนกประสงค์สุนีย์ อินฉัตร",
        "type": 1,
        "total_bed": 24,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 375,
        "name": "สำนักสงฆ์อริยทรัพย์  เทศบาลตำบลไพรบึง",
        "type": 1,
        "total_bed": 30,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 376,
        "name": "ห้องประชุม อบต.ปราสาทเยอ ต.ปราสาทเยอ",
        "type": 1,
        "total_bed": 10,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 377,
        "name": "ศูนย์พัฒนาเด็กเล็ก บ้านหัวช้าง  ต.สำโรงพลัน",
        "type": 1,
        "total_bed": 10,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 378,
        "name": "อาคาร กศน.ตำบลสุขสวัสดิ์",
        "type": 1,
        "total_bed": 10,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 379,
        "name": "ศูนย์พัฒนาเด็กเล็ก  ต.ดินแดง",
        "type": 1,
        "total_bed": 10,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 380,
        "name": "อาคารอ่างเก็บน้ำห้วยศาลา  ต.โคกตาล",
        "type": 1,
        "total_bed": 40,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 381,
        "name": "สถานีตำรวจภูธรบึงมะลู(สาขาผามออีแดง)ต.เสาธงชัย",
        "type": 1,
        "total_bed": 70,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 382,
        "name": "ศูนย์เด็กเล็กบ้านตูม  ต.ตูม",
        "type": 1,
        "total_bed": 40,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 383,
        "name": "รร.บ้านตูม  ต.ตูม",
        "type": 1,
        "total_bed": 40,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 384,
        "name": "รร.ศรีแก้วพิทยา  ต.ศรีแก้ว",
        "type": 1,
        "total_bed": 40,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 385,
        "name": "อาคารเก่า รพ.สต.พิงพวย",
        "type": 1,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 386,
        "name": "สำนักงาน ส.อบจ.นริตา ไตรสรณกุล ต.สระเยาว์",
        "type": 1,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 387,
        "name": "ศูนย์เด็กเล็กบ้านเสื่องข้าว ต.เสื่องข้าว",
        "type": 1,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 388,
        "name": "ศูนย์เด็กเล็กบ้านศรีโนนงาม  ต.ศรีโนนงาม",
        "type": 1,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 389,
        "name": "ศูนย์เด็กเล็กบ้านจอก  ต.สะพุง",
        "type": 1,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 390,
        "name": "องค์การบริหารส่วนตำบลสระเยาว์  ต.สระเยาว์",
        "type": 1,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 391,
        "name": "อาคาร สสอ.",
        "type": 1,
        "total_bed": 20,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 392,
        "name": "อาคารประชุมเทศบาลตำบลขุนหาญ ต.โพธิ์กระสังข์",
        "type": 1,
        "total_bed": 10,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 393,
        "name": "ศูนย์ฝึกอาชีพตำบลกระหวัน",
        "type": 1,
        "total_bed": 50,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 394,
        "name": "ศาลาเอนกประสงค์บ้านกระเบา ม.4 ต.โนนสูง",
        "type": 1,
        "total_bed": 10,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 395,
        "name": "กุฎิวัดป่าประชาสามัคคี ม.9 ต.ขุนหาญ",
        "type": 1,
        "total_bed": 10,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 396,
        "name": "อาคารเอนกประสงค์ อบต.พราน ม.2",
        "type": 1,
        "total_bed": 20,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 397,
        "name": "กุฎิวัดโพธิ์วงศ์ม.1  ต.โพธิ์วงศ์",
        "type": 1,
        "total_bed": 3,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 398,
        "name": "วัดกระมัลพัฒนา ม.6  ต.โพธิ์วงศ์",
        "type": 1,
        "total_bed": 4,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 399,
        "name": "วัดกระมัล  ม. 3 ต.โพธิ์วงศ์",
        "type": 1,
        "total_bed": 10,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 400,
        "name": "วัดกุดนาแก้ว ต.ภูฝ้าย",
        "type": 1,
        "total_bed": 6,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 401,
        "name": "กองร้อย อส.",
        "type": 2,
        "total_bed": 60,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 402,
        "name": "อาคารวีสมหมาย",
        "type": 2,
        "total_bed": 154,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 403,
        "name": "หอประชุมที่ว่าการอำเภอ",
        "type": 2,
        "total_bed": 80,
        "district": "กันทรารมย์",
        "staff": []
      },
      {
        "id": 404,
        "name": "หอประชุมที่ว่าการอำเภอยางชุมน้อย",
        "type": 2,
        "total_bed": 40,
        "district": "ยางชุมน้อย",
        "staff": []
      },
      {
        "id": 405,
        "name": "หอประชุม รร.น้ำเกลี้ยงวิทยา",
        "type": 2,
        "total_bed": 56,
        "district": "น้ำเกลี้ยง",
        "staff": []
      },
      {
        "id": 406,
        "name": "รพ.สต.พยุห์( สสอ.เก่า)",
        "type": 2,
        "total_bed": 50,
        "district": "พยุห์",
        "staff": []
      },
      {
        "id": 407,
        "name": "อาคารโดม อบต.พรหมสวัสดิ์",
        "type": 2,
        "total_bed": 60,
        "district": "พยุห์",
        "staff": []
      },
      {
        "id": 408,
        "name": "อาคารเอนกประสงค์โรงเรียนนครศรีลำดวนวิทยา",
        "type": 2,
        "total_bed": 40,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 409,
        "name": "หอประชุมอำเภอโนนคูณ",
        "type": 2,
        "total_bed": 20,
        "district": "โนนคูณ",
        "staff": []
      },
      {
        "id": 410,
        "name": "หอประชุมที่ว่าการอำเภอราษีไศล",
        "type": 2,
        "total_bed": 60,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 411,
        "name": "หอประชุมที่ว่าการอำเภอ(หลังใหม่)",
        "type": 2,
        "total_bed": 30,
        "district": "บึงบูรพ์",
        "staff": []
      },
      {
        "id": 412,
        "name": "หอประชุมที่ว่าการอำเภอ",
        "type": 2,
        "total_bed": 40,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 413,
        "name": "วัดสระกำแพงใหญ่",
        "type": 2,
        "total_bed": 100,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 414,
        "name": "หอประชุมที่ว่าการอำเภอ",
        "type": 2,
        "total_bed": 30,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 415,
        "name": "วัดป่าไผ่สามัคคี",
        "type": 2,
        "total_bed": 60,
        "district": "โพธิ์ศรีสุวรรณ",
        "staff": []
      },
      {
        "id": 416,
        "name": "หอประชุมที่ว่าการอำเภอศิลาลาด",
        "type": 2,
        "total_bed": 20,
        "district": "ศิลาลาด",
        "staff": []
      },
      {
        "id": 417,
        "name": "ศูนย์สุขภาพชุมชนห้วยเหนือ",
        "type": 2,
        "total_bed": 50,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 418,
        "name": "อาคารเอนกประสงค์สุนีย์ อินฉัตร",
        "type": 2,
        "total_bed": 24,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 419,
        "name": "วิทยาลัยเทคนิคไพรบึง",
        "type": 2,
        "total_bed": 40,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 420,
        "name": "อาคารผู้ป่วยใน รพ.ภูสิงห์",
        "type": 2,
        "total_bed": 14,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 421,
        "name": "ที่ทำการหน่วยชลประธานเขื่อนห้วยตึ๊กชู",
        "type": 2,
        "total_bed": 40,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 422,
        "name": "วังชมพูรีสอร์ท",
        "type": 2,
        "total_bed": 105,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 423,
        "name": "รพ.สนามอำเภอศรีรัตนะ(ข้าง รร.อนุบาล)",
        "type": 2,
        "total_bed": 100,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 424,
        "name": "หอประชุม อ.เบญจลักษ์",
        "type": 2,
        "total_bed": 30,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 426,
        "name": "อาคารเอนกประสงค์ทับทิมสยาม ต.บักดอง",
        "type": 2,
        "total_bed": 39,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 453,
        "name": "ศูนย์พัฒนาเด็กเล็ก อบต.โพธิ์เก่า",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 454,
        "name": "โรงเรียนตะดอบวิทยา  ต.ตะดอบ",
        "type": 6,
        "total_bed": 6,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 455,
        "name": "ตลาด อบต.คูซอด",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 456,
        "name": "วัดบ้านจาน  ต.จาน",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 457,
        "name": "วัดบ้านหนองคู ม.4 ต.จาน",
        "type": 6,
        "total_bed": 40,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 458,
        "name": "วัดบ้านหนองคู ม.5 ต.จาน",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 459,
        "name": "วัดบ้านโคกเลาะ ม.8  ต.จาน",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 460,
        "name": "บ้านพัก รพ.สต.หนองคู  ต.จาน",
        "type": 6,
        "total_bed": 3,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 461,
        "name": "วัดโพนข่า  ต.โพนข่า",
        "type": 6,
        "total_bed": 50,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 462,
        "name": "วัดบ้านบก  ต.โพนข่า",
        "type": 6,
        "total_bed": 15,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 463,
        "name": "วัดป่าคำบอน  ต.โพนข่า",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 464,
        "name": "วัดป่ากุดโง้ง(คำมะคั่ง)",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 465,
        "name": "โรงเรียนมัธยมหนองครก  ต.หนองครก",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 466,
        "name": "ศาลาวัดบ้านหญ้าปล้อง  ต.หญ้าปล้อง",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 467,
        "name": "ศาลาพระยานาควัดพระธาตุเรืองรอง  ต.หญ้าปล้อง",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 468,
        "name": "บ้านว่าง ม.5 ต.หญ้าปล้อง",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 469,
        "name": "ศาลาประชาคมบ้านวังไฮ  ต.หญ้าปล้อง",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 470,
        "name": "ที่ทำการบ้านกำนัน  ต.หญ้าปล้อง",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 471,
        "name": "ศาลาวัดบ้านโนนแย้  ต.หญ้าปล้อง",
        "type": 6,
        "total_bed": 40,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 472,
        "name": "อบต.ซำ/ศพด.อบต  ต.ซำ",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 473,
        "name": "ศาลาวัดบ้านโพธิ์ หมู่ 2   ต.ซำ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 474,
        "name": "สำนักสงฆ์ห้วยขะยูง   ต.ซำ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 475,
        "name": "ศาลาวัดบ้านหนองแข้ หมู่ 13   ต.ซำ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 476,
        "name": "ศาลา​ 55​ ปี​  วัดหนองไผ่  ต.หนองไผ่",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 477,
        "name": "ศาลาประชาคม​ ม.​4​บ้านสะเดา  ต.หนองไผ่",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 478,
        "name": "อาคาร อบต.หนองแก้ว (หลังเดิม)",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 479,
        "name": "วัดบ้านหัวนา  ต.น้ำคำ",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 480,
        "name": "ห้องประชุม อบต.โพนเขวา",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 481,
        "name": "ศาลาวัดบ้านเหล่าแค หมู่ 5 ต.โพนเขวา",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 482,
        "name": "ศาลาวัดบ้านดอนสั้น ม. 8 ต.โพนเขวา",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 483,
        "name": "อาคาร สถานีอนามัยเดิม  ต.โพนค้อ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 484,
        "name": "ค่ายลูกเสือนิคมห้วยคล้า  ต.หมากเขียบ",
        "type": 6,
        "total_bed": 40,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 485,
        "name": "ม.1 ม.2  ศาลาวัดบ้านทุ่ม  ต.ทุ่ม",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 486,
        "name": "ม.3 ศาลาที่พักสงฆ์บ้านเสือบอง  ต.ทุ่ม",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 487,
        "name": "ม.4 ศาลากลางบ้าน  ต.ทุ่ม",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 488,
        "name": "ม.5 ศาลาวัดป่าหนองบัว  ต.ทุ่ม",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 489,
        "name": "ม.6 ศาลาที่พักสงฆ์บ้านสร้างจำปา  ต.ทุ่ม",
        "type": 6,
        "total_bed": 15,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 490,
        "name": "ม.7 วัดบ้านโนนแกด  ต.ทุ่ม",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 491,
        "name": "ม.8 วัดหนองม่วง  ต.ทุ่ม",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 492,
        "name": "ม.9 และ 10 โรงสีบ้านขมิ้น  ต.ทุ่ม",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 493,
        "name": "ม.11 โรงเรียนบ้านฮ่องแข้ดำ  ต.ทุ่ม",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 494,
        "name": "เถียงนานางบุษกร กองพริ้ว/นางสาวสมลักษณ์ มิ่งขวัญ ต.ทุ่ม",
        "type": 6,
        "total_bed": 5,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 495,
        "name": "ศาลากลางหมู่บ้าน/ที่พักสงฆ์บ้านเหล่าโนนตูม ต.ทุ่ม",
        "type": 6,
        "total_bed": 4,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 496,
        "name": "บ้านหนองไฮ ม.ที่1 วัดบ้านหนองไฮ  ต.หนองไฮ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 497,
        "name": "บ้านหนองไฮ ม.2 ศพด.หลังเก่า  ต.หนองไฮ",
        "type": 6,
        "total_bed": 15,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 498,
        "name": "บ้านแกม.3 ศาลาวัด  ต.หนองไฮ",
        "type": 6,
        "total_bed": 15,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 499,
        "name": "บ้านโพนแดง ม.4 ศาลาวัด  ต.หนองไฮ",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 500,
        "name": "บ้านก่อ ศาลาเอนกประสงค์คุ้มหนองสิม  ต.หนองไฮ",
        "type": 6,
        "total_bed": 15,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 501,
        "name": "บ้านโนนหล่อง ม.6 ศาลาประชาคม  ต.หนองไฮ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 502,
        "name": "บ้านชาดม.7 ศาลาประชาคม  ต.หนองไฮ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 503,
        "name": "ศาลาเอนกประสงค์ วัดป่าประภาโส  ต.หนองไฮ",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 504,
        "name": "โรงปุ๋ยชีวภาพ  หมู่ที่ 1 ต.อีปาด",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 505,
        "name": "ศูนย์ประปา หน้า อบต.ละทาย",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 506,
        "name": "ศาลาการเปรียญวัดสระบัว  ต.หนองแก้ว",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 607,
        "name": "ศาลาวัดบ้านค้อ ม.3 ต.ดู่",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 507,
        "name": "ห้องประชุมชั้นล่าง อบต.จาน",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 508,
        "name": "ศาลาวัดบ้านหนองถ่ม  ต.ดู่",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 509,
        "name": "หอประชุม อบต.ดู่  ม.1 ต.ดู่",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 510,
        "name": "ศาลานาบุญวัดหนองแวง  ม.1 ต.หนองแวง",
        "type": 6,
        "total_bed": 50,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 511,
        "name": "หอประชุม อบต.บัวน้อย ม.8",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 512,
        "name": "หอประชุมเทศบาลตำบลยางชุมน้อย",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 513,
        "name": "วัดป่าห้วยพระบาง ตำบลโนนคูณ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 514,
        "name": "สำนักงาน อบต.(เดิม) ตำบลโนนคูณ",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 515,
        "name": "โรงผลิตปุ๋ยอินทรย์บ้านบอน ตำบลบึงบอน",
        "type": 6,
        "total_bed": 12,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 516,
        "name": "ศูนย์พัฒนาเด็กเล็กบ้านบอน ตำบลบึงบอน",
        "type": 6,
        "total_bed": 12,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 517,
        "name": "วัดใหม่คอนกาม ตำบลคอนกาม",
        "type": 6,
        "total_bed": 15,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 518,
        "name": "วัดป่ามณีศรีชมพู ตำบลคอนกาม",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 519,
        "name": "ศูนย์พัฒนาเด็กเล็กบ้านผักขะ ตำบลลิ้นฟ้า",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 520,
        "name": "วัดป่ามงคลสุทธาวาส ตำบลยางชุมใหญ่",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 521,
        "name": "วัดบ้านกุดเมืองฮาม ตำบลกุดเมืองฮาม",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 522,
        "name": "ที่พักสงฆ์บ้านหนองโสน ต.ละเอาะ",
        "type": 6,
        "total_bed": 5,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 523,
        "name": "อาคารรองรับผู้มาปฏิบัติธรรมวัดป่าดงบก ต.เขิน",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 524,
        "name": "สถานที่ในพื้นที่หมู่บ้าน 75 หมู่บ้าน",
        "type": 6,
        "total_bed": 75,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 525,
        "name": "ศูนย์พัฒนาเด็กเล็ก(หลังเก่า)บ.หนองหว้า  ม.2 ต.พยุห์",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 526,
        "name": "ศูนย์พัฒนาเด็กเล็ก(หลังเก่า)บ.หนองทุ่ม  ม.5 ต.พยุห์",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 527,
        "name": "ศาลาปฏิบัติธรรมวัดป่าพรหมสันติ  ม.1 ต.พรหมสวัสดิ์",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 528,
        "name": "ศาลาวัดบ้านหนองเตย  ต.พรหมสวัสดิ์",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 529,
        "name": "ศาลาประชาคมบ้านสำโรง  ม.3 ต.พรหมสวัสดิ์",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 530,
        "name": "ศาลาประชาคมบ้านหนองเตยเหนือ ม.9 ต.พรหมสวัสดิ์",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 531,
        "name": "ศาลาประชาคมบ้านโนนเจริญ ม.12 ต.พรหมสวัสดิ์",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 532,
        "name": "ศาลาสำนักสงฆ์โนนทรายทอง  ม.10 ต.พรหมสวัสดิ์",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 533,
        "name": "ศาลาประชาคมบ้านหนองแข้  ม.16 ต.พรหมสวัสดิ์",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 534,
        "name": "ศาลาวัดบ้านสำโรง  ม.20 ต.พรหมสวัสดิ์",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 535,
        "name": "อาคารสนามมวยหนองสังข์  ม.13 ต.ตำแย",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 536,
        "name": "ที่ทำการสมาคมคนตาบอดจ.ศรีสะเกษ ม.2 ต.ตำแย",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 537,
        "name": "ศาลลาวัดโนนเพ็ก  ม.1 ต.โนนเพ็ก",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 538,
        "name": "ศาลาวัดบ้านหนองจิก ม.2 ต.โนนเพ็ก",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 539,
        "name": "ศาลาวัดบ้านค้อ ม.3 ต.โนนเพ็ก",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 540,
        "name": "ศาลากลางบ้าน ม.5 ต.โนนเพ็ก",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 541,
        "name": "ศาลาวัดบ้านศรีกรุง",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 542,
        "name": "ศาลากลางบ้าน",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 543,
        "name": "ศาลากลางบ้าน",
        "type": 6,
        "total_bed": 10,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 544,
        "name": "ศาลาวัดโคกเพ็ก",
        "type": 6,
        "total_bed": 20,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 545,
        "name": "หอประชุมโรงเรียนโนนเพ็กวิทยาคม ม.5 ต.หนองค้า",
        "type": 6,
        "total_bed": 30,
        "district": "เมือง",
        "staff": []
      },
      {
        "id": 546,
        "name": "ที่ทำการชมรมกำนันผู้ใหญ่บ้าน ม.2 ต.บุสูง",
        "type": 6,
        "total_bed": 20,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 547,
        "name": "ที่ทำการชมรมกำนันผู้ใหญ่บ้าน ต.ธาตุ",
        "type": 6,
        "total_bed": 10,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 548,
        "name": "ศูนย์พัฒนาเด็กเล็ก อบต.ดวนใหญ",
        "type": 6,
        "total_bed": 20,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 549,
        "name": "อาคารอเนกประสงค์ อบต. บ่อแก้ว",
        "type": 6,
        "total_bed": 5,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 550,
        "name": "ห้องประชุม เทศบาลวังหิน ต.วังหิน",
        "type": 6,
        "total_bed": 10,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 551,
        "name": "วัดหนองตาเชียง หมู่ที่ 5 ต.โพนยาง",
        "type": 6,
        "total_bed": 10,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 552,
        "name": "บ้านพักครู ร.ร.ชุมชนหนองสังข์ ต.ศรีสำราญ",
        "type": 6,
        "total_bed": 5,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 553,
        "name": "ที่ทำการชมรมกำนันผู้ใหญ่บ้าน ต.ทุ่งสว่าง",
        "type": 6,
        "total_bed": 10,
        "district": "วังหิน",
        "staff": []
      },
      {
        "id": 554,
        "name": "ศูนย์พัฒนาเด็กวัดทักษิณ (ตำบลโนนค้อ)",
        "type": 6,
        "total_bed": 20,
        "district": "โนนคูณ",
        "staff": []
      },
      {
        "id": 555,
        "name": "ศูนย์พัฒนาเด็กบ้านโนนสมบูรณ์ (ตำบลหนองกุง)",
        "type": 6,
        "total_bed": 20,
        "district": "โนนคูณ",
        "staff": []
      },
      {
        "id": 556,
        "name": "ศูนย์พัฒนาคุณภาพชีวิตและส่งเสริมอาชีพผู้สูงอายุ (ตำบลบก)",
        "type": 6,
        "total_bed": 20,
        "district": "โนนคูณ",
        "staff": []
      },
      {
        "id": 605,
        "name": "ศูนย์พัฒนาเด็กเล็ก อบต.ดู่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 557,
        "name": "ศูนย์พัฒนาเด็กเล็กบ้านผักขะย่าใหญ่ (ตำบลโพธิ์)",
        "type": 6,
        "total_bed": 20,
        "district": "โนนคูณ",
        "staff": []
      },
      {
        "id": 558,
        "name": "ศาลาประชาคมบ้านเวาะใต้ ม.7 (ตำบลเหล่ากวาง)",
        "type": 6,
        "total_bed": 20,
        "district": "โนนคูณ",
        "staff": []
      },
      {
        "id": 559,
        "name": "หอฉันท์วัดบ้านห้วย  ม.3 ต.บัวหุ่ง",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 560,
        "name": "ที่พักสงฆ์บ้านบัวหุ่ง ม.4 ต.บัวหุ่ง",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 561,
        "name": "ศูนย์พัฒนาคุณภาพชีวิตผู้สูงอายุ ม.5 ต.บัวหุ่ง",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 562,
        "name": "ศูนย์การเรียนรู้เศรษฐกิจพอเพียง ต.บัวหุ่ง",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 563,
        "name": "ศาลาหมู่บ้าน ม.8  ต.บัวหุ่ง",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 564,
        "name": "ศาลาประชาคมหมู่บ้าน ม.10  ต.บัวหุ่ง",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 565,
        "name": "ที่พักสงฆ์ (กุฏิ 3 หลัง)ม.16 ต.บัวหุ่ง",
        "type": 6,
        "total_bed": 16,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 566,
        "name": "ศูนย์พัฒนาเด็กเล็ก (เดิม) ม.17 ต.หนองอึ่ง",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 567,
        "name": "ที่พักสงฆ์บ้านหนองแค ม.1  ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 568,
        "name": "เถียงนานายทินกร คุ้ยสาหร่าย ม.2 ต.หนองแค",
        "type": 6,
        "total_bed": 4,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 569,
        "name": "เถียงนานายธนากร วีระกุล ม.2 ต.หนองแค",
        "type": 6,
        "total_bed": 4,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 570,
        "name": "ศาลาป่าช่าบ้านปลาขาว ม.2 ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 571,
        "name": "ศาลาวัดบ้านเพียมาต ม.3 ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 572,
        "name": "เถียงนาของนายบุญยัง กาดพาด ม.5 ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 573,
        "name": "ศาลาวัดบ้านเหล่าโดน ม.10 ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 574,
        "name": "ศาลากลางบ้าน ม.12 ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 575,
        "name": "เถียงนาโมเดล ม.12 ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 576,
        "name": "ศาลาประชาคม  ม.15 ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 577,
        "name": "บ้านพักสถานีสูบน้ำ  ม.16 ต.หนองแค",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 578,
        "name": "บ้านสวนนายพิชิต คำใบ  ม.17 ต.หนองแค",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 579,
        "name": "ศูนย์โครงการกลุ่มเกษตรกร อบต.หนองหมี",
        "type": 6,
        "total_bed": 25,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 580,
        "name": "ศูนย์เศรษฐกิจ  ม.10 ต.หนองหมี",
        "type": 6,
        "total_bed": 25,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 581,
        "name": "ศาลาวัดบ้านส้มป่อยใหญ่ ม.1 ต.ส้มป่อย",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 582,
        "name": "บ้านพักโรงสูบน้ำบ้านโง้ง ม.6  ต.ส้มป่อย",
        "type": 6,
        "total_bed": 2,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 583,
        "name": "บ้านนายธนาสุทธิ์ ม.6  ต.ส้มป่อย",
        "type": 6,
        "total_bed": 2,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 584,
        "name": "ศูนย์เรียนรู้เศรษฐกิจพอเพียงชุมชนบึงหมอก ม.9",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 585,
        "name": "โรงเรียนบ้านท่า ม.10  ต.ส้มป่อย",
        "type": 6,
        "total_bed": 50,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 586,
        "name": "ร้านค้าชุมชน ม.12 ต.ส้มป่อย",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 587,
        "name": "บ้านเดี่ยวของนายธนวัฒน์  ม.12 ต.ส้มป่อย",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 588,
        "name": "บ้านเดี่ยวของนายอินศร ม.12 ต.ส้มป่อย",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 589,
        "name": "บ้านเดี่ยวของนางทองจีน  ม.12 ต.ส้มป่อย",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 590,
        "name": "บ้านเดี่ยวของนางกัลยา  ม.12 ต.ส้มป่อย",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 591,
        "name": "บ้านเดี่ยวของนายวรพจน์ ม.12 ต.ส้มป่อย",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 592,
        "name": "กุฏิที่พักสงฆ์ วัดบ้านโก ม.13 ต.ส้มป่อย",
        "type": 6,
        "total_bed": 4,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 593,
        "name": "หอประชุมอำเภอราษีไศล  ต.เมืองคง",
        "type": 6,
        "total_bed": 60,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 594,
        "name": "ศาลาประชาคม ต.เมืองคง",
        "type": 6,
        "total_bed": 40,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 595,
        "name": "ศูนย์สาธิตบ้านเมืองแคน ม.1 ต.เมืองแคน",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 596,
        "name": "ศูนย์เด็กเล็กเก่า  ม.11 ต.เมืองแคน",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 597,
        "name": "ศาลาวัดบ้านแสง ม.2 ต.เมืองแคน",
        "type": 6,
        "total_bed": 30,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 598,
        "name": "เถียงนาของนายปัญญา พาหา ม.4 ต.เมืองแคน",
        "type": 6,
        "total_bed": 4,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 599,
        "name": "เถียงนาของนางรัตนา แก้วใสย์ ม.4 ต.เมืองแคน",
        "type": 6,
        "total_bed": 3,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 600,
        "name": "เถียงนาของนางชอบใจ รัตนวัน  ม.4 ต.เมืองแคน",
        "type": 6,
        "total_bed": 3,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 601,
        "name": "เถียงนาของนางอำนวย บุญราช  ม.4 ต.เมืองแคน",
        "type": 6,
        "total_bed": 4,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 602,
        "name": "ศาลาพักญาติของหมู่บ้านหลังเก่า ม.12ต.เมืองแคน",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 603,
        "name": "เถียงนาของผู้ช่วยประหงวน พาหา ม.12ต.เมืองแคน",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 604,
        "name": "อนามัยหลังเก่า  ม.1 ต.ดู่",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 606,
        "name": "ศาลาวัดบ้านกอย ม.2 ต.ดู่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 608,
        "name": "ที่ประปาหมู่บ้าน ม.4 ต.ดู่",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 609,
        "name": "ศาลาวัดบ้านกระเดา ม.5 ต.ดู่",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 610,
        "name": "เถียงนา  ม.6 ต.ดู่",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 611,
        "name": "ศาลาวัดบ้านอุ่มแสง ม.7 ต.ดู่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 612,
        "name": "ศาลาวัดแตงแซง  ม.8 ต.ดู่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 613,
        "name": "ศาลาวัดดอนม่วง  ม.9 ต.ดู่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 614,
        "name": "ศาลาวัดดอนขี้มอด  ม.10 ต.ดู่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 615,
        "name": "วัดบ้านดู่  ม.11 ต.ดู่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 616,
        "name": "วัดบ้านกระเดา  ม.12 ต.ดู่",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 617,
        "name": "ศาลาประชาคม  ม13 ต.ดู่",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 618,
        "name": "ศาลาวัดบ้านกอก  ม.14 ต.ดู่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 619,
        "name": "ศาลาวัดบ้านหว้าน ม.2  ต.หว้านคำ",
        "type": 6,
        "total_bed": 30,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 620,
        "name": "ศาลาวัดหลังเก่า ม.4 ต.หว้านคำ",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 621,
        "name": "ศาลาวัดวัดบ้านดอนต่ำ ม.5 ต.หว้านคำ",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 622,
        "name": "ศาลาที่พักศพ ที่พักสงฆ์ดอนตาล ม.6 ต.หว้านคำ",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 623,
        "name": "โรงสีข้าวชุมชน  ม.7 ต.หว้านคำ",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 624,
        "name": "ศาลาหนองขี้นก  ม.8 ต.หว้านคำ",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 625,
        "name": "บ้านเดี่ยวของนายหวัด อุ่นคำ  ม.10 ต.หว้านคำ",
        "type": 6,
        "total_bed": 6,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 626,
        "name": "กศน.ตำบลไผ่  ม.1  ต.ไผ่",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 627,
        "name": "ฉางหอม ม.6 ต.ไผ่",
        "type": 6,
        "total_bed": 2,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 628,
        "name": "ศาลาหมู่บ้านหัวหนอง  ม.8 ต.ไผ่",
        "type": 6,
        "total_bed": 3,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 629,
        "name": "บ้านพักของตนเอง ม.9 ต.ไผ่",
        "type": 6,
        "total_bed": 2,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 630,
        "name": "ศูนย์พัฒนาเด็กเล็กบ้านคูสระเก่า (อบต.ไผ่)ม.10",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 631,
        "name": "ศาลาการเปรียญวัดบ้านเชือก ม.1 ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 25,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 632,
        "name": "ศาลาประชาคมบ้านจิก ม.2 ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 25,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 633,
        "name": "ศาลากองทุนเงินล้านบ้านมะฟัก ม.3 ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 634,
        "name": "โรงครัววัดโจดนาลือ ม.4 ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 635,
        "name": "ศาลาพักศพวัดบ้านสะคาม ม.5 ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 30,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 636,
        "name": "ศาลาการเปรียญวัดบ้านสะแบงตาก ม.6ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 637,
        "name": "ศาลาประชาคมบ้านเชือกน้อย ม.8 ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 638,
        "name": "ศาลาประชาคมบ้านกอยน้อย ม.9 ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 639,
        "name": "ศาลาประชาคมบ้านสองห้อง  ม.10 ต.จิกสังข์ทอง",
        "type": 6,
        "total_bed": 5,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 640,
        "name": "ศาลาวัดบ้านด่าน  ม.1  ต.ด่าน",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 641,
        "name": "ศาลาวัดบ้านหนองบ่อ ม.2 ต.ด่าน",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 642,
        "name": "วัดป่าศรีประชารังสรรค์ ม.3 ต.ด่าน",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 643,
        "name": "ศาลาท่าน้ำมูลบ้านดงแดง ม.4 ต.ด่าน",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 644,
        "name": "ลานพระธาตุสีดา ม.5 ต.ด่าน",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 645,
        "name": "วัดป่าบ้านหนองซำไฮ ม.6 ต.ด่าน",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 646,
        "name": "วัดป่าบ้านโนนสังข์  ม.8 ต.ด่าน",
        "type": 6,
        "total_bed": 7,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 647,
        "name": "ศาลาประชาคมบ้านหนองแห้ว ม.11 ต.ด่าน",
        "type": 6,
        "total_bed": 8,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 648,
        "name": "ศาลาสำนักสงฆ์บ้านหนองคูไซ ม.1 ต.สร้างปี่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 649,
        "name": "ศาลาวัดสร้างปี่ ม.2 ต.สร้างปี่",
        "type": 6,
        "total_bed": 50,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 650,
        "name": "กุฎิเก่าสวนป่าปฎิบัติธรรม ม.3 ต.สร้างปี่",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 651,
        "name": "ลานปฎิบัติธรรมสวนป่าปฎิบัติธรรมบ้านด่าน ม.4",
        "type": 6,
        "total_bed": 15,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 652,
        "name": "ศาลาสำนักสงฆ์บ้านโนนพยอม ม.5 ต.สร้างปี่",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 653,
        "name": "กุฎิวัดหลังเก่าบ้านหนองสวง ม.6 ต.สร้างปี่",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 654,
        "name": "ศาลาวัดสร้างแก้ว ม.7 ต.สร้างปี่",
        "type": 6,
        "total_bed": 20,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 655,
        "name": "ศาลาวัดบ้านหนองศาลา ม.8 ต.สร้างปี่",
        "type": 6,
        "total_bed": 30,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 656,
        "name": "ศาลาสำนักสงฆ์บ้านหนองขาม ม.9 ต.สร้างปี่",
        "type": 6,
        "total_bed": 10,
        "district": "ราษีไศล",
        "staff": []
      },
      {
        "id": 657,
        "name": "ศาลาวัดป่าเนรัญชราวนาราม ต.เป๊าะ",
        "type": 6,
        "total_bed": 30,
        "district": "บึงบูรพ์",
        "staff": []
      },
      {
        "id": 658,
        "name": "ศาลาประชาคมบ้านสิงไคร  ต.ผักไหม",
        "type": 6,
        "total_bed": 6,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 659,
        "name": "ศาลาวัดป่าผักไหม  ต.ผักไหม",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 660,
        "name": "ศาลาประชาคมบ้านดู่  ต.ผักไหม",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 661,
        "name": "ศาลาประชาคมบ้านผักไหมใหญ่ ต.ผักไหม",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 662,
        "name": "ศาลาวัดบ้านหาด  ต.ผักไหม",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 663,
        "name": "ศาลาประชาคมบ้านตาทอง ต.ผักไหม",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 664,
        "name": "ศาลาประชาคมบ้านไฮน้อย ต.ผักไหม",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 665,
        "name": "ศาลาประชาคมบ้านไพรพะเนาว์  ต.ผักไหม",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 666,
        "name": "สถานีสูบน้ำประปา  ต.ผักไหม",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 667,
        "name": "ศูนย์ปู่ตา  ต.ผักไหม",
        "type": 6,
        "total_bed": 15,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 668,
        "name": "ศาลาประชาคมบ้านนาทุ่ง ต.ผักไหม",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 669,
        "name": "วัดบ้านกระเต็ล  ต.ผักไหม",
        "type": 6,
        "total_bed": 20,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 670,
        "name": "ศาลาประชาคมบ้านห่องน้อย  ต.ผักไหม",
        "type": 6,
        "total_bed": 20,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 671,
        "name": "ศาลาประชาคมบ้านห้วยซันพัฒนา ต.ผักไหม",
        "type": 6,
        "total_bed": 15,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 672,
        "name": "ศาลาประชาคมบ้านหนองลุง ต.ผักไหม",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 673,
        "name": "ศูนย์เย็บผ้า  ต.ผักไหม",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 674,
        "name": "ศาลาประชาคมบ้านขี้เหล็ก ต.จานแสนไชย",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 675,
        "name": "กองทุนบ้านขี้เหล็ก  ต.จานแสนไชย",
        "type": 6,
        "total_bed": 6,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 676,
        "name": "ศาลาประชาคมบ้านจานแสนไชย ต.จานแสนไชย",
        "type": 6,
        "total_bed": 15,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 677,
        "name": "ศาลาประชาคมบ้านหนองแสนไชย ต.จานแสนไชย",
        "type": 6,
        "total_bed": 20,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 678,
        "name": "ศาลาวัดป่าบ้านพงสิม ต.จานแสนไชย",
        "type": 6,
        "total_bed": 50,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 679,
        "name": "ศาลาวัดบ้านผือ  ต.จานแสนไชย",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 680,
        "name": "ศาลาผู้สูงอายุบ้านโทะ ต.เมืองหลวง",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 681,
        "name": "กุฏิพระสองหลัง  ม.8 ต.เมืองหลวง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 682,
        "name": "จุดกางเต้นท์ข้างลานอเนกประสงค์ ต.เมืองหลวง",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 683,
        "name": "กุฏิพระ บ้านห้วยยาง  ม.9 ต.เมืองหลวง",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 684,
        "name": "ศาลาบ้านโนนแถลง  ต.เมืองหลวง",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 685,
        "name": "วัดบ้านนนานวน ต.จานแสนไชย",
        "type": 6,
        "total_bed": 20,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 686,
        "name": "วัดบ้านหนองแคน  ต.จานแสนไชย",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 687,
        "name": "ศาลาประชาคมบ้านมด  ต.จานแสนไชย",
        "type": 6,
        "total_bed": 5,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 688,
        "name": "ศาลาประชาคมบ้านฟ้าผ่า  ต.จานแสนไชย",
        "type": 6,
        "total_bed": 10,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 689,
        "name": "ศาลาประชาคมบ้านพะวรน้อย  ต.จานแสนไชย",
        "type": 6,
        "total_bed": 20,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 690,
        "name": "ศาลาประชาคมบ้านกล้วยกว้าง  ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 691,
        "name": "ศาลาประชาคมบ้านบุยาว  ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 692,
        "name": "ศาลาประชาคมบ้านหนองคู ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 693,
        "name": "ศูนย์ กศน. ประจำตำบล ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 6,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 694,
        "name": "ศาลาประชาคมหมู่บ้าน ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 6,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 695,
        "name": "ศาลาประชาคมหมู่บ้าน ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 696,
        "name": "โรงครัววัดบ้านไฮใหญ่ ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 3,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 697,
        "name": "ศาลาประชาคมหมู่บ้าน ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 698,
        "name": "กุฏิพระ สำนักสงฆ์ดอนแก้วห้วยวะ ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 699,
        "name": "โรงครัววัดบ้านไพรพยอม ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 3,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 700,
        "name": "ศูนย์เด็กหลังเก่า ม.8 ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 701,
        "name": "ศาลาประชาคมหมู่บ้าน ม.9ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 702,
        "name": "โรงครัววัดบ้านขามน้อย ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 2,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 703,
        "name": "ศาลาประชาคมหมู่บ้าน ม.11 ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 704,
        "name": "ศาลาประชาคมหมู่บ้าน ม.12  ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 705,
        "name": "ศาลาประชาคมหมู่บ้าน ม.13  ต.กล้วยกว้าง",
        "type": 6,
        "total_bed": 4,
        "district": "ห้วยทับทัน",
        "staff": []
      },
      {
        "id": 706,
        "name": "สำนักสงฆ์บ้านนาส่อง ต.แข้",
        "type": 6,
        "total_bed": 6,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 707,
        "name": "อาคาร อบต.หลังเก่า ต.ทุ่งไชย",
        "type": 6,
        "total_bed": 5,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 708,
        "name": "ต.แขม หมู่ละ 1 แห่งรวม 12 แห่ง",
        "type": 6,
        "total_bed": 24,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 709,
        "name": "ศูนย์พัฒนาเด็กเทศบาลโคกจาน ม.2",
        "type": 6,
        "total_bed": 30,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 710,
        "name": "ศาลาวัดป่าบ้านโนนกอง หมู่ที่ 10 ต.โพธิ์ชัย",
        "type": 6,
        "total_bed": 20,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 711,
        "name": "ต.แต้ หมู่ละ 1 แห่งรวม 8 แห่ง",
        "type": 6,
        "total_bed": 24,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 712,
        "name": "ต.รังแร้ง หมู่ละ 1 แห่งรวม 12 แห่ง",
        "type": 6,
        "total_bed": 40,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 713,
        "name": "วัดสระกำแพงน้อย  ต.ขะยูง",
        "type": 6,
        "total_bed": 20,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 714,
        "name": "อบต.หลังเก่า  ต.หนองไฮ",
        "type": 6,
        "total_bed": 10,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 715,
        "name": "ศูนย์พัฒนาเด็กเล็กบ้านหนองจินดาน้อย ม.13 ต.ก้านเหลือง",
        "type": 6,
        "total_bed": 20,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 716,
        "name": "อบต.หลังเก่า ต.หนองห้าง",
        "type": 6,
        "total_bed": 15,
        "district": "อุทุมพรพิสัย",
        "staff": []
      },
      {
        "id": 717,
        "name": "ศูนย์เมล็ดพันธ์ข้าวบ้านตาโกน ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 718,
        "name": "ศูนย์หม่อนไหมหมู่บ้าน ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 719,
        "name": "ศาลาประชาคมบ้านสะแม๊ะ , ศาลาบ้านวัด ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 720,
        "name": "สถานีสูบน้ำบ้านแดง  ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 721,
        "name": "ศาลาประชาคมบ้านเค็ง ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 722,
        "name": "ศาลาประชาคมบ้านตาด ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 723,
        "name":
            "ศาลาวัดบ้านแต้ (หญิง) , ศาลาวัดป่าศรัทธาธรรม (ชาย) , เถียงนา  ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 724,
        "name": "ศาลาวัดบ้านชบา ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 725,
        "name": "ศาลาประชาคมบ้านนาแปะ ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 726,
        "name": "ศาลาประชาคมบ้านห่อง ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 727,
        "name": "ศาลาประชาคมบ้านกระเต็น ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 728,
        "name": "บ้านพักสถานีสูบน้ำบ้านหนองปลาคูณ ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 729,
        "name": "ศาลาประชาคมบ้านตาโกน ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 730,
        "name": "ศาลาประชาคมบ้านขยอม ต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 731,
        "name": "ศาลาประชาคมบ้านหนองสะแตงทั้ง๒แห่งต.ตาโกน",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 732,
        "name": "วัดปลาซิว ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 733,
        "name": "ศาลาประชาคมบ้านหนองผำ ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 734,
        "name": "วัดศรีอะลางรัตนาราม ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 735,
        "name": "วัดหนองดุมวนาวาส ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 736,
        "name": "วัดโนนใหญ่ ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 737,
        "name": "วัดแกงเลี้ยว ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 738,
        "name": "วัดแกงเลี้ยว ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 739,
        "name": "วัดจันทราราม ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 740,
        "name": "ศาลาประชาคมบ้านปลาซิวน้อย ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 741,
        "name": "ศาลาประชาคมบ้านหนองใหญ่ ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 742,
        "name": "ศาลาประชาคมบ้านโนนดู่ ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 743,
        "name": "ที่พักสงฆ์ป่าโนนใหญ่ ต.หนองใหญ่",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 744,
        "name": "ศาลาประชาคมบ้านบก ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 745,
        "name": "ศาลาประชาคมบ้านเมืองจันทร์ ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 746,
        "name": "ศาลาประชาคมบ้านโนนกลาง  วัดโนนกลาง ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 747,
        "name": "ศาลาประชาคมบ้านหนองแคนน้อย ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 748,
        "name": "ศาลาประชาคมบ้านโคก ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 749,
        "name": "ศาลาประชาคมบ้านอีงอย ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 750,
        "name": "ศาลาประชาคมบ้านไผ่ ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 751,
        "name": "ศาลาวัดบ้านทุ่ม ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 752,
        "name": "ศาลาประชาคมบ้านงิ้ว ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 753,
        "name": "ศาลาประชาคมบ้านเก็บงา ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 754,
        "name": "ศาลาประชาคมบ้านหนองหว้า ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 755,
        "name": "ศาลาวัดหนองแคน  ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 756,
        "name": "ศาลาประชาคมบ้านโนนสูง ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 757,
        "name": "ศาลาประชาคมบ้านหนองโน ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 758,
        "name": "ศาลาประชาคมบ้านกลาง ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 759,
        "name": "ศาลาประชาคมบ้านหนองแคน ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 760,
        "name": "ศาลาประชาคมบ้านกลางคำ ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 761,
        "name": "ศาลาประชาคมบ้านทุ่งสว่าง ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 762,
        "name": "ศาลาประชาคมบ้านม่วงน้อย ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 763,
        "name": "ศาลาประชาคมบ้านห่องคำ ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 764,
        "name": "ศาลาประชาคมบ้านสวัสดี ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 765,
        "name": "ศาลาประชาคมบ้านขนวนสมบูรณ์ ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 766,
        "name": "ศาลาประชาคมบ้านหุ่งคำ ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 767,
        "name": "ศาลาประชาคมบ้านไผ่น้อย ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 768,
        "name": "ศาลาประชาคมบ้านหนองเรือ ต.เมืองจันทร์",
        "type": 6,
        "total_bed": 5,
        "district": "เมืองจันทร์",
        "staff": []
      },
      {
        "id": 769,
        "name": "ศูนย์เรียนรู้เศรษฐกิจพอเพียง ม.3 ต.โดด",
        "type": 6,
        "total_bed": 20,
        "district": "โพธิ์ศรีสุวรรณ",
        "staff": []
      },
      {
        "id": 770,
        "name": "ศูนย์พััฒนาเด็กเล็กตำบลเสียว ม.1 ต.เสียว",
        "type": 6,
        "total_bed": 20,
        "district": "โพธิ์ศรีสุวรรณ",
        "staff": []
      },
      {
        "id": 771,
        "name": "ศูนย์ฝึกอาชีพ เทศบาลตำบลผือใหญ่",
        "type": 6,
        "total_bed": 30,
        "district": "โพธิ์ศรีสุวรรณ",
        "staff": []
      },
      {
        "id": 772,
        "name": "ศูนย์พัฒนาเด็กเล็กบ้านจาน ม.1 ต.หนองม้า",
        "type": 6,
        "total_bed": 20,
        "district": "โพธิ์ศรีสุวรรณ",
        "staff": []
      },
      {
        "id": 773,
        "name": "กศน. ตำบลอีเซ ม.5 ต.อีเซ",
        "type": 6,
        "total_bed": 15,
        "district": "โพธิ์ศรีสุวรรณ",
        "staff": []
      },
      {
        "id": 774,
        "name": "ศูนย์วัฒนธรรมตำบลคลีกลิ้ง",
        "type": 6,
        "total_bed": 10,
        "district": "ศิลาลาด",
        "staff": []
      },
      {
        "id": 775,
        "name": "กศน.ตำบลหนองบัวดง",
        "type": 6,
        "total_bed": 10,
        "district": "ศิลาลาด",
        "staff": []
      },
      {
        "id": 776,
        "name": "ศูนย์กักตัวริมฝั่งเสียว",
        "type": 6,
        "total_bed": 20,
        "district": "ศิลาลาด",
        "staff": []
      },
      {
        "id": 777,
        "name": "ศูนย์กักตัวตำบลโจดม่วง",
        "type": 6,
        "total_bed": 20,
        "district": "ศิลาลาด",
        "staff": []
      },
      {
        "id": 778,
        "name": "ศูนย์ผู้สูงอายุหลังเก่า ต.กฤษณา",
        "type": 6,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 779,
        "name": "วัดโคกเพชร  ต.โคกเพชร",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 780,
        "name": "ศูนย์พัฒนาเด็กก่อนเกณฑ์ (วัดโสภณวิหาร)ต.กันทรารมย์",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 781,
        "name": "อาคารสำนักงาน(หลังเก่า)ต.จะกง",
        "type": 6,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 782,
        "name": "วัดบ้านใจดี ต.ใจดี",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 783,
        "name": "ศาลาวัดบ้านดองกำเม็ด ต.ดองกำเม็ด",
        "type": 6,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 784,
        "name": "รพ.สต. (หลังเก่า)ต.ตะเคียน",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 785,
        "name": "ศูนย์พัฒนาเด็กเล็ก บ้านตาอุดใต้ (หลังเก่า)ต.ตาอุด",
        "type": 6,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 786,
        "name": "อาคารอเนกประสงค์สนามกีฬา อบต. ต.นิคมพัฒนา",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 787,
        "name": "ห้องประชุม อบต.ปราสาท ต.ปราสาท",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 788,
        "name": "อาคารประชุมสภาอบต.ปรือใหญ่ (หลังเก่า)ต.ปรือใหญ่",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 789,
        "name": "สำนักงาน อบต.(หลังเก่า)ต.ลมศักดิ์",
        "type": 6,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 790,
        "name": "สำนักสงฆ์สนวนไตรสามัคคี ต.ศรีตระกูล",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 791,
        "name": "กศน. ต.ศรีสะอาด (วัดศรีสะอาด)",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 792,
        "name": "หอประชุมอเนกประสงค์(อบต.)ต.สะเดาใหญ่",
        "type": 6,
        "total_bed": 7,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 793,
        "name": "อาคารอเนกประสงค์ อบต.สำโรงตาเจ็น",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 794,
        "name": "กศน.ตำบลโสน (หลังเก่า)",
        "type": 6,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 795,
        "name": "ศาลาประชาคมบ้านนิคมหนองฉลอง หมู่ที่ 9 ต.หนองฉลอง",
        "type": 6,
        "total_bed": 5,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 796,
        "name": "อาคารอเนกประสงค์อบต.ห้วยใต้",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 797,
        "name": "รพ.สต. บ้านนาก็อก (หลังเก่า)ต.ห้วยสำราญ",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 847,
        "name": "โรงเรียนบ้านพะแวะ ต.สุขสวัสดิ์",
        "type": 6,
        "total_bed": 10,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 798,
        "name": "วัดเขียนบูรพา​ราม (อาคารปฏิบัติธรรม )ต.ห้วยเหนือ",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 799,
        "name": "ศาลาอเนกประสงค์ อบต.หัวเสือ",
        "type": 6,
        "total_bed": 10,
        "district": "ขุขันธ์",
        "staff": []
      },
      {
        "id": 800,
        "name": "ศาลาประชาคม/วัด แต่ละหมู่บ้านต.โพธิ์ศรี",
        "type": 6,
        "total_bed": 190,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 801,
        "name": "ศาลาประชาคมทุกหมู่บ้าน ต.พิมายเหนือ",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 802,
        "name": "บ้านสนาย ม.3 ต.พิมาย",
        "type": 6,
        "total_bed": 20,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 803,
        "name": "ศาลาประชาคมทุกหมู่บ้านต.ดู่",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 804,
        "name": "ศาลาประชาคมบ้านหนองแวง  ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 805,
        "name": "ศาลาประชาคมบ้านศาลา  ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 806,
        "name": "วัดบ้านกำแมด ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 807,
        "name": "วัดบ้านมัดกา  ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 808,
        "name": "ศาลาประชาคมบ้านหนองเชียงทูน ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 809,
        "name": "วัดบ้านหนองระนาม ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 810,
        "name": "วัดบ้านหนองคูขาม  ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 811,
        "name": "วัดบ้านบ่อ ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 812,
        "name": "ศาลาประชาคมบ้านแขม ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 813,
        "name": "ศาลาประชาคมบ้านสว่าง ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 814,
        "name": "ศาลาประชาคมบ้านหนองแต้ ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 815,
        "name": "ศาลาประชาคมบ้านกระโดน ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 816,
        "name": "ศาลาสนามกีฬาบ้านเพ็ก ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 817,
        "name": "ศาลาประชาคมบ้านน้ำอ้อม ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 818,
        "name": "ศาลาประชาคมบ้านหนองเชียงทูนใต้ ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 819,
        "name": "ศาลากลางบ้านขุมปูน ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 820,
        "name": "ศาลากลางบ้านป่าบาก ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 821,
        "name": "ศาลาวัดบ้านทางโค้ง ต.หนองเชียงทูน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 822,
        "name": "ศาลาประชาคมบ้านแจนแลน",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 823,
        "name": "ดอนหลี่ ม.4 ต.สมอ",
        "type": 6,
        "total_bed": 2,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 824,
        "name": "ศาลาประชาคมเก่าน้อย ม.8 ต.สมอ",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 825,
        "name": "ศาลาวัดบ้านหนองนกทา ม.9  ต.สมอ",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 826,
        "name": "ดอนหลี่ ม.10  ต.สมอ",
        "type": 6,
        "total_bed": 2,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 827,
        "name": "บ้านพัก รพ.สต.สวาย ต.สวาย",
        "type": 6,
        "total_bed": 4,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 828,
        "name": "ศาลาประชาคมทุกหมู่บ้านต.ตูม",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 829,
        "name": "วัดบ้านสำโรงม.2,และ Home Isolateต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 10,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 830,
        "name": "ศาลากลางบ้านตาเปียง ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 831,
        "name": "ศาลาวัดบ้านไฮเลิง ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 832,
        "name": "ศาลากลางบ้านหนามแท่ง ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 833,
        "name": "ศาลากลางบ้านขนวน ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 834,
        "name": "ศาลาวัดบ้านขอนแต้ ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 835,
        "name": "ศาลากลางบ้านหนองนา ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 836,
        "name": "ศาลาวัดบ้านหนองแคน ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 837,
        "name": "ศาลากลางบ้านโจด ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 838,
        "name": "ศาลากลางบ้านฮ่องขาม  ดงบัง ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 10,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 839,
        "name": "ศาลากลางบ้านน้อยนาเจริญ ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 840,
        "name": "ศาลาวัดบ้านนาสำราญ ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 841,
        "name": "ศาลากลางบ้านศรีเมืองใหม่ ต.สำโรงปราสาท",
        "type": 6,
        "total_bed": 5,
        "district": "ปรางค์กู่",
        "staff": []
      },
      {
        "id": 842,
        "name": "สำนักสงฆ์อริยทรัพย์  ต.ไพรบึง",
        "type": 6,
        "total_bed": 20,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 843,
        "name": "โรงปุ๋ยชีวภาพบ้านทุ่ม ต.ไพรบึง",
        "type": 6,
        "total_bed": 20,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 844,
        "name": "ศูนย์เด็กเล็ก อบต.ดินแดง ต.ดินแดง",
        "type": 6,
        "total_bed": 20,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 845,
        "name": "ห้องประชุม อบต.ปราสาทเยอ",
        "type": 6,
        "total_bed": 10,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 846,
        "name": "ศูนย์เด็กเล็ก บ้านหัวช้าง ต.สำโรงพลัน",
        "type": 6,
        "total_bed": 12,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 848,
        "name": "อาคารอเนกประสงค์  อบต.โนนปูน",
        "type": 6,
        "total_bed": 12,
        "district": "ไพรบึง",
        "staff": []
      },
      {
        "id": 849,
        "name": "วัดป่าบ้านกลาง ม.5 ต.ดงรัก",
        "type": 6,
        "total_bed": 50,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 850,
        "name": "ศูนย์ชมรมกำนันผู้ใหญ่บ้าน  หมู่ 3 ต.ดงรัก",
        "type": 6,
        "total_bed": 29,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 851,
        "name": "อาคารดูแลผู้สูงอายุ(LTC) หมู่ 4 ต.ไพรพัฒนา",
        "type": 6,
        "total_bed": 10,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 852,
        "name": "ศาลาประชาคม อบต.ไพรพัฒนา หมู่ 3 ต.ไพรพัฒนา",
        "type": 6,
        "total_bed": 15,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 853,
        "name": "วัดป่าอัมวัน หมู่ 1 ต.ละลม",
        "type": 6,
        "total_bed": 20,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 854,
        "name": "ศาลาประชาคมละลมหนองหาร หมู่ 13 ต.ละลม",
        "type": 6,
        "total_bed": 20,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 855,
        "name": "ศาลาประชาคม ม.10 ต.โคกตาล",
        "type": 6,
        "total_bed": 30,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 856,
        "name": "ศาลากลางหมู่บ้าน หมู่ 12  ห้วยยาง ต.ตะเคียนราม",
        "type": 6,
        "total_bed": 10,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 857,
        "name": "ศูนย์ปฏิบัติธรรมแก้วภาวนา หมู่ 9 ต.ห้วยตึ๊กชู",
        "type": 6,
        "total_bed": 60,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 858,
        "name": "วัดบ้านขะยูง หมู่ 10 ต.ห้วยตามอญ",
        "type": 6,
        "total_bed": 50,
        "district": "ภูสิงห์",
        "staff": []
      },
      {
        "id": 859,
        "name": "ที่ทำการชุมชนหนองหญ้าลาด 2 ทม.กันทรลักษ์",
        "type": 6,
        "total_bed": 50,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 860,
        "name": "โรงยิมอเนกประสงค์  ทต.หนองหญ้าลาด",
        "type": 6,
        "total_bed": 200,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 861,
        "name": "อาคารชั่วคราว เทศบาลตำบลสวนกล้วย",
        "type": 6,
        "total_bed": 20,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 862,
        "name": "วัดบ้านชำ บ.ซำ  ต.ซำ",
        "type": 6,
        "total_bed": 20,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 863,
        "name": "วัดโพทยาราม บ.นาโพธิ์  ต.ซำ",
        "type": 6,
        "total_bed": 15,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 864,
        "name": "ร้านค้าชุมชนเก่า บริเวณ อบต.ตระกาจ",
        "type": 6,
        "total_bed": 10,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 865,
        "name": "ลานค้าชุมชน  บ.ภูมิซรอลใหม่  ต.เสาธงชัย",
        "type": 6,
        "total_bed": 10,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 866,
        "name": "องค์การบริหารส่วนตำบลขนุนหลังเก่า ต.ขนุน",
        "type": 6,
        "total_bed": 60,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 867,
        "name": "สถานีอนามัยบ้านโนนสมประสงค์ ต.กระแชง",
        "type": 6,
        "total_bed": 10,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 868,
        "name": "วัดท่าสว่าง  ต.โนนสำราญ",
        "type": 6,
        "total_bed": 30,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 869,
        "name": "วัดรุ่งอรุณ ต.โนนสำราญ",
        "type": 6,
        "total_bed": 20,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 870,
        "name": "ศาลาประชาคม บ.หนองตระกาศ ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 871,
        "name": "ศาลาประชาคม บ.ตูมน้อย  ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 872,
        "name": "ศาลาประชาคม บ.หิน ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 873,
        "name": "ศาลาประชาคม บ.ไพรงาม ต.ภูเงิน",
        "type": 6,
        "total_bed": 2,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 874,
        "name": "ศาลาประชาคม บ.ภูเงิน ต.ภูเงิน",
        "type": 6,
        "total_bed": 8,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 875,
        "name": "ศาลาประชาคม บ.ท่าพระ  ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 876,
        "name": "ศาลาประชาคม บ.สมบูรณ์ ต.ภูเงิน",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 877,
        "name": "ศาลาประชาคม บ.ซำผักแว่น ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 878,
        "name": "ศาลาประชาคม บ.ภูคำ ต.ภูเงิน",
        "type": 6,
        "total_bed": 8,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 879,
        "name": "ศาลาประชาคม บ.ทางโค้ง  ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 880,
        "name": "ศาลาประชาคม บ.นาซำ ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 881,
        "name": "ศาลาประชาคม บ.สันติสุข ต.ภูเงิน",
        "type": 6,
        "total_bed": 7,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 882,
        "name": "ศาลาประชาคม บ.ป่าโมง ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 883,
        "name": "ศาลาประชาคม บ.บูรพา ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 884,
        "name": "ศาลาประชาคม บ.นาเหนือ ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 885,
        "name": "ศาลาประชาคม บ.ภูดิน  ต.ภูเงิน",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 886,
        "name": "หอประชุม ณ องค์การบริหารส่วนตำบลรุง",
        "type": 6,
        "total_bed": 20,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 887,
        "name": "ศูนย์เศรษฐกิจชุมชน อบต.สังเม็ก",
        "type": 6,
        "total_bed": 50,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 888,
        "name": "วัดศรีตาลอย อบต.จานใหญ่",
        "type": 6,
        "total_bed": 20,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 889,
        "name":
            "ศูนย์พัฒนาเด็กเล็กหลังเก่า ตั้งในบริเวณองค์การบริหารส่วนตำบลกุดเสลา",
        "type": 6,
        "total_bed": 20,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 890,
        "name": "ตลาดบ้านกุดเสลา ต.กุดเสลา",
        "type": 6,
        "total_bed": 10,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 891,
        "name": "บ้านพัก รพ.สต.กุดเสลา",
        "type": 6,
        "total_bed": 5,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 892,
        "name": "ศาลาประชาคม บ.เดียงตะวันออก ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 893,
        "name": "ศาลาประชาคม บ.เดียงตะวันตก ม.2ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 10,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 894,
        "name": "ศาลาประชาคม บ.เดียงตะวันตก ม.3ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 895,
        "name": "ศาลาประชาคม บ.เดียงเหนือ ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 896,
        "name": "ศาลาประชาคม บ.หนองแก ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 897,
        "name": "ศาลาประชาคม บ.วังชมพู  ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 898,
        "name": "ศาลาประชาคม บ.นาตาล ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 899,
        "name": "ศาลาประชาคม บ.เดียงใต้พัฒนา ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 900,
        "name": "ศาลาประชาคม บ.เวียงเหนือ ต.เวียงเหนือ",
        "type": 6,
        "total_bed": 6,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 901,
        "name": "วัดขนาใหม่  ต.น้ำอ้อม",
        "type": 6,
        "total_bed": 100,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 902,
        "name": "องค์การบริหารส่วนตำบลละลายหลังเก่า",
        "type": 6,
        "total_bed": 20,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 903,
        "name": "วัดโนนธรรมมาวาส (บ้านโนนเปือย) ต.เมือง",
        "type": 6,
        "total_bed": 30,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 904,
        "name": "ศาลาประชาคม บ.ด่านกลาง ต.ภูผาหมอก",
        "type": 6,
        "total_bed": 5,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 905,
        "name": "ศาลาประชาคม บ.ด่านใต้ ต.ภูผาหมอก",
        "type": 6,
        "total_bed": 5,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 906,
        "name": "ศาลาประชาคม บ.ด่านเหนือ ต.ภูผาหมอก",
        "type": 6,
        "total_bed": 5,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 907,
        "name": "ศาลาประชาคม บ.โศกขามป้อม ต.ภูผาหมอก",
        "type": 6,
        "total_bed": 5,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 908,
        "name": "ศาลาประชาคม บ.หนองหว้า ต.ภูผาหมอก",
        "type": 6,
        "total_bed": 3,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 909,
        "name": "ศาลาประชาคม  บ.ภูผาหมอก ต.ภูผาหมอก",
        "type": 6,
        "total_bed": 5,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 910,
        "name": "ศาลาประชาคม บ.โคกใหม่  ต.ทุ่งใหญ่",
        "type": 6,
        "total_bed": 10,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 911,
        "name": "โรงเรียนผู้สูงอายุสุขวิทย์บึงมะลู",
        "type": 6,
        "total_bed": 30,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 912,
        "name": "อาคารอเนกประสงค์ อบต.บึงมะลู",
        "type": 6,
        "total_bed": 30,
        "district": "กันทรลักษ์",
        "staff": []
      },
      {
        "id": 913,
        "name": "ศูนย์พัฒนาเด็กเล็ก บ.สะพุง ม.1 ต.สะพุง",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 914,
        "name": "ศูนย์พัฒนาเด็กเล็ก บ.ทุ่งสว่าง ม.3 ต.สะพุง",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 915,
        "name": "ศูนย์ กศน.ตำบลสะพุง ม.7 ต.สะพุง",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 916,
        "name": "ศูนย์พัฒนาเด็กเล็ก บ.หนองปิงโปง ม.4 ต.เสื่องข้าว",
        "type": 6,
        "total_bed": 7,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 917,
        "name": "ศูนย์พัฒนาเด็กเล็ก บ.กระหวัน ม.11 ต.เสื่องข้าว",
        "type": 6,
        "total_bed": 7,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 918,
        "name": "ศูนย์พัฒนาเด็กเล็ก บ.จานบัว ม.10 ต.เสื่องข้าว",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 919,
        "name": "ศาลาประชาคม บ.โนนกุง  ม.8 ต.ศรีแก้ว",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 920,
        "name": "ศาลาประชาคม บ.สระเยาว์  ม.1 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 921,
        "name": "ศาลาประชาคม บ.ปุน  ม.3 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 922,
        "name": "ศาลาประชาคม บ.กล้วย ม8  ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 923,
        "name": "ศาลาประชาคม บ.โนนสะอาด ม.9 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 924,
        "name": "ศาลาประชาคม บ.กันจาน ม.10 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 925,
        "name": "ศาลาประชาคม บ.โคน ม.11 ต.ศรีแก้ว",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 926,
        "name": "ศาลาประชาคม  ม.2 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 927,
        "name": "ศาลาประชาคม  ม.4 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 928,
        "name": "ศาลาประชาคม  ม.5 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 929,
        "name": "ศาลาประชาคม  ม.6 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 930,
        "name": "ศาลาประชาคม  ม.7 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 931,
        "name": "ศาลาประชาคม  ม.11 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 932,
        "name": "ศาลาประชาคม  ม.12 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 933,
        "name": "ศาลาประชาคม  ม.13 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 934,
        "name": "ศาลาประชาคม  ม.14 ต.สระเยาว์",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 935,
        "name": "ศูนย์เด็กเล็กตำบลศรีโนนงาม บ.โนนงาม  ม.1 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 936,
        "name": "ศาลาประชาคมบ้านโนนงาม บ.โนนงาม ม.1 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 937,
        "name": "ศาลาประชาคมบ้านหนองรุง  ม.2  ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 938,
        "name": "ศาลาประชาคมบ้านตาเหมา  ม.3 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 939,
        "name": "ศาลาประชาคมบ้านหนองใหญ่  ม.4 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 940,
        "name": "ศาลาประชาคมบ้านโนนแก  ม.5 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 941,
        "name": "ศาลาประชาคมบ้านโนนหนองบัว  ม.6 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 942,
        "name": "ศาลาประชาคมบ้านหนองหัวลิง  ม.7 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 943,
        "name": "ศาลาประชาคมบ้านตาไทย  ม.8 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 944,
        "name": "ศาลาประชาคมบ้านหนองโบสถ์  ม.9 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 945,
        "name": "ศาลาประชาคมบ้านหนองรุงน้อย ม.10 ต.ศรีโนนงาม",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 946,
        "name": "ศาลาประชาคมบ้านหนองขาม  ม.6 ต.สะพุง",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 947,
        "name": "ศาลาประชาคม ม.13 ต.พิงพวย",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 948,
        "name": "ศาลาประชาคม ม.12 ต.พิงพวย",
        "type": 6,
        "total_bed": 10,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 949,
        "name": "ศาลาประชาคม ม.2 บ.ตูมพัฒนา ต.ตูม",
        "type": 6,
        "total_bed": 40,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 950,
        "name": "ศาลาประชาคม ม.3 บ.ศรีพะเนา  ต.ตูม",
        "type": 6,
        "total_bed": 40,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 951,
        "name": "ศาลาประชาคม ม.4 บ.หนองกันจง  ต.ตูม",
        "type": 6,
        "total_bed": 40,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 952,
        "name": "ศาลาประชาคม ม.5 บ.โนนสวน ต.ตูม",
        "type": 6,
        "total_bed": 40,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 953,
        "name": "ศาลาประชาคม ม.6 บ.ไฮ  ต.ตูม",
        "type": 6,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 954,
        "name": "ศาลาประชาคม ม.7  บ.โนนสะอาด  ต.ตูม",
        "type": 6,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 955,
        "name": "ศาลาประชาคม ม.8  บ.บก  ต.ตูม",
        "type": 6,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 956,
        "name": "ศาลาประชาคม ม.10 บ.สามสิบเอ็ดพัฒนา  ต.ตูม",
        "type": 6,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 957,
        "name": "ศาลาประชาคม ม.11 บ.ศรีพะเนาใต้  ต.ตูม",
        "type": 6,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 958,
        "name": "ศาลาประชาคม ม.12 บ.ศรีพะเนาตะวันออก ต.ตูม",
        "type": 6,
        "total_bed": 20,
        "district": "ศรีรัตนะ",
        "staff": []
      },
      {
        "id": 959,
        "name": "วัดป่าเบญจลักษ์ ม.7",
        "type": 6,
        "total_bed": 30,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 960,
        "name": "หอประชุม อบต.หนองหว้า ม.10",
        "type": 6,
        "total_bed": 20,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 961,
        "name": "ศาลาประชาคม บ.หนองงูเหลือม ม.11",
        "type": 6,
        "total_bed": 20,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 962,
        "name": "โรงเรียนบ้านหนองฮาง ม.12",
        "type": 6,
        "total_bed": 20,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 963,
        "name": "ศูนย์พัฒนาเด็กเล็กวัดโนนสำโรง ม.5",
        "type": 6,
        "total_bed": 10,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 964,
        "name": "วัดบ้านคำสะอาด ม.8",
        "type": 6,
        "total_bed": 30,
        "district": "เบญจลักษ์",
        "staff": []
      },
      {
        "id": 965,
        "name": "ศาลาวัดศรีขุนหาญ ต.สิ",
        "type": 6,
        "total_bed": 40,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 966,
        "name": "ที่พักเจ้าหน้าที่ชลประทานห้วยตาแบง ต.บักดอง",
        "type": 6,
        "total_bed": 8,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 967,
        "name": "สำนักงาน อบต.ห้วยจันทร์ (เก่า)ต.ห้วยจันทร์",
        "type": 6,
        "total_bed": 10,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 968,
        "name": "รพ.สต.บ้านห้วยจันทร์ (เก่า)ต.ห้วยจันทร์",
        "type": 6,
        "total_bed": 8,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 969,
        "name": "กุฏิวัดกันทรอมใต้ ต.กันทรอม",
        "type": 6,
        "total_bed": 30,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 970,
        "name": "สนามกีฬาหนองกระทุ่ม ต.กันทรอม",
        "type": 6,
        "total_bed": 40,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 971,
        "name": "วัดบ้านกุดนาแก้ว ต.ภูฝ้าย",
        "type": 6,
        "total_bed": 50,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 972,
        "name": "ศาลาวัดโพธิ์น้อย ต.กระหวัน",
        "type": 6,
        "total_bed": 20,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 973,
        "name": "วัดบ้านกระมัล ต.โพธิ์วงศ์",
        "type": 6,
        "total_bed": 60,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 974,
        "name": "ศาลาวัดโนนสูง (หอฉัน)ต.โนนสูง",
        "type": 6,
        "total_bed": 20,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 975,
        "name": "ศาลาวัดบ้านดาน (หอพักแม่ชี) ต.โนนสูง",
        "type": 6,
        "total_bed": 20,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 976,
        "name": "ศาลาประชาคม ต.ไพร",
        "type": 6,
        "total_bed": 9,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 977,
        "name": "ศาลาวัดอรุณสว่าง ต.ไพร",
        "type": 6,
        "total_bed": 20,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 978,
        "name": "ศาลาประชาคมหมู่บ้านดู่ ต.ขุนหาญ",
        "type": 6,
        "total_bed": 5,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 979,
        "name": "วัดศรีโนนแฝก ต.พราน",
        "type": 6,
        "total_bed": 5,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 980,
        "name": "วัดสุพรรณรัตน์ ต.พราน",
        "type": 6,
        "total_bed": 10,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 981,
        "name": "อาคารอเนกประสงค์ อบต.พราน",
        "type": 6,
        "total_bed": 20,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 982,
        "name": "อาคารตัดเย็บผ้าเก่า ทต.โพธิ์กระสังข์",
        "type": 6,
        "total_bed": 50,
        "district": "ขุนหาญ",
        "staff": []
      },
      {
        "id": 983,
        "name": "อาคารอเนกประสงค์ ทต.โพธิ์กระสังข์",
        "type": 6,
        "total_bed": 40,
        "district": "ขุนหาญ",
        "staff": []
      }
    ]
  }
};
