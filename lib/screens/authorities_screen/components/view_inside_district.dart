import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/controllers/hospital.controller.dart';
import 'package:ssk_ruamjai/controllers/user.controller.dart';
import 'package:ssk_ruamjai/screens/authorities_screen/components/table_inside_district.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class ViewInsideDistrict extends StatefulWidget {
  @override
  _ViewInsideDistrictState createState() => _ViewInsideDistrictState();
}

class _ViewInsideDistrictState extends State<ViewInsideDistrict>
    with TickerProviderStateMixin {
  final _userController = Get.find<UserController>();
  final _hospitalController = Get.find<HospitalController>();

  final String defaultFirstItemDropdown = 'ทั้งหมด';

  itemsDropdownHospitalType() {
    final _listHospitalType =
        _hospitalController.getAllHospitalType().values.toList();
    _listHospitalType.insert(0, defaultFirstItemDropdown);

    return _listHospitalType.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  // District value dropdown
  late String _district;

  @override
  void initState() {
    super.initState();
    _district = defaultFirstItemDropdown;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: kDefaultPadding * 4,
          child: Divider(),
        ),
        // * จำนวนเตียง
        // ValueBuilder(
        //   initialValue: false,
        //   builder: (bool? value, Function(bool)? update) {
        //     return Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   "จำนวนเตียง",
        //                   style: context.textTheme.headline6,
        //                 ),
        //                 Text(
        //                   "10",
        //                   style: context.textTheme.headline6!
        //                       .copyWith(color: kSuccessColor),
        //                 ),
        //               ],
        //             ),
        //             Spacer(),
        //             AnimatedOpacity(
        //               opacity: value! ? 0 : 1,
        //               duration: Duration(milliseconds: 300),
        //               child: Container(
        //                 width: context.responsiveValue(
        //                   desktop: kDefaultPadding * 10,
        //                   tablet: kDefaultPadding * 10,
        //                   mobile: kDefaultPadding * 6,
        //                 ),
        //                 child: KButtonOutlined(
        //                   text: 'แก้ไข',
        //                   onPressed: () {
        //                     update!(true);
        //                   },
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //         AnimatedSizeAndFade.showHide(
        //           vsync: this,
        //           show: value,
        //           fadeDuration: const Duration(milliseconds: 300),
        //           sizeDuration: const Duration(milliseconds: 300),
        //           fadeInCurve: Curves.fastOutSlowIn,
        //           fadeOutCurve: Curves.fastOutSlowIn,
        //           child: Column(
        //             children: [
        //               KInputField(
        //                 hintText: "จำนวนเตียง",
        //               ),
        //               Row(
        //                 children: [
        //                   Expanded(
        //                     flex: 1,
        //                     child: KButtonOutlined(
        //                       text: 'ยกเลิก',
        //                       onPressed: () {
        //                         update!(false);
        //                       },
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     width: kDefaultPadding,
        //                   ),
        //                   Expanded(
        //                     flex: 1,
        //                     child: KButton(
        //                       text: 'บันทึก',
        //                       onPressed: () {},
        //                     ),
        //                   ),
        //                 ],
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        // ),

        ValueBuilder(
          initialValue: false,
          builder: (bool? value, Function(bool)? _onUpdate) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "รายการศูนย์รักษา",
                          style: context.textTheme.headline6,
                        ),
                        Text(
                          value!
                              ? "จังหวัดศรีสะเกษ"
                              : "เขต${_userController.getDistrictUserString()}",
                          style: context
                              .responsiveValue(
                                desktop: context.textTheme.headline5,
                                tablet: context.textTheme.headline6,
                                mobile: context.textTheme.subtitle1,
                              )!
                              .copyWith(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    Spacer(),
                    // if (!value)
                    // Container(
                    //   width: context.responsiveValue(
                    //     desktop: kDefaultPadding * 10,
                    //     tablet: kDefaultPadding * 10,
                    //     mobile: kDefaultPadding * 6,
                    //   ),
                    //   child: KButton(
                    //     text: value ? 'ย้อนกลับ' : 'ดูทั้งหมด',
                    //     onPressed: () {
                    //       _onUpdate!(!value);
                    //     },
                    //   ),
                    // )
                    DropdownButton<String>(
                      value: _district,
                      icon: Icon(Icons.arrow_downward_outlined),
                      elevation: 16,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: context.textTheme.subtitle1!.fontSize,
                      ),
                      underline: Container(
                        height: 2,
                        color: kPrimaryColor,
                      ),
                      onChanged: (newValue) {
                        if (newValue != _district)
                          setState(() {
                            _district = newValue!;
                          });
                      },
                      items: itemsDropdownHospitalType(),
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding * 4,
                  child: Divider(),
                ),
                // * สถานะเตียง
                Obx(
                  () => Row(
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
                            _district,
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
                      Text(
                        "${value ? _hospitalController.getAllTotalBad : _hospitalController.getTotalBadFromDistrict(_userController.getDistrictUser())}",
                        style: context.textTheme.headline6!
                            .copyWith(color: kSuccessColor),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: kDefaultPadding,
                ),

                // // * อธิบายสัญญาลักษ์ต่าง ๆ บนตาราง
                // DescriptionSymbol(),

                SizedBox(
                  height: kDefaultPadding,
                ),

                TableInsideDistrict(
                  districtUser: _userController.getDistrictUser(),
                  sort: _district != defaultFirstItemDropdown
                      ? _hospitalController
                              .getHospitalTypeFromString(_district) ??
                          null
                      : null,
                ),
              ],
            );
          },
        ),

        SizedBox(
          height: kDefaultPadding * 5,
        ),
      ],
    );
  }
}
