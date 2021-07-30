import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/buttons/k_text_link.dart';
import 'package:ssk_ruamjai/main.dart';
import 'package:ssk_ruamjai/model/hospital.model.dart';
import 'package:ssk_ruamjai/screens/authorities_screen/components/table_inside_district.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class InsideDistrictScreen extends StatefulWidget {
  static const routeName = '/inside_district';

  @override
  _InsideDistrictScreenState createState() => _InsideDistrictScreenState();
}

class _InsideDistrictScreenState extends State<InsideDistrictScreen>
    with TickerProviderStateMixin {
  late District _district;

  @override
  void initState() {
    super.initState();
    if (Get.routing.route!.isFirst) {
      final routeDistrict =
          Get.routing.current.split('${InsideDistrictScreen.routeName}/').last;
      final convertDistrict =
          District.values.firstWhere((e) => '$e' == routeDistrict);

      _district = convertDistrict;
    } else {
      _district = Get.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: context.width,
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: kMaxWidth),
              padding: EdgeInsets.symmetric(
                  horizontal:
                      context.isPhone ? kDefaultPadding : kDefaultPadding * 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kDefaultPadding * 4,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: kPrimaryColor,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      KTextLink(
                        onPressed: () {
                          if (Get.routing.route!.isFirst) {
                            Get.toNamed(Operation.routeName);
                          } else {
                            Get.back();
                          }
                        },
                        text: 'ย้อนกลับ',
                      )
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 4, child: Divider()),
                  // * สถานะเตียง
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "รายการศูนย์รักษา",
                            style: context.textTheme.headline6,
                          ),
                          Text(
                            "ภายในอำเภอ${districtValues.reverse![_district]}",
                            style: context.textTheme.headline6!
                                .copyWith(color: kPrimaryColor),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // TODO
                          Text(
                            "สถานะเตียง",
                            style: context.textTheme.headline6,
                          ),
                          // * Total bad district
                          // Obx(() {
                          //   // final totalBad = _hospitalController
                          //   return Text(
                          //     "ทั้งหมด 30, เหลือ 10",
                          //     style: context.textTheme.headline6!
                          //         .copyWith(color: kSuccessColor),
                          //   );
                          // })
                          Text(
                            "ทั้งหมด 30, เหลือ 10",
                            style: context.textTheme.headline6!
                                .copyWith(color: kSuccessColor),
                          )
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: kDefaultPadding,
                  ),

                  // * Table hospital
                  // TableHospital(),
                  // TableDistrict(),
                  TableInsideDistrict(districtUser: _district),

                  SizedBox(
                    height: kDefaultPadding,
                  ),

                  SizedBox(
                    height: kDefaultPadding * 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
