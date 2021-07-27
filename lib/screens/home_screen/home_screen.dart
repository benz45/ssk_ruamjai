import 'package:flutter/material.dart';

// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:ssk_ruamjai/screens/home_screen/components/container_number_of_color.dart';
import 'package:ssk_ruamjai/screens/home_screen/components/container_number_of_recover.dart';
import 'package:ssk_ruamjai/util/constants.dart';

import 'components/container_number_of_bed.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Column(
        children: [
          SizedBox(
            height: kDefaultPadding * 3,
          ),
          // * Container number of bed
          ContainerNumberOfBed(),
          SizedBox(
            height: kDefaultPadding * 10,
            child: Divider(),
          ),
          // * Number of color
          ContainerNumberOfColor(),
          SizedBox(
            height: kDefaultPadding * 10,
            child: Divider(),
          ),
          // * Container number of recover
          ContainerNumberOfRecover(),
          SizedBox(
            height: kDefaultPadding * 10,
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
