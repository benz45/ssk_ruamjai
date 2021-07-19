import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class KInputFormField extends StatelessWidget {
  final IconData? icon;
  final double? iconSize;
  final onChanged;
  final Function()? onTap;
  final keyboardType;
  final inputFormatters;
  final controller;
  final Function(String)? onFieldSubmitted;
  final textInputAction;
  final bool? enabled;
  final bool autofocus;
  final obscureText;
  final maxLines;
  final double borderRadius;
  final String? labelText;
  final String? hintText;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  const KInputFormField({
    Key? key,
    this.autofocus = false,
    this.enabled,
    this.hintText,
    this.icon,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.inputFormatters,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.labelText,
    this.textAlign,
    this.validator,
    this.suffixIcon,
    this.hintStyle,
    this.labelStyle,
    this.iconSize = 18.0,
    this.borderRadius = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        key: key,
        validator: validator,
        autocorrect: false,
        enableSuggestions: false,
        autofocus: autofocus,
        enabled: enabled,
        inputFormatters: inputFormatters,
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: kPrimaryColor,
        textInputAction: textInputAction,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(27),
          focusedBorder: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: kPrimaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.25), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(color: kPrimaryColor.withOpacity(0.5), width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(color: kPrimaryColor.withOpacity(0.05), width: 2),
          ),
          prefixIcon: icon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 26, right: 16),
                  child: Icon(
                    icon,
                    color: kPrimaryColor,
                    size: iconSize,
                  ),
                )
              : null,
          labelStyle: labelStyle ??
              TextStyle(
                color: kPrimaryColor,
              ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: hintStyle ??
              context.textTheme.bodyText2!.copyWith(
                color: Colors.grey,
              ),
          border: InputBorder.none,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
