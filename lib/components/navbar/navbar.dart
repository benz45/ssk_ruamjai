import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/navbar/navbar_menu.dart';
import 'package:ssk_ruamjai/components/navbar/navbar_title.dart';
import 'package:ssk_ruamjai/controllers/navbar_menu_controller.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class NavBar extends GetView<NavBarMenuController> {
  get navBarHeight => 120.0;

  @override
  Widget build(BuildContext context) {
    final _navIconMenu = AnimateIcons(
      startIcon: Icons.drag_handle,
      endIcon: Icons.close_sharp,
      controller: controller.getControllerAnimateIcons,
      duration: Duration(milliseconds: 190),
      size: 25.0,
      startIconColor: Colors.black38,
      endIconColor: Colors.black38,
      clockwise: false,
      onEndIconPress: () => true,
      onStartIconPress: () {
        controller.onDrawer();
        return true;
      },
    );
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      expandedHeight: navBarHeight,
      collapsedHeight: navBarHeight,
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: kMaxWidth),
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveValue(
                    desktop: kDefaultPadding * 4,
                    tablet: kDefaultPadding,
                    mobile: kDefaultPadding)!,
                vertical: kDefaultPadding,
              ),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: context.responsiveValue(
                    desktop: MainAxisAlignment.center,
                    tablet: MainAxisAlignment.spaceBetween,
                    mobile: MainAxisAlignment.spaceBetween,
                  )!,
                  children: [
                    NavBarTitle(),
                    Spacer(),
                    context.responsiveValue(
                      desktop: NavBarMenu(),
                      tablet: _navIconMenu,
                      mobile: _navIconMenu,
                    )!,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
