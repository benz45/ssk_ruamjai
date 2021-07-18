import 'package:flutter/material.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class KButtonOutlined extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color textColor;
  final Color? disabledColor;
  final bool enabled;
  final bool isLoading;
  final bool isMargin;
  final double marginVertical;

  const KButtonOutlined({
    Key? key,
    this.text,
    this.onPressed,
    this.enabled = true,
    this.disabledColor,
    this.isLoading = false,
    this.isMargin = true,
    this.textColor = Colors.white,
    this.marginVertical = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: isMargin ? marginVertical : 0),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 29, horizontal: 36),
          ),
          overlayColor: MaterialStateProperty.all(Colors.grey[100]),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(
                  color: Colors.black, width: 5, style: BorderStyle.solid),
            ),
          ),
        ),
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
                  ),
                ),
              ),
            Text(
              text!,
              style: textTheme.subtitle1!.copyWith(
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
