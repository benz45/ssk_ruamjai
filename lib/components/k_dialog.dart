import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/buttons/k_button.dart';
import 'package:ssk_ruamjai/components/buttons/k_button_outlined.dart';

void kDialog({
  required String title,
  required Widget content,
  List<Widget>? actions,
  Function()? onCancel,
  Function()? onConfirm,
  bool? isLoading,
}) {
  Get.defaultDialog(
    title: title,
    content: content,
    radius: 0,
    cancel: KButtonOutlined(
      text: 'ยกเลิก',
      isMargin: false,
      onPressed: onCancel ?? () => Get.back(),
    ),
    confirm: StatefulBuilder(builder: (_, setState) {
      return KButton(
        text: 'ยืนยัน',
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          onConfirm!();
        },
        isLoading: isLoading ?? false,
        isMargin: false,
      );
    }),
  );
}
