import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/k_progress.dart';
import 'package:ssk_ruamjai/controllers/hospital.controller.dart';
import 'package:ssk_ruamjai/controllers/user.controller.dart';
import 'package:ssk_ruamjai/model/hospital.model.dart';
import 'package:ssk_ruamjai/screens/inside_district_screen/inside_district_screen.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class TableDistrict extends StatefulWidget {
  @override
  _TableDistrictState createState() => _TableDistrictState();
}

class _TableDistrictState extends State<TableDistrict> {
  final _hospitalController = Get.find<HospitalController>();
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // * Loading...
        if (_hospitalController.isLoading) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'กำลังดาวน์โหลดข้อมูล',
                  style: context.textTheme.bodyText2,
                ),
                SizedBox(width: 15),
                SizedBox(child: KProgress(), width: 18, height: 18)
              ],
            ),
          );
        }

        // * Not yet data
        if (!_hospitalController.isLoading &&
            _hospitalController.allDistrict != null &&
            _hospitalController.allDistrict!.length == 0) {
          return Text(notFound);
        }

        // * Use all district
        final allDistrict = _hospitalController.allDistrict;

        return Table(
          border: TableBorder.all(color: kDisabledPrimaryColor.withOpacity(.5)),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            1: FractionColumnWidth(.3),
          },
          children: [
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
                    "เขต",
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
                    "จำนวนเตียงทั้งหมด",
                    style: context.textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (_hospitalController.allDistrict != null)
              if (_hospitalController.allDistrict!.length > 0)
                for (var i = 0;
                    i < _hospitalController.allDistrict!.length;
                    i++)
                  TableRow(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      border: Border.all(
                        color: kDisabledPrimaryColor.withOpacity(.5),
                      ),
                    ),
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            '${InsideDistrictScreen.routeName}/${allDistrict![i].name}',
                            arguments: allDistrict[i].name,
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          alignment: Alignment.center,
                          height: 64,
                          color: Colors.white,
                          child: Text(
                            "${districtValues.reverse![allDistrict![i].name]}",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: allDistrict[i].name ==
                                    _userController.getDistrictUser()
                                ? TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)
                                : TextStyle(
                                    color: Colors.black87,
                                  ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            '${InsideDistrictScreen.routeName}/${allDistrict[i].name}',
                            arguments: allDistrict[i].name,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 64,
                          color: Colors.white,
                          child: Text(
                            "${allDistrict[i].totalBed!}",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: allDistrict[i].name ==
                                    _userController.getDistrictUser()
                                ? TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)
                                : TextStyle(
                                    color: Colors.black87,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
