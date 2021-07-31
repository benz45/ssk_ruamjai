import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/buttons/k_text_link.dart';
import 'package:ssk_ruamjai/controllers/user.controller.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class UserDetail extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    controller.getUser.profile?.firstName ?? notFound,
                    style: context.textTheme.headline6,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    controller.getUser.profile?.lastName ?? notFound,
                    style: context.textTheme.headline6,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                controller.getUser.account?.username ?? notFound,
                style: context.textTheme.subtitle2,
              ),
              Text(
                controller.getUser.profile?.office ?? notFound,
                style: context.textTheme.subtitle2,
              ),
              if (context.isPhone) ...{
                SizedBox(height: kDefaultPadding),
                KTextLink(
                  text: 'ออกจากระบบ',
                  onPressed: () {
                    controller.logout();
                  },
                )
              }
            ],
          ),
          if (!context.isPhone) ...{
            Spacer(),
            KTextLink(
              text: 'ออกจากระบบ',
              onPressed: () {
                controller.logout();
              },
            )
          }
        ],
      ),
    );
  }
}
