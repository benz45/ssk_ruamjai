import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/controllers/navbar_menu_controller.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class NavBarMenu extends GetWidget<NavBarMenuController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          controller.getMenuItems.length,
          (index) => NavBarMenuItem(
            text: controller.getMenuItems[index],
            onPress: () => controller.setSelectedIndex(index),
            isActive: index == controller.getSelectedIndex,
          ),
        ),
      ),
    );
  }
}

class NavBarMenuItem extends StatelessWidget {
  const NavBarMenuItem({
    Key? key,
    required this.isActive,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final bool isActive;
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.5,
              color: isActive ? kPrimaryColor : Colors.transparent,
            ),
          ),
        ),
        child: Text(
          text,
          style: context.textTheme.bodyText2!.copyWith(
            color: isActive ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }
}
