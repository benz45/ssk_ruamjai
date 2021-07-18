import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ssk_ruamjai/bindings/operation_bindings.dart';
import 'package:ssk_ruamjai/components/k_drawer.dart';
import 'package:ssk_ruamjai/components/navbar/navbar.dart';
import 'package:ssk_ruamjai/controllers/navbar_menu_controller.dart';
import 'package:ssk_ruamjai/screens/home_screen/home_screen.dart';
import 'package:ssk_ruamjai/theme.dart';

import 'screens/admin_page/admin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    loadImage(context);
    return GetMaterialApp(
      title: 'ศรีสะเกษร่วมใจ',
      debugShowCheckedModeBanner: false,
      builder: themeBuilder,
      initialRoute: Operation.routeName,
      initialBinding: OperationBindings(),
      getPages: [
        GetPage(
          name: Operation.routeName,
          page: () => Operation(),
        ),
      ],
    );
  }

  // Load image from first re-rander
  loadImage(context) {
    precacheImage(AssetImage('assets/images/logo.png'), context);
  }
}

class Operation extends StatelessWidget {
  static String routeName = '/';

  final _navBarMenuController = Get.find<NavBarMenuController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _navBarMenuController.getScaffoldKey,
      onDrawerChanged: (value) {
        _navBarMenuController.setOnDrawerChanged(value);
      },
      drawer: KDrawer(),
      // TODO:
      body: FetchNewsData(),
    );
  }
}

class FetchNewsData extends StatelessWidget {
  final _navBarMenuController = Get.find<NavBarMenuController>();
  @override
  Widget build(BuildContext context) {
    CustomScrollView _customScrollView = CustomScrollView(
      controller: _navBarMenuController.getScrollController,
      slivers: [
        NavBar(),
        SwitchPage(),
      ],
    );
    return _customScrollView;
    // return Center(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text(
    //         'กรุณารอสักครู่',
    //         style: context.textTheme.bodyText2,
    //       ),
    //       SizedBox(width: 15),
    //       SizedBox(child: KProgress(), width: 18, height: 18)
    //     ],
    //   ),
    // );
  }
}

class SwitchPage extends StatefulWidget {
  @override
  _SwitchSwitchPageState createState() => _SwitchSwitchPageState();
}

class _SwitchSwitchPageState extends State<SwitchPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> _listPosters = [
    HomeScreen(),
    SizedBox(),
    AdminScreen(),
  ];

  final _navBarMenuController = Get.find<NavBarMenuController>();
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Obx(
            () => AnimatedSize(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 300),
              vsync: this,
              child: PageTransitionSwitcher(
                duration: Duration(milliseconds: 300),
                reverse: false,
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                child: _listPosters[_navBarMenuController.getSelectedIndex],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
