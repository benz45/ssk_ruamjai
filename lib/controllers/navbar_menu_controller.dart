import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarMenuController extends GetxController {
  // Number of screen
  RxInt _selectedIndex = 2.obs;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  List<String> _menuItems = ['หน้าหลัก', 'ติดต่อ', 'สำหรับเจ้าหน้าที่'].obs;

  List<String> get getMenuItems => _menuItems;

  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;
  ScrollController get getScrollController => _scrollController;

  AnimateIconController _controllerAnimateIcons = AnimateIconController();

  // Set scroll to top on the operation custom scroll view
  void setScrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  // Get number selected menu index
  int get getSelectedIndex => _selectedIndex.value;

  // Get controller animation icon on platfrom tablet and moblie
  AnimateIconController get getControllerAnimateIcons =>
      _controllerAnimateIcons;

  // On show and hide drawer
  void onDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  // Set icon animation on drawer changed on platfrom tablet and moblie
  void setOnDrawerChanged(bool value) {
    if (value) {
      _controllerAnimateIcons.animateToEnd();
    } else {
      _controllerAnimateIcons.animateToStart();
    }
  }

  // Set selected index nav menu index
  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
    setScrollToTop();
  }

  // Set nev text after logged in
  void setMenuItemsOfAuthStatus(bool authStatus) {
    authStatus ? _menuItems[8] = '@Admin' : _menuItems[8] = 'สำหรับเจ้าหน้าที่';
  }
}
