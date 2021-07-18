import 'package:flutter/material.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class KProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(
          kPrimaryColor,
        ),
      ),
    );
  }
}
