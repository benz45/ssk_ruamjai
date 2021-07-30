import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/screens/details_patient/details_patient.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class TableHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: kDisabledPrimaryColor.withOpacity(.5)),
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
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
    );
  }
}
