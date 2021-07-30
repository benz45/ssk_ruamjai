import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/buttons/k_button.dart';
import 'package:ssk_ruamjai/components/buttons/k_text_link.dart';
import 'package:ssk_ruamjai/controllers/user.controller.dart';
import 'package:ssk_ruamjai/screens/authorities_screen/components/table_district.dart';
import 'package:ssk_ruamjai/screens/form_add_patient/form_add_patient.dart';
import 'package:ssk_ruamjai/util/constants.dart';

// ! หน้าสำหรับเจ้าหน้าที่
class Authorities extends StatefulWidget {
  @override
  _AuthoritiesState createState() => _AuthoritiesState();
}

class _AuthoritiesState extends State<Authorities>
    with TickerProviderStateMixin {
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      padding: EdgeInsets.symmetric(
          horizontal: context.isPhone ? kDefaultPadding : kDefaultPadding * 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: kDefaultPadding * 2,
          ),
          // * Authoritie detail
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _userController.getUser.profile?.firstName ??
                              notFound,
                          style: context.textTheme.headline6,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          _userController.getUser.profile?.lastName ?? notFound,
                          style: context.textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      _userController.getUser.account?.username ?? notFound,
                      style: context.textTheme.subtitle2,
                    ),
                    Text(
                      _userController.getUser.profile?.office ?? notFound,
                      style: context.textTheme.subtitle2,
                    ),
                    if (context.isPhone) ...{
                      SizedBox(height: kDefaultPadding),
                      KTextLink(
                        text: 'ออกจากระบบ',
                        onPressed: () {
                          _userController.logout();
                        },
                      )
                    }
                  ],
                ),
                if (!context.isPhone) ...{
                  Spacer(),
                  KTextLink(
                    text: 'ออกจากระบบ',
                    onPressed: () {
                      _userController.logout();
                    },
                  )
                }
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPadding * 4,
            child: Divider(),
          ),
          // * สถานะเตียง
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "สถานะเตียงทั้งหมด",
                    style: context.textTheme.headline6,
                  ),
                ],
              ),
              Spacer(),
              Text(
                "ทั้งหมด 30, เหลือ 10",
                style:
                    context.textTheme.headline6!.copyWith(color: kSuccessColor),
              )
            ],
          ),
          // SizedBox(
          //   height: kDefaultPadding * 4,
          //   child: Divider(),
          // ),
          // * จำนวนเตียง
          // ValueBuilder(
          //   initialValue: false,
          //   builder: (bool? value, Function(bool)? update) {
          //     return Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   "จำนวนเตียง",
          //                   style: context.textTheme.headline6,
          //                 ),
          //                 Text(
          //                   "10",
          //                   style: context.textTheme.headline6!
          //                       .copyWith(color: kSuccessColor),
          //                 ),
          //               ],
          //             ),
          //             Spacer(),
          //             AnimatedOpacity(
          //               opacity: value! ? 0 : 1,
          //               duration: Duration(milliseconds: 300),
          //               child: Container(
          //                 width: context.responsiveValue(
          //                   desktop: kDefaultPadding * 10,
          //                   tablet: kDefaultPadding * 10,
          //                   mobile: kDefaultPadding * 6,
          //                 ),
          //                 child: KButtonOutlined(
          //                   text: 'แก้ไข',
          //                   onPressed: () {
          //                     update!(true);
          //                   },
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //         AnimatedSizeAndFade.showHide(
          //           vsync: this,
          //           show: value,
          //           fadeDuration: const Duration(milliseconds: 300),
          //           sizeDuration: const Duration(milliseconds: 300),
          //           fadeInCurve: Curves.fastOutSlowIn,
          //           fadeOutCurve: Curves.fastOutSlowIn,
          //           child: Column(
          //             children: [
          //               KInputField(
          //                 hintText: "จำนวนเตียง",
          //               ),
          //               Row(
          //                 children: [
          //                   Expanded(
          //                     flex: 1,
          //                     child: KButtonOutlined(
          //                       text: 'ยกเลิก',
          //                       onPressed: () {
          //                         update!(false);
          //                       },
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: kDefaultPadding,
          //                   ),
          //                   Expanded(
          //                     flex: 1,
          //                     child: KButton(
          //                       text: 'บันทึก',
          //                       onPressed: () {},
          //                     ),
          //                   ),
          //                 ],
          //               )
          //             ],
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
          // * แกไข จำนวนเตียง
          SizedBox(
            height: kDefaultPadding * 4,
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "รายการศูนย์รักษา",
                    style: context.textTheme.headline6,
                  ),
                  Text(
                    "ภายในจังหวัดศรีสะเกษ",
                    style: context
                        .responsiveValue(
                          desktop: context.textTheme.headline6,
                          tablet: context.textTheme.headline6,
                          mobile: context.textTheme.subtitle1,
                        )!
                        .copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
              Spacer(),
              // if (!value)
              Container(
                width: context.responsiveValue(
                  desktop: kDefaultPadding * 10,
                  tablet: kDefaultPadding * 10,
                  mobile: kDefaultPadding * 6,
                ),
                child: KButton(
                  text: 'ดูทั้งหมด',
                  onPressed: () {
                    Get.toNamed(FormAddPatient.routeName);
                  },
                ),
              )
            ],
          ),
          // SizedBox(
          //   height: kDefaultPadding,
          // ),
          // // * อธิบายสัญญาลักษ์ต่าง ๆ บนตาราง
          // DescriptionSymbol(),

          SizedBox(
            height: kDefaultPadding,
          ),

          // * Table hospital

          // สำหรับดูทั้งหมด
          // TableHospital(),

          // สำหรับแยกเป็นอำเภอ
          TableDistrict(),

          // สำหรับดูภายในอำเภอ
          // TableInsideDistrict(districtUser: _userController.getDistrictUser),

          SizedBox(
            height: kDefaultPadding,
          ),

          SizedBox(
            height: kDefaultPadding * 5,
          ),
        ],
      ),
    );
  }
}
