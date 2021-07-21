import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ssk_ruamjai/components/buttons/k_button.dart';
import 'package:ssk_ruamjai/components/k_toast.dart';
import 'package:ssk_ruamjai/data.dart';
import 'package:ssk_ruamjai/screens/form_edit_patient/form_edit_patient.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class DetailPatient extends StatefulWidget {
  static const routeName = '/details_patient';
  @override
  _DetailPatientState createState() => _DetailPatientState();
}

class _DetailPatientState extends State<DetailPatient>
    with TickerProviderStateMixin {
  // Format id card
  var idMaskFormatter = MaskTextInputFormatter(
      mask: '#-####-#####-##-#', filter: {"#": RegExp(r'[0-9]')});

  // Format id card
  var phoneNumberMaskFormatter = MaskTextInputFormatter(
      mask: '###-####-###', filter: {"#": RegExp(r'[0-9]')});

  // Format id card
  var birthdayMaskFormatter = MaskTextInputFormatter(
      mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')});

  // อำเภอภูมิลำเนา
  late Map<String, String> _initDistrict;
// ช่วยเหลือตัวเองได้หรือไม่ *
  late Map<String, String> _initData0;
// ผู้ป่วยอยู่ในพื้นที่จังหวัดศรีสะเกษหรือไม่
  late Map<String, String> _initData1;
// มีอาการหอบเหนื่อย หายใจเร็ว หายใจไม่สะดวก หรือปอดติดเชื้อหรือไม่
  late Map<String, String> _initData2;
// อาการเจ็บป่วยเบื้องต้น *
  late Map<String, String> _initData3;
// โรคที่เพิ่มความเสี่ยง
// เลือกตัวเลือกที่ใช่ทั้งหมด
  late Map<String, String> _initData4;
// เพศ
  late Map<String, String> _initSex;

  @override
  void initState() {
    super.initState();
    _initDistrict = district;
    _initData0 = data0;
    _initData1 = data1;
    _initData2 = data2;
    _initData3 = data3;
    _initData4 = data4;
    _initSex = sex;
    _district = _initDistrict["23"]!;
  }

  // district value
  late String _district;

  // เพศ
  int _sex = -1;

  // isPregnant
  int _isPregnant = -1;

  // ช่วยเหลือตัวเองได้หรือไม่ *
  int _data0 = -1;

  // ผู้ป่วยอยู่ในพื้นที่จังหวัดศรีสะเกษหรือไม่
  int _data1 = -1;

  // มีอาการหอบเหนื่อย หายใจเร็ว หายใจไม่สะดวก หรือปอดติดเชื้อหรือไม่
  int _data2 = -1;

  // อาการเจ็บป่วยเบื้องต้น
  final _data3 = {
    "0": false,
    "1": false,
    "2": false,
    "3": false,
    "4": false,
    "5": false,
    "6": false
  };

  // โรคที่เพิ่มความเสี่ยง
// เลือกตัวเลือกที่ใช่ทั้งหมด
  final _data4 = {
    "0": false,
    "1": false,
    "2": false,
    "3": false,
    "4": false,
    "5": false,
    "6": false,
    "7": false,
    "8": false
  };

  // true = green
  // false = yellow
  bool _status = true;

  void _onChangedCheckbox(_) {
    setState(() {
      _status = !_status;
    });
  }

  final _idController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: kDefaultPadding * 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "รายละเอียดผู้ป่วย",
                    style: context.textTheme.headline4!
                        .copyWith(color: Colors.black87),
                  ),
                  Text(
                    "อำเภอกันทรลักษ์",
                    style: context
                        .responsiveValue(
                          desktop: context.textTheme.headline6,
                          tablet: context.textTheme.headline6,
                          mobile: context.textTheme.subtitle1,
                        )!
                        .copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: kMaxWidth),
                  padding: EdgeInsets.symmetric(
                      horizontal: context.isPhone
                          ? kDefaultPadding
                          : kDefaultPadding * 4),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: kDefaultPadding * 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ข้อมูลผู้ป่วย",
                                      style:
                                          context.textTheme.headline6!.copyWith(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "วีระพันธ์ บุญบุตร",
                                          style: context.textTheme.headline5!
                                              .copyWith(
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 64,
                                          color: Colors.white,
                                          child: Icon(
                                            Icons.circle,
                                            color: Colors.yellow.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              // if (!value)
                              Container(
                                width: context.isPhone
                                    ? kDefaultPadding * 6
                                    : kDefaultPadding * 8,
                                child: KButton(
                                  text: 'แก้ไขข้อมูล',
                                  onPressed: () {
                                    Get.toNamed(FormEditPatient.routeName);
                                  },
                                ),
                              )
                            ],
                          ),
                          DetailRow(
                            title1: "เลขบัตรประชาชน 13 หลัก",
                            value1: "13304005115XX",
                            title2: "เขตที่ลงข้อมูล",
                            value2: "กันทรลักษ์",
                          ),
                          DetailRow(
                            title1: "ชื่อ",
                            value1: "วีระพันธ์",
                            title2: "นามสกุล",
                            value2: "บุญบุตร",
                          ),
                          DetailRow(
                            title1: "เพศ",
                            value1: "ชาย",
                            title2: "อายุ",
                            value2: "24",
                          ),
                          DetailRow(
                            title1: "วันเดือนปีเกิด",
                            value1: "22-22-2222",
                            title2: "หมายเลขโทรศัพท์",
                            value2: "099-9999-999",
                          ),
                          DetailRow(
                            title1: "น้ำหนัก (กม.)",
                            value1: "55",
                            title2: "ส่วนสูง (ซม.)",
                            value2: "167",
                          ),
                          DetailRow(
                              title1: "ที่อยู่ปัจจุบัน *",
                              value1:
                                  "45 m.15 t.phungueng o.kantharalak sisaket 33110 ",
                              element: 1),
                          DetailRow(
                              title1: "ภูมิลำเนา *",
                              value1:
                                  "45 m.15 t.phungueng o.kantharalak sisaket 33110 ",
                              element: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ข้อมูลผู้ป่วยเพิ่มเติม",
                                  style: context.textTheme.headline6!.copyWith(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DetailRow(
                            title1:
                                "ผู้ป่วยอยู่ในพื้นที่จังหวัดศรีสะเกษหรือไม่",
                            value1: "อยู่ในพื้นที่",
                            element: 1,
                          ),
                          DetailRow(
                            title1:
                                "มีอาการหอบเหนื่อย หายใจเร็ว หายใจไม่สะดวก หรือปอดติดเชื้อหรือไม่",
                            value1: "มี",
                            element: 1,
                          ),
                          DetailRow(
                            title1: "โรคที่เพิ่มความเสี่ยง",
                            value1: """- โรคปอดอุดกั้นเรื้อรัง (รวมโรคปอดอื่น ๆ)
- โรคไตเรื้อรัง
- โรคหัวใจและหลอดเลือด (รวมโรคหัวใจแต่กำเนิด)
- โรคหลอดเลือดสมอง
- เบาหวาน""",
                            element: 1,
                          ),
                          DetailRow(
                              title1: "โรคประจำตัวอื่น ๆ",
                              value1: "-",
                              element: 1),
                          DetailRow(
                              title1: "อาการเจ็บป่วยเบื้องต้น",
                              value1: """- ไข้
- ไอ
- น้ำมูก
- ตาแดง""",
                              element: 1),
                          DetailRow(
                              title1: "ช่วยเหลือตัวเองได้หรือไม่ ",
                              value1: "ไม่ได้",
                              element: 1),
                          DetailRow(
                              title1: "บันทึกเพิ่มเติม",
                              value1: "-",
                              element: 1),
                          DetailRow(
                              title1: "ชื่อ Line ผู้ประสานงาน",
                              value1: "-",
                              element: 1),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myRadioButton(
      {required String title,
      required int groupValue,
      required int value,
      required Function(int?) onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(
        title,
        style: context.isPhone
            ? context.textTheme.subtitle2
            : context.textTheme.subtitle1!.copyWith(color: Colors.black54),
      ),
    );
  }

  Future _onSubmit() async {
    try {
      if (_district == _initDistrict["23"]!) {
        return kToast("กรุณากรอกอำเภอภูมิลำเนา",
            Text('กรุณากรอกข้อมูลผู้ป่วยให้ครบถ้วนก่อนบันทึกไปยังฐานข้อมูล'));
      }

      if (_sex == -1) {
        return kToast("กรุณาระบุเพศ",
            Text('กรุณากรอกข้อมูลผู้ป่วยให้ครบถ้วนก่อนบันทึกไปยังฐานข้อมูล'));
      }

      if (_sex == 1 && _isPregnant == -1) {
        return kToast('กรุณาระบุตัวเลือกคำถามหัวข้อ "เพศ" ให้ครบถ้วน',
            Text('กรุณากรอกข้อมูลผู้ป่วยให้ครบถ้วนก่อนบันทึกไปยังฐานข้อมูล'));
      }

      final isValidForm = _form.currentState?.validate();

      // Form validate
      if (!isValidForm!) {
        return kToast("กรุณากรอกข้อมูลผู้ป่วยให้ครบถ้วน",
            Text('กรุณากรอกข้อมูลผู้ป่วยให้ครบถ้วนก่อนบันทึกไปยังฐานข้อมูล'));
      }

      // ช่วยเหลือตัวเองได้หรือไม่ *
      if (_data0 == -1) {
        return kToast('กรุณาระบุ "ช่วยเหลือตัวเองได้หรือไม่"',
            Text('กรุณากรอกข้อมูลผู้ป่วยให้ครบถ้วนก่อนบันทึกไปยังฐานข้อมูล'));
      }

      // ผู้ป่วยอยู่ในพื้นที่จังหวัดศรีสะเกษหรือไม่
      if (_data1 == -1) {
        return kToast('กรุณาระบุ "ผู้ป่วยอยู่ในพื้นที่จังหวัดศรีสะเกษหรือไม่"',
            Text('กรุณากรอกข้อมูลผู้ป่วยให้ครบถ้วนก่อนบันทึกไปยังฐานข้อมูล'));
      }

      // มีอาการหอบเหนื่อย หายใจเร็ว หายใจไม่สะดวก หรือปอดติดเชื้อหรือไม่
      if (_data2 == -1) {
        return kToast(
            'กรุณาระบุ "มีอาการหอบเหนื่อย หายใจเร็ว หายใจไม่สะดวก หรือปอดติดเชื้อหรือไม่"',
            Text('กรุณากรอกข้อมูลผู้ป่วยให้ครบถ้วนก่อนบันทึกไปยังฐานข้อมูล'));
      }
    } catch (err) {
      throw (err);
    }
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({
    Key? key,
    required this.title1,
    required this.value1,
    this.title2,
    this.value2,
    this.element,
  }) : super(key: key);

  final String title1;
  final String value1;
  final String? title2;
  final String? value2;
  final int? element;

  @override
  Widget build(BuildContext context) {
    if (element == 1) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: Text(
                    title1,
                    style: (context.isPhone
                            ? context.textTheme.subtitle2
                            : context.textTheme.subtitle1)!
                        .copyWith(
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
              // * Value1
              Expanded(
                flex: 1,
                child: Text(
                  value1,
                  style: context.textTheme.subtitle1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
            child: Divider(),
          ),
        ],
      );
    }

    if (context.isPhone) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  title1,
                  style: context.textTheme.subtitle2!.copyWith(
                    color: Colors.black45,
                  ),
                ),
              ),
              SizedBox(width: kDefaultPadding),
              // * Value1
              Expanded(
                flex: 1,
                child: Text(
                  value1,
                  style: context.textTheme.subtitle1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
            child: Divider(),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  title2!,
                  style: context.textTheme.subtitle2!.copyWith(
                    color: Colors.black45,
                  ),
                ),
              ),
              SizedBox(width: kDefaultPadding),
              // * Value2
              Expanded(
                flex: 1,
                child: Text(
                  value2!,
                  style: context.textTheme.subtitle1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
            child: Divider(),
          ),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title1,
                style: context.textTheme.subtitle1!.copyWith(
                  color: Colors.black45,
                ),
              ),
            ),
            SizedBox(width: kDefaultPadding),
            // * Value1
            Expanded(
              flex: 1,
              child: Text(
                value1,
                style: context.textTheme.subtitle1,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                title2 ?? "",
                style: context.textTheme.subtitle1!.copyWith(
                  color: Colors.black45,
                ),
              ),
            ),
            SizedBox(width: kDefaultPadding),
            // * Value2
            Expanded(
              flex: 1,
              child: Text(
                value2 ?? "",
                style: context.textTheme.subtitle1,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding,
          child: Divider(),
        ),
      ],
    );
  }
}
