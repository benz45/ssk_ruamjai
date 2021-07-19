import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class ContentLoginTitle extends StatelessWidget {
  final double subTitleFontSize = 22.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: context.responsiveValue(
        desktop: CrossAxisAlignment.start,
        tablet: CrossAxisAlignment.start,
        mobile: CrossAxisAlignment.start,
      )!,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'เข้าสู่ระบบเพื่อเข้าใช้งาน',
          style: context.textTheme.headline4!.copyWith(color: Colors.black87),
        ),
        Text(
          'สำหรับเจ้าหน้าที่',
          style: context
              .responsiveValue(
                desktop: context.textTheme.headline5,
                tablet: context.textTheme.headline5,
                mobile: context.textTheme.headline6,
              )
              ?.copyWith(color: kPrimaryColor),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Text(
          '- ผู้ดูแลโรงพยาบาลสนาม',
          style: context
              .responsiveValue(
                desktop: context.textTheme.headline6,
                tablet: context.textTheme.headline6,
                mobile: context.textTheme.headline6,
              )
              ?.copyWith(color: Colors.grey[500], fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '- ผู้ดูแลห้อง ICU รพ.อำเภอ',
          style: context
              .responsiveValue(
                desktop: context.textTheme.headline6,
                tablet: context.textTheme.headline6,
                mobile: context.textTheme.headline6,
              )
              ?.copyWith(color: Colors.grey[500], fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '- ผู้ดูแลห้อง ICU รพ.ศก',
          style: context
              .responsiveValue(
                desktop: context.textTheme.headline6,
                tablet: context.textTheme.headline6,
                mobile: context.textTheme.headline6,
              )
              ?.copyWith(color: Colors.grey[500], fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '- Hospitel',
          style: context
              .responsiveValue(
                desktop: context.textTheme.headline6,
                tablet: context.textTheme.headline6,
                mobile: context.textTheme.headline6,
              )
              ?.copyWith(color: Colors.grey[500], fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '- เจ้าหน้าที่ อสม.',
          style: context
              .responsiveValue(
                desktop: context.textTheme.headline6,
                tablet: context.textTheme.headline6,
                mobile: context.textTheme.headline6,
              )
              ?.copyWith(color: Colors.grey[500], fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        // SizedBox(
        //   height: 8,
        // ),
        // if (!context.isPhone)
        //   Row(
        //     mainAxisAlignment: context.responsiveValue(
        //       desktop: MainAxisAlignment.start,
        //       tablet: MainAxisAlignment.center,
        //     )!,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 18.0),
        //         child: Text(
        //           'ศูนย์ควบคุมโควิด 19 จังหวัดศรีสะเกษ',
        //           style: context
        //               .responsiveValue(
        //                 desktop: context.textTheme.headline6,
        //                 tablet: context.textTheme.headline6,
        //                 mobile: context.textTheme.subtitle2,
        //               )
        //               ?.copyWith(color: Colors.black54),
        //         ),
        //       ),
        //       SizedBox(
        //         child: VerticalDivider(
        //           color: Colors.grey,
        //         ),
        //         width: 32,
        //         height: 18,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 18.0),
        //         child: Text(
        //           'สำนักงานจังหวัดศรีสะเกษ',
        //           style: context
        //               .responsiveValue(
        //                 desktop: context.textTheme.headline6,
        //                 tablet: context.textTheme.headline6,
        //                 mobile: context.textTheme.subtitle2,
        //               )
        //               ?.copyWith(color: Colors.black54),
        //         ),
        //       ),
        //     ],
        //   )
      ],
    );
  }
}
