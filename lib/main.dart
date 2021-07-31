import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssk_ruamjai/bindings/operation_bindings.dart';
import 'package:ssk_ruamjai/components/k_drawer.dart';
import 'package:ssk_ruamjai/components/k_progress.dart';
import 'package:ssk_ruamjai/components/navbar/navbar.dart';
import 'package:ssk_ruamjai/controllers/navbar_menu_controller.dart';
import 'package:ssk_ruamjai/controllers/user.controller.dart';
import 'package:ssk_ruamjai/screens/authorities_screen/authorities_screen.dart';
import 'package:ssk_ruamjai/screens/details_patient/details_patient.dart';
import 'package:ssk_ruamjai/screens/form_add_patient/form_add_patient.dart';
import 'package:ssk_ruamjai/screens/form_edit_patient/form_edit_patient.dart';
import 'package:ssk_ruamjai/screens/home_screen/home_screen.dart';
import 'package:ssk_ruamjai/screens/inside_district_screen/inside_district_screen.dart';
import 'package:ssk_ruamjai/screens/login_screen/login_screen.dart';
import 'package:ssk_ruamjai/screens/report_patient/report_patient.dart';
import 'package:ssk_ruamjai/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  runApp(Main());
}

class Main extends StatelessWidget {
  final box = GetStorage();
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
        GetPage(
          name: FormAddPatient.routeName,
          page: () => FormAddPatient(),
        ),
        GetPage(
          name: FormEditPatient.routeName,
          page: () => FormEditPatient(),
        ),
        GetPage(
          name: DetailPatient.routeName,
          page: () => DetailPatient(),
        ),
        GetPage(
            name: '${InsideDistrictScreen.routeName}/:district',
            page: () => InsideDistrictScreen()),
      ],
    );
  }

  // Load image from first re-rander
  loadImage(context) {
    precacheImage(AssetImage('assets/images/logo.png'), context);
    precacheImage(AssetImage('assets/images/virus.png'), context);
  }
}

class Operation extends StatelessWidget {
  static String routeName = '/';

  final _navBarMenuController = Get.find<NavBarMenuController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _navBarMenuController.getScaffoldKey,
      resizeToAvoidBottomInset: false,
      onDrawerChanged: (value) {
        _navBarMenuController.setOnDrawerChanged(value);
      },
      drawer: KDrawer(),
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
  }
}

// Switch page
class SwitchPage extends StatefulWidget {
  @override
  _SwitchSwitchPageState createState() => _SwitchSwitchPageState();
}

class _SwitchSwitchPageState extends State<SwitchPage>
    with TickerProviderStateMixin {
  SharedAxisTransitionType? _transitionType =
      SharedAxisTransitionType.horizontal;

  final _navBarMenuController = Get.find<NavBarMenuController>();
  final _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    final List<Widget> _listPosters = [
      HomeScreen(),
      ReportPatient(),
      SizedBox(),
      OfficerOperation(),
    ];
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Obx(
            () {
              int defaultDurationFade = 300;

              if (_userController.getIsUser) {
                return Column(
                  children: [
                    _listPosters[_navBarMenuController.getSelectedIndex],
                  ],
                );
              }

              return AnimatedSizeAndFade(
                vsync: this,
                fadeDuration: Duration(milliseconds: defaultDurationFade),
                sizeDuration: Duration(milliseconds: defaultDurationFade),
                child: PageTransitionSwitcher(
                  duration: Duration(milliseconds: 400),
                  reverse: true,
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
              );
            },
          ),
        ],
      ),
    );
  }
}

class OfficerOperation extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // * Loading officer screen
      if (controller.getIsLoading) {
        return Container(
          height: context.height - NavBar().navBarHeight,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'กรุณารอสักครู่',
                  style: context.textTheme.bodyText2,
                ),
                SizedBox(width: 15),
                SizedBox(child: KProgress(), width: 18, height: 18)
              ],
            ),
          ),
        );
      }
      return controller.getIsUser ? Authorities() : LoginScreen();
    });
  }
}
