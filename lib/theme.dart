import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssk_ruamjai/util/constants.dart';

Theme themeBuilder(BuildContext context, Widget? child) {
  // Google font style
  styleText(textStyle, {Color? color}) {
    return GoogleFonts.prompt(
      textStyle: textStyle,
      fontWeight: FontWeight.w300,
      color: color ?? Colors.black87,
    );
  }

  var text = context.textTheme;

  return Theme(
    data: ThemeData(
      fontFamily: 'Prompt',
      canvasColor: Colors.white,
      accentColor: kPrimaryColor,
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        subtitle2: styleText(text.subtitle2, color: Colors.black87),
        bodyText1: styleText(text.bodyText1, color: Colors.black87),
        bodyText2: styleText(text.bodyText2, color: Colors.black87),
        caption: styleText(text.caption, color: Colors.black87),
      ),
    ),
    child: child!,
  );
}
