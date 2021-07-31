import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/screens/authorities_screen/components/user_detail.dart';
import 'package:ssk_ruamjai/screens/authorities_screen/components/view_all_district.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class Authorities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      padding: EdgeInsets.symmetric(
          horizontal: context.isPhone ? kDefaultPadding : kDefaultPadding * 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: kDefaultPadding * 2),
          // * Authoritie user detail
          UserDetail(),

          // * View detail district
          ViewAllDistrict(),

          SizedBox(
            height: kDefaultPadding * 5,
          ),
        ],
      ),
    );
  }
}
