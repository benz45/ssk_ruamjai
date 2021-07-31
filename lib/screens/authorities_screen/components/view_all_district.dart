import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/controllers/hospital.controller.dart';
import 'package:ssk_ruamjai/screens/authorities_screen/components/table_district.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class ViewAllDistrict extends StatefulWidget {
  @override
  _ViewAllDistrictState createState() => _ViewAllDistrictState();
}

class _ViewAllDistrictState extends State<ViewAllDistrict> {
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
        Column(
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
                      "จังหวัดศรีสะเกษ",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "สถานะเตียง",
                      style: context.textTheme.headline6,
                    ),
                    Obx(() => Text(
                          "${_hospitalController.getAllTotalBad}",
                          style: context
                              .responsiveValue(
                                desktop: context.textTheme.headline6,
                                tablet: context.textTheme.headline6,
                                mobile: context.textTheme.subtitle1,
                              )!
                              .copyWith(color: kPrimaryColor),
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            // * สถานะเตียง
            // TODO:
            // Obx(
            //   () => Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Text(
            //             "สถานะเตียง",
            //             style: context.textTheme.headline6,
            //           ),
            //           Text(
            //             _district,
            //             style: context
            //                 .responsiveValue(
            //                   desktop: context.textTheme.headline6,
            //                   tablet: context.textTheme.headline6,
            //                   mobile: context.textTheme.subtitle1,
            //                 )!
            //                 .copyWith(color: kPrimaryColor),
            //           ),
            //         ],
            //       ),
            //       Spacer(),
            //       // TODO: count total bad
            //       // Text(
            //       //   "${value ? _hospitalController.getAllTotalBad : _hospitalController.getTotalBadFromDistrict(_userController.getDistrictUser())}",
            //       //   style: context.textTheme.headline6!
            //       //       .copyWith(color: kSuccessColor),
            //       // )
            //     ],
            //   ),
            // ),

            SizedBox(
              height: kDefaultPadding,
            ),

            // * Table hospital

            // สำหรับดูทั้งหมด
            // TableHospital(),

            // สำหรับแยกเป็นอำเภอ
            TableDistrict(),
          ],
        ),
        SizedBox(
          height: kDefaultPadding * 5,
        ),
      ],
    );
  }
}
