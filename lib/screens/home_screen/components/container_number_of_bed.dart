import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class ContainerNumberOfBed extends StatelessWidget {
  final _listData = [
    NumberOfBed(
      title: "จำนวนเตียงในห้อง ICU",
      value: 10,
    ),
    SizedBox(
      height: kDefaultPadding,
    ),
    NumberOfBed(
      title: "จำนวนเตียงในโรงพยาบาล",
      value: 10,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final desktop = Container(
      width: context.width * .4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _listData,
      ),
    );
    final tablet = Container(
      width: context.width * .7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _listData,
      ),
    );

    return Column(
      children: [
        Text(
          "จำนวนเตียงที่ว่างทั้งหมด",
          style: context.responsiveValue(
              desktop: context.textTheme.headline4,
              tablet: context.textTheme.headline4,
              mobile: context.textTheme.headline5),
        ),
        // * Result Number
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
          child: Text(
            "245",
            style:
                context.textTheme.headline2!.copyWith(color: Colors.blue[400]),
          ),
        ),
        context.responsiveValue(
            desktop: desktop, tablet: tablet, mobile: tablet)!
      ],
    );
  }
}

class NumberOfBed extends StatelessWidget {
  const NumberOfBed({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    final _desktop = Column(
      children: [
        Text(
          '$value',
          style: context.textTheme.headline4!
              .copyWith(color: Colors.blue.shade400),
        ),
        Text(
          title,
          style: context.textTheme.headline6!.copyWith(color: Colors.black54),
        )
      ],
    );

    final _tablet = Container(
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.headline6!.copyWith(color: Colors.black54),
          ),
          Text(
            '$value',
            style: context.textTheme.headline6!
                .copyWith(color: Colors.blue.shade400),
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
