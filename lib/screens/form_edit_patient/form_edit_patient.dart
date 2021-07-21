import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ssk_ruamjai/components/buttons/k_button.dart';
import 'package:ssk_ruamjai/components/buttons/k_button_outlined.dart';
import 'package:ssk_ruamjai/components/input_text/k_input_form_field.dart';
import 'package:ssk_ruamjai/components/k_toast.dart';
import 'package:ssk_ruamjai/data.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class FormEditPatient extends StatefulWidget {
  static const routeName = '/edit_patient';
  @override
  _FormEditPatientState createState() => _FormEditPatientState();
}

class _FormEditPatientState extends State<FormEditPatient>
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
                    "แก้ไขข้อมูลผู้ป่วย",
                    style: context.textTheme.headline5,
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
                          SizedBox(height: kDefaultPadding),
                          SizedBox(
                              height: kDefaultPadding * 2, child: Divider()),
                          // * district (อำเภอภูมิลำเนา)
                          Row(
                            children: [
                              Text(
                                "อำเภอภูมิลำเนา",
                                style: context.textTheme.subtitle1,
                              ),
                              SizedBox(
                                width: kDefaultPadding,
                              ),
                              DropdownButton<String>(
                                value: _district,
                                icon: Icon(Icons.arrow_downward_outlined),
                                elevation: 16,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      context.textTheme.subtitle1!.fontSize,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: kPrimaryColor,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _district = newValue!;
                                  });
                                },
                                items: _initDistrict.entries
                                    .map((e) => e.value)
                                    .toList()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding * 2,
                            child: Divider(),
                          ),
                          // * ID
                          KInputFormField(
                            controller: _idController,
                            inputFormatters: [
                              idMaskFormatter,
                            ],
                            hintText: "เลขบัตรประชาชน (ถ้ามี)",
                          ),
                          SizedBox(
                            height: kDefaultPadding * 2,
                            child: Divider(),
                          ),
                          // * Sex *
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "เพศ",
                                  style: context.textTheme.subtitle1,
                                ),
                                Row(
                                  children: List.generate(
                                    _initSex.length,
                                    (index) => Flexible(
                                      fit: FlexFit.loose,
                                      child: _myRadioButton(
                                        groupValue: _sex,
                                        title: _initSex["$index"]!,
                                        value: index,
                                        onChanged: (val) =>
                                            setState(() => _sex = val!),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // * Is Pregnant *
                          AnimatedSizeAndFade.showHide(
                            vsync: this,
                            show: _sex == 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kDefaultPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ตั้งครรภ์หรือไม่ (จำเป็น)",
                                    style: context.textTheme.subtitle1,
                                  ),
                                  Row(
                                    children: List.generate(
                                      isPregnant.length,
                                      (index) => Flexible(
                                        fit: FlexFit.loose,
                                        child: _myRadioButton(
                                          groupValue: _isPregnant,
                                          title: isPregnant["$index"]!,
                                          value: index,
                                          onChanged: (val) => setState(
                                              () => _isPregnant = val!),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding * 2,
                            child: Divider(),
                          ),
                          // * Name
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: KInputFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "กรุณากรอกชื่อ";
                                    }
                                    return null;
                                  },
                                  hintText: "ชื่อ",
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPadding,
                              ),
                              Expanded(
                                flex: 1,
                                child: KInputFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "กรุณากรอกนามสกุล";
                                    }
                                    return null;
                                  },
                                  hintText: "นามสกุล",
                                ),
                              ),
                            ],
                          ),
                          // * Phone number
                          KInputFormField(
                            controller: _phoneNumberController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "กรุณากรอกเบอร์โทรศัพท์";
                              }

                              return null;
                            },
                            hintText: "เบอร์โทรศัพท์",
                            inputFormatters: <TextInputFormatter>[
                              phoneNumberMaskFormatter
                            ],
                          ),
                          // * Weight and height
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: KInputFormField(
                                  controller: _weightController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "กรุณากรอกน้ำหนัก (กม.)";
                                    }
                                    return null;
                                  },
                                  hintText: "น้ำหนัก (กม.)",
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPadding,
                              ),
                              Expanded(
                                flex: 1,
                                child: KInputFormField(
                                  controller: _heightController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "กรุณากรอกส่วนสูง (ซม.)";
                                    }
                                    return null;
                                  },
                                  hintText: "ส่วนสูง (ซม.)",
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // * Age and birthday
                          context.isPhone
                              ? Column(
                                  children: [
                                    KInputFormField(
                                      controller: _ageController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "กรุณากรอกอายุ";
                                        }
                                        return null;
                                      },
                                      hintText: "อายุ",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    SizedBox(
                                      width: kDefaultPadding,
                                    ),
                                    KInputFormField(
                                      hintText: "วันเดือนปีเกิด (วว-ดด-ปปปป)",
                                      controller: _birthdayController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "กรุณากรอกวันเดือนปีเกิด";
                                        }
                                        return null;
                                      },
                                      inputFormatters: [birthdayMaskFormatter],
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: KInputFormField(
                                        controller: _ageController,
                                        hintText: "อายุ",
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "กรุณากรอกอายุ";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: kDefaultPadding,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: KInputFormField(
                                        hintText: "วันเดือนปีเกิด (วว-ดด-ปปปป)",
                                        controller: _birthdayController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "กรุณากรอกวันเดือนปีเกิด";
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          birthdayMaskFormatter
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          // * Address
                          KInputFormField(
                            hintText: "ที่อยู่ปัจจุบัน",
                            maxLines: 2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "กรุณากรอกที่อยู่ปัจจุบัน";
                              }
                              return null;
                            },
                          ),
                          // * Address default
                          KInputFormField(
                            hintText: "ภูมิลำเนา (ตามบัตรประชาชน)",
                            maxLines: 2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "กรุณากรอกภูมิลำเนา (ตามบัตรประชาชน)";
                              }
                              return null;
                            },
                          ),
                          // * ช่วยเหลือตัวเองได้หรือไม่ *
                          // * (data0)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ผู้ป่วยช่วยเหลือตัวเองได้หรือไม่ (จำเป็น)",
                                  style: context.textTheme.subtitle1,
                                ),
                                Column(
                                  children: List.generate(
                                    _initData0.length,
                                    (index) => _myRadioButton(
                                      groupValue: _data0,
                                      title: _initData0["$index"]!,
                                      value: index,
                                      onChanged: (val) =>
                                          setState(() => _data0 = val!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // * ผู้ป่วยอยู่ในพื้นที่จังหวัดศรีสะเกษหรือไม่
                          // * (data1)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ผู้ป่วยอยู่ในพื้นที่จังหวัดศรีสะเกษหรือไม่ (จำเป็น)",
                                  style: context.textTheme.subtitle1,
                                ),
                                Column(
                                  children: List.generate(
                                    _initData1.length,
                                    (index) => _myRadioButton(
                                      groupValue: _data1,
                                      title: _initData1["$index"]!,
                                      value: index,
                                      onChanged: (val) =>
                                          setState(() => _data1 = val!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // * ผู้ป่วยมีอาการหอบเหนื่อย หายใจเร็ว หายใจไม่สะดวก หรือปอดติดเชื้อหรือไม่
                          // * (data2)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ผู้ป่วยมีอาการหอบเหนื่อย หายใจเร็ว หายใจไม่สะดวก หรือปอดติดเชื้อหรือไม่ (จำเป็น)",
                                  style: context.textTheme.subtitle1,
                                ),
                                Column(
                                  children: List.generate(
                                    _initData2.length,
                                    (index) => _myRadioButton(
                                      groupValue: _data2,
                                      title: _initData2['$index']!,
                                      value: index,
                                      onChanged: (val) =>
                                          setState(() => _data2 = val!),
                                    ),
                                  ).toList(),
                                ),
                              ],
                            ),
                          ),

                          // * อาการเจ็บป่วยเบื้องต้น *
                          // * (data3)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "อาการเจ็บป่วยเบื้องต้น",
                                  style: context.textTheme.subtitle1,
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(8.0),
                                    children: _data3.keys
                                        .map((k) => CheckboxListTile(
                                              title: Text(
                                                _initData3["$k"]!,
                                                style: context.isPhone
                                                    ? context
                                                        .textTheme.subtitle2
                                                    : context
                                                        .textTheme.subtitle1!
                                                        .copyWith(
                                                            color:
                                                                Colors.black54),
                                              ),
                                              value: _data3[k],
                                              onChanged: (val) {
                                                setState(() {
                                                  _data3[k] = val!;
                                                });
                                              },
                                            ))
                                        .toList())
                              ],
                            ),
                          ),

                          // * // โรคที่เพิ่มความเสี่ยง
                          // * เลือกตัวเลือกที่ใช่ทั้งหมด
                          // * (data4)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "โรคที่เพิ่มความเสี่ยง",
                                  style: context.textTheme.subtitle1,
                                ),
                                Text(
                                  "เลือกตัวเลือกที่ใช่ทั้งหมด",
                                  style: context.textTheme.subtitle2,
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(8.0),
                                    children: _data4.keys
                                        .map((k) => CheckboxListTile(
                                              title: Text(
                                                _initData4["$k"]!,
                                                style: context.isPhone
                                                    ? context
                                                        .textTheme.subtitle2
                                                    : context
                                                        .textTheme.subtitle1!
                                                        .copyWith(
                                                            color:
                                                                Colors.black54),
                                              ),
                                              value: _data4[k],
                                              onChanged: (val) {
                                                setState(() {
                                                  _data4[k] = val!;
                                                });
                                              },
                                            ))
                                        .toList())
                              ],
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding * 2,
                            child: Divider(),
                          ),

                          // * Note
                          Text(
                            "บันทึกเพิ่มเติม (ถ้ามี)",
                            style: context.textTheme.subtitle1,
                          ),
                          KInputFormField(
                            hintText: "บันทึกเพิ่มเติม...",
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Text(
                            "ชื่อ Line ผู้ประสานงาน",
                            style: context.textTheme.subtitle1,
                          ),
                          Text(
                            "ใช้สำหรับกรณี ทางจังหวัดต้องการติดต่อผู้ป่วย จะได้สามารถ tag ชื่อในไลน์เพื่อติดต่อได้",
                            style: context.textTheme.subtitle2,
                          ),
                          // * ชื่อ Line ผู้ประสานงาน
                          KInputFormField(
                            hintText: "ชื่อ Line ผู้ประสานงาน",
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "สถานะผู้ป่วย",
                                style: context.textTheme.headline6,
                              ),
                            ],
                          ),

                          // * Add status
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                    value: _status,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    onChanged: _onChangedCheckbox),
                                Icon(
                                  Icons.circle,
                                  color: Colors.green.shade400,
                                ),
                                SizedBox(width: 8),
                                Text('ผู้ป่วยเสี่ยง'),
                                SizedBox(
                                  width: kDefaultPadding * 2,
                                ),
                                Checkbox(
                                    value: !_status,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    onChanged: _onChangedCheckbox),
                                Icon(
                                  Icons.circle,
                                  color: Colors.yellow.shade400,
                                ),
                                SizedBox(width: 8),
                                Text('ผู้ป่วยเริ่มมีอาการ')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding * 3,
                            child: Text(
                              "* หมายเหตุ กรุณาตรวจสอบข้อมูลให้ถูกต้องอย่างครบถ้วน",
                              style: context.textTheme.subtitle1!
                                  .copyWith(color: Colors.grey[500]),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: KButtonOutlined(
                                  text: "ยกเลิก",
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPadding,
                              ),
                              Expanded(
                                flex: 1,
                                child: KButton(
                                  text: "บันทึก",
                                  onPressed: () {
                                    _onSubmit();
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding * 2,
                          ),
                          Divider(),
                          SizedBox(
                            height: kDefaultPadding * 2,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
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
