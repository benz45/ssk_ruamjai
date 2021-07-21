import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class KTextLink extends StatefulWidget {
  const KTextLink({
    Key? key,
    this.fontSize,
    this.text = '',
    this.arrowIcon = false,
    this.colors,
    this.maxWidth,
    this.fontWeight,
    required this.onPressed,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final bool arrowIcon;
  final Color? colors;
  final Function()? onPressed;
  final double? maxWidth;
  final MainAxisAlignment? mainAxisAlignment;
  final FontWeight? fontWeight;

  @override
  _KTextLinkState createState() => _KTextLinkState();
}

class _KTextLinkState extends State<KTextLink> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      hoverColor: Colors.transparent,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.maxWidth ?? kMaxWidth,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.mainAxisAlignment!,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                widget.text,
                overflow: TextOverflow.visible,
                style: TextStyle(
                    decoration: _isHover
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: widget.colors ?? kPrimaryColor,
                    decorationThickness: 1,
                    color: widget.colors ?? kPrimaryColor,
                    fontSize: widget.fontSize ??
                        context.textTheme.subtitle1!.fontSize,
                    height: 1.4,
                    fontWeight: widget.fontWeight ?? FontWeight.w300),
              ),
            ),
            if (widget.arrowIcon)
              Container(
                padding: EdgeInsets.only(
                    top: (widget.fontSize ??
                            context.textTheme.subtitle1!.fontSize!) *
                        .011),
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: widget.colors ?? kPrimaryColor,
                  size: (widget.fontSize != null
                      ? widget.fontSize! - 4
                      : context.textTheme.subtitle1!.fontSize!),
                ),
              )
          ],
        ),
      ),
    );
  }
}
