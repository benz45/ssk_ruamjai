import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/screens/home_screen/components/container_number_of_color.dart';
import 'package:ssk_ruamjai/screens/home_screen/components/container_number_of_recover.dart';
import 'package:ssk_ruamjai/util/constants.dart';

import 'components/container_number_of_bed.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Column(
        children: [
          SizedBox(
            height: kDefaultPadding * 2,
          ),
          Text(
            "จำนวนผู้ป่วยเพิ่มขึ้นวันนี้",
            style: context.textTheme.headline4,
          ),
          // * Time of result
          Text(
            "ข้อมูล ณ เวลา 13.40 น.",
            style: context.textTheme.subtitle1!.copyWith(color: Colors.black54),
          ),
          SizedBox(
            height: kDefaultPadding * 2,
          ),
          // * Result Number
          Text(
            "+1000",
            style:
                context.textTheme.headline1!.copyWith(color: Colors.red[400]),
          ),
          SizedBox(
            height: kDefaultPadding * 3,
          ),
          // * Number of color
          ContainerNumberOfColor(),
          SizedBox(
            height: kDefaultPadding * 10,
            child: Divider(),
          ),
          // * Container number of recover
          ContainerNumberOfRecover(),
          SizedBox(
            height: kDefaultPadding * 10,
            child: Divider(),
          ),
          // * Container number of bed
          ContainerNumberOfBed(),
          SizedBox(
            height: kDefaultPadding * 10,
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
