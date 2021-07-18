import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef void OnWidgetSizeChange(Size size);

class GetSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const GetSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _GetSizeState createState() => _GetSizeState();
}

class _GetSizeState extends State<GetSize> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback(postFrameCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) async {
    var context = widgetKey.currentContext!;
    Size newSize = context.size!;
    if (newSize == Size.zero) return;
    if (oldSize == newSize) return;
    oldSize = newSize;
    widget.onChange(newSize);
  }
}
