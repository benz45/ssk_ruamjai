import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/buttons/k_button.dart';
import 'package:ssk_ruamjai/components/buttons/k_button_outlined.dart';
import 'package:ssk_ruamjai/components/input_text/k_input_field.dart';
import 'package:ssk_ruamjai/screens/details_patient/details_patient.dart';
import 'package:ssk_ruamjai/screens/form_add_patient/form_add_patient.dart';
import 'package:ssk_ruamjai/util/constants.dart';

// ! หน้าสำหรับเจ้าหน้าที่ โรงพยาบาลสนาม
class AuthoritiesLevelTwo extends StatefulWidget {
  @override
  _AuthoritiesLevelTwoState createState() => _AuthoritiesLevelTwoState();
}

class _AuthoritiesLevelTwoState extends State<AuthoritiesLevelTwo>
    with TickerProviderStateMixin {
  // ว่าง = true
  // ไม่ว่าง = false
  bool _statusBadValue = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      padding: EdgeInsets.symmetric(
          horizontal: context.isPhone ? kDefaultPadding : kDefaultPadding * 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: kDefaultPadding * 2,
          ),
          // * Authoritie detail
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "นายวีระพันธ์ บุญบุตร",
                    style: context.textTheme.headline6,
                  ),
                  Text(
                    "เจ้าหน้าที่โรงพยาบาลสนาม อ.กันทรลักษ์",
                    style: context.textTheme.subtitle1,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: kDefaultPadding * 4,
            child: Divider(),
          ),
          // * สถานะเตียง
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "สถานะเตียง",
                    style: context.textTheme.headline6,
                  ),
                  Text(
                    "ว่าง",
                    style: context.textTheme.headline6!
                        .copyWith(color: kSuccessColor),
                  ),
                ],
              ),
              Spacer(),
              CupertinoSwitch(
                value: _statusBadValue,
                onChanged: (value) {
                  setState(() {
                    _statusBadValue = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding * 4,
            child: Divider(),
          ),
          // * จำนวนเตียง
          ValueBuilder(
            initialValue: false,
            builder: (bool? value, Function(bool)? update) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "จำนวนเตียง",
                            style: context.textTheme.headline6,
                          ),
                          Text(
                            "10",
                            style: context.textTheme.headline6!
                                .copyWith(color: kSuccessColor),
                          ),
                        ],
                      ),
                      Spacer(),
                      AnimatedOpacity(
                        opacity: value! ? 0 : 1,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          width: context.responsiveValue(
                            desktop: kDefaultPadding * 10,
                            tablet: kDefaultPadding * 10,
                            mobile: kDefaultPadding * 6,
                          ),
                          child: KButtonOutlined(
                            text: 'แก้ไข',
                            onPressed: () {
                              update!(true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  AnimatedSizeAndFade.showHide(
                    vsync: this,
                    show: value,
                    fadeDuration: const Duration(milliseconds: 300),
                    sizeDuration: const Duration(milliseconds: 300),
                    fadeInCurve: Curves.fastOutSlowIn,
                    fadeOutCurve: Curves.fastOutSlowIn,
                    child: Column(
                      children: [
                        KInputField(
                          hintText: "จำนวนเตียง",
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: KButtonOutlined(
                                text: 'ยกเลิก',
                                onPressed: () {
                                  update!(false);
                                },
                              ),
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                            ),
                            Expanded(
                              flex: 1,
                              child: KButton(
                                text: 'บันทึก',
                                onPressed: () {},
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          // * แกไข จำนวนเตียง
          SizedBox(
            height: kDefaultPadding * 4,
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "รายชื่อผู้ป่วยทั้งหมด",
                    style: context.textTheme.headline6,
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
              Spacer(),
              // if (!value)
              Container(
                width: context.responsiveValue(
                  desktop: kDefaultPadding * 10,
                  tablet: kDefaultPadding * 10,
                  mobile: kDefaultPadding * 6,
                ),
                child: KButton(
                  text: 'เพิ่มผู้ป่วย',
                  onPressed: () {
                    Get.toNamed(FormAddPatient.routeName);
                  },
                ),
              )
            ],
          ),
          // * อธิบายสัญญาลักษ์ต่าง ๆ บนตาราง
          DescriptionSymbol(),

          Table(
            border:
                TableBorder.all(color: kDisabledPrimaryColor.withOpacity(.5)),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              2: FractionColumnWidth(.5),
              3: FractionColumnWidth(.3),
            },
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kDisabledPrimaryColor.withOpacity(.5),
                  ),
                ),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Text(
                      "S",
                      style: context.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Text(
                      "B",
                      style: context.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Text(
                      "ชื่อ-นามสกุล",
                      style: context.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Text(
                      "เบอร์โทรศัพท์",
                      style: context.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  border: Border.all(
                    color: kDisabledPrimaryColor.withOpacity(.5),
                  ),
                ),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Icon(
                      Icons.circle,
                      color: Colors.yellow.shade400,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Icon(
                      Icons.bed_outlined,
                      color: kSuccessColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(DetailPatient.routeName);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      alignment: Alignment.center,
                      height: 64,
                      color: Colors.white,
                      child: Text(
                        "วีระพันธ์  บุญบุตร",
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Text(
                      "0999999999",
                      softWrap: false,
                    ),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  border: Border.all(
                    color: kDisabledPrimaryColor.withOpacity(.5),
                  ),
                ),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Icon(
                      Icons.circle,
                      color: Colors.yellow.shade400,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Icon(
                      Icons.access_time,
                      color: Colors.black54,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(DetailPatient.routeName);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      alignment: Alignment.center,
                      height: 64,
                      color: Colors.white,
                      child: Text(
                        "วีระพันธ์  บุญบุตร",
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 64,
                    color: Colors.white,
                    child: Text(
                      "0999999999",
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding * 5,
          ),
        ],
      ),
    );
  }
}

class DescriptionSymbol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(
        children: [
          Text(
            "S = สถานะของผู้ป่วย",
            style: context.textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: kDefaultPadding),
          Text(
            "B = สถานะรับเข้าผู้ป่วย",
            style: context.textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: kDefaultPadding),
          Container(
            alignment: Alignment.center,
            height: 64,
            color: Colors.white,
            child: Icon(
              Icons.bed_outlined,
              color: kSuccessColor,
            ),
          ),
          Text(
            " = ผู้ป่วยได้รับเตียงแล้ว",
            style: context.textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: kDefaultPadding),
          Container(
            alignment: Alignment.center,
            height: 64,
            color: Colors.white,
            child: Icon(
              Icons.access_time,
              color: Colors.black54,
            ),
          ),
          Text(
            " = ผู้ป่วยกำลังรอเตียง",
            style: context.textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
