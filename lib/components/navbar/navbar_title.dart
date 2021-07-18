import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarTitle extends StatelessWidget {
  final ImageProvider logo = AssetImage(
    'assets/images/logo.png',
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        context.responsiveValue(
          desktop: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(image: DecorationImage(image: logo)),
          ),
          tablet: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(image: DecorationImage(image: logo)),
          ),
          mobile: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(image: DecorationImage(image: logo)),
          ),
        )!,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ศรีสะเกษร่วมใจ',
                style: context.textTheme.headline6,
              ),
              Text(
                'ระบบจัดการเตียงผู้ป่วยโควิด 19',
                style: context.textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
