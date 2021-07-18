import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class ContainerNumberOfColor extends StatelessWidget {
  final _listData = [
    NumberOfColor(
      color: Colors.green.shade400,
      title: "ผู้ป่วยเสี่ยง",
      value: 100,
    ),
    SizedBox(
      width: kDefaultPadding * 2.5,
      height: kDefaultPadding,
    ),
    NumberOfColor(
      color: Colors.yellow.shade400,
      title: "ผู้ป่วยเริ่มมีอาการ",
      value: 234,
    ),
    SizedBox(
      width: kDefaultPadding * 2.5,
      height: kDefaultPadding,
    ),
    NumberOfColor(
      color: Colors.red.shade400,
      title: "ผู้ป่วยอาการแย่ลง",
      value: 501,
    ),
    SizedBox(
      width: kDefaultPadding * 2.5,
      height: kDefaultPadding,
    ),
    NumberOfColor(
      color: Colors.red.shade800,
      title: "ผู้ป่วยอาการหนัก",
      value: 20,
    ),
    SizedBox(
      width: kDefaultPadding * 2.5,
      height: kDefaultPadding,
    ),
    NumberOfColor(
      color: Colors.pink.shade300,
      title: "ผู้ป่วยอาการดีขึ้น",
      value: 40,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Row desktop = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _listData,
    );

    Column tablet = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _listData,
    );
    return context.responsiveValue(
      desktop: desktop,
      tablet: tablet,
      mobile: tablet,
    )!;
  }
}

class NumberOfColor extends StatelessWidget {
  const NumberOfColor({
    Key? key,
    required this.color,
    required this.title,
    required this.value,
  }) : super(key: key);
  final Color color;
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    final _desktop = Column(
      children: [
        Text(
          '+$value',
          style: context.textTheme.headline4!.copyWith(color: Colors.black54),
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              color: color,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            )
          ],
        ),
      ],
    );

    final _tablet = Container(
      width: context.width * .7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                color: color,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              )
            ],
          ),
          Text(
            '+$value',
            style: context.textTheme.headline6!.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );

    return context.responsiveValue(
      desktop: _desktop,
      tablet: _tablet,
      mobile: _tablet,
    )!;
  }
}
