import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class KButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color textColor;
  final Color? disabledColor;
  final bool enabled;
  final bool isLoading;
  final bool isMargin;

  const KButton({
    Key? key,
    this.text,
    this.onPressed,
    this.enabled = true,
    this.disabledColor,
    this.isLoading = false,
    this.isMargin = true,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: isMargin ? 10 : 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: SizedBox(
          width: double.infinity,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
            disabledColor: kDisabledPrimaryColor,
            padding: EdgeInsets.symmetric(vertical: 31, horizontal: 36),
            color: kPrimaryColor,
            onPressed: enabled ? onPressed : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLoading)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          kPrimaryColor.withOpacity(
                            .75,
                          ),
                        ),
                      ),
                    ),
                  ),
                Text(
                  text!,
                  style: context.textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
