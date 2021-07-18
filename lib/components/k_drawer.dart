import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/navbar/navbar_menu.dart';
import 'package:ssk_ruamjai/controllers/navbar_menu_controller.dart';

class KDrawer extends GetWidget<NavBarMenuController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              controller.getMenuItems.length,
              (index) => NavBarMenuItem(
                text: controller.getMenuItems[index],
                onPress: () => controller.setSelectedIndex(index),
                isActive: index == controller.getSelectedIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
