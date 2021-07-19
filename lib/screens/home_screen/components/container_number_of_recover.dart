import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerNumberOfRecover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "จำนวนผู้ป่วยที่หายแล้ววันนี้",
          style: context.responsiveValue(
            desktop: context.textTheme.headline4,
            tablet: context.textTheme.headline4,
            mobile: context.textTheme.headline5,
          ),
        ),
        // * Result Number
        Text(
          "+500",
          style:
              context.textTheme.headline2!.copyWith(color: Colors.green[400]),
        ),
      ],
    );
  }
}
