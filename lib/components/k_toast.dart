import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

void kToast(String title, Widget message, {Function(GetBar<Object>)? onTap}) {
  Get.snackbar(
    '', // title
    '',
    messageText: message, // message
    titleText: Text(
      title,
      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
    ),
    snackPosition: SnackPosition.BOTTOM,
    barBlur: 20,
    isDismissible: true,
    maxWidth: kMaxWidth,
    borderRadius: 0.0,
    duration: Duration(seconds: 3),
    backgroundColor: Colors.white.withOpacity(.75),
    leftBarIndicatorColor: kPrimaryColor,
    onTap: onTap,
  );
}
