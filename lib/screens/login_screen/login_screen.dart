import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/navbar/navbar.dart';
import 'package:ssk_ruamjai/screens/login_screen/components/content_login.dart';
import 'package:ssk_ruamjai/screens/login_screen/components/content_login_title.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double maxWidth = kDefaultPadding * 4;
    Container desktop = Container(
      height: context.height - NavBar().navBarHeight,
      padding: EdgeInsets.only(
          bottom: NavBar().navBarHeight, right: maxWidth, left: maxWidth),
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContentLoginTitle(),
          ContentLogin(),
        ],
      ),
    );

    Container tablet = Container(
      height: context.height - NavBar().navBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContentLoginTitle(),
          ContentLogin(),
        ],
      ),
    );

    return context.responsiveValue(
      desktop: desktop,
      tablet: tablet,
      mobile: tablet,
    )!;
  }
}
