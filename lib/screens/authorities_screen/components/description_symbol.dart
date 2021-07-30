import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class DescriptionSymbol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    paddingContainer(Row row) {
      return Padding(
        padding: context.responsiveValue(
              desktop: EdgeInsets.only(
                  right: kDefaultPadding, bottom: kDefaultPadding),
            ) ??
            EdgeInsets.only(bottom: kDefaultPadding),
        child: row,
      );
    }

    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: context.responsiveValue(
            desktop: Axis.horizontal,
          ) ??
          Axis.vertical,
      children: [
        paddingContainer(
          Row(
            children: [
              Text(
                "S = สถานะของผู้ป่วย",
                style: context.textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        paddingContainer(
          Row(
            children: [
              Text(
                "B = สถานะรับเข้าผู้ป่วย",
                style: context.textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        paddingContainer(
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Icon(
                  Icons.bed_outlined,
                  color: kSuccessColor,
                  size: 18,
                ),
              ),
              Text(
                " = ผู้ป่วยได้รับเตียงแล้ว",
                style: context.textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        paddingContainer(
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Icon(
                  Icons.access_time,
                  color: Colors.black54,
                  size: 18,
                ),
              ),
              Text(
                " = ผู้ป่วยกำลังรอเตียง",
                style: context.textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
