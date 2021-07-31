import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/buttons/k_text_link.dart';
import 'package:ssk_ruamjai/controllers/hospital.controller.dart';
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

  final _hospitalController = Get.find<HospitalController>();

  final String defaultFirstItemDropdown = 'ทั้งหมด';

  // District value dropdown
  late String _districtDropdown;

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

    _districtDropdown = defaultFirstItemDropdown;
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
                            style: context.textTheme.headline5!
                                .copyWith(color: kPrimaryColor),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "สถานะเตียง",
                            style: context.textTheme.headline6,
                          ),
                          // * Total bad district
                          Obx(() {
                            final totalBad = _hospitalController
                                .getTotalBadFromDistrict(_district);
                            return Text(
                              "$totalBad",
                              style: context.textTheme.headline6!
                                  .copyWith(color: kSuccessColor),
                            );
                          })
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: kDefaultPadding * 4, child: Divider()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        value: _districtDropdown,
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
                          if (newValue != _districtDropdown)
                            setState(() {
                              _districtDropdown = newValue!;
                            });
                        },
                        items: itemsDropdownHospitalType(),
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding),

                  // * Table hospital
                  TableInsideDistrict(
                    districtUser: _district,
                    sort: _districtDropdown != defaultFirstItemDropdown
                        ? _hospitalController
                                .getHospitalTypeFromString(_districtDropdown) ??
                            null
                        : null,
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
