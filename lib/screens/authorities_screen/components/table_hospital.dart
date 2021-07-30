import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/k_progress.dart';
import 'package:ssk_ruamjai/controllers/hospital.controller.dart';
import 'package:ssk_ruamjai/model/hospital.model.dart';
import 'package:ssk_ruamjai/screens/details_patient/details_patient.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class TableHospital extends StatefulWidget {
  @override
  _TableHospitalState createState() => _TableHospitalState();
}

class _TableHospitalState extends State<TableHospital> {
  final _hospitalController = Get.find<HospitalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
      if (!_hospitalController.isLoading &&
          _hospitalController.allHospital != null &&
          _hospitalController.allHospital!.length == 0) {
        return Text(notFound);
      }

      final allHospital = _hospitalController.allHospital;

      return Table(
        border: TableBorder.all(color: kDisabledPrimaryColor.withOpacity(.5)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: FractionColumnWidth(.3),
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
                  "ชื่อ",
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
                  "จำนวนเตียง",
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
          if (_hospitalController.allHospital != null)
            if (_hospitalController.allHospital!.length > 0)
              for (var i = 0; i < _hospitalController.allHospital!.length; i++)
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
                      child: Text(
                        allHospital![i].name!,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 64,
                      color: Colors.white,
                      child: Text(
                        "${districtValues.reverse![allHospital[i].district]}",
                        overflow: TextOverflow.fade,
                        softWrap: false,
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
                          "${allHospital[i].totalBed!}",
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
                        "${allHospital[i].type!}",
                        softWrap: false,
                      ),
                    ),
                  ],
                )
        ],
      );
    });
  }
}
