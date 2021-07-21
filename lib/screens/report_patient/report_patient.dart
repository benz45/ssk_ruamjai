import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class ReportPatient extends StatefulWidget {
  @override
  _ReportPatientState createState() => _ReportPatientState();
}

class _ReportPatientState extends State<ReportPatient> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Column(
        children: [
          // * Time of result
          ReportPatientPoster(),

          SizedBox(
            height: kDefaultPadding * 3,
          ),
        ],
      ),
    );
  }
}

class ReportPatientPoster extends StatelessWidget {
  final ImageProvider _imagePoster = AssetImage(
    'assets/images/virus.png',
  );

  final _headerTitle = "จำนวนผู้ป่วยเพิ่มขึ้นวันนี้";
  final _increaseText = "ติดเชื้อเพิ่มวันนี้";
  final _diedText = "เสียชีวิตเพิ่มวันนี้";

  @override
  Widget build(BuildContext context) {
    final _imageVirus = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _imagePoster,
          fit: BoxFit.fitHeight,
        ),
      ),
    );

    final _desktop = Container(
      padding: EdgeInsets.only(top: kDefaultPadding * 2),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: context.height * .5,
              child: _imageVirus,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _headerTitle,
                    style: context
                        .responsiveValue(
                          desktop: context.textTheme.headline4,
                          tablet: context.textTheme.headline4,
                          mobile: context.textTheme.headline5,
                        )
                        ?.copyWith(color: Colors.black87),
                  ),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),

                  // * Result Number
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _increaseText,
                              style: context
                                  .responsiveValue(
                                    tablet: context.textTheme.headline5,
                                    mobile: context.textTheme.headline6,
                                  )
                                  ?.copyWith(color: Colors.black87),
                            ),
                            Text(
                              "ข้อมูล ณ เวลา 13.40 น.",
                              style: context.textTheme.subtitle2!
                                  .copyWith(color: Colors.black54),
                            ),

                            // * Result Number
                            Text(
                              "+54",
                              style: context.textTheme.headline2!.copyWith(
                                color: kPrimaryColor.withOpacity(.75),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 140,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: kDefaultPadding),
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _diedText,
                              style: context
                                  .responsiveValue(
                                    tablet: context.textTheme.headline5,
                                    mobile: context.textTheme.headline6,
                                  )
                                  ?.copyWith(color: Colors.black87),
                            ),
                            Text(
                              "ข้อมูล ณ เวลา 13.40 น.",
                              style: context.textTheme.subtitle2!
                                  .copyWith(color: Colors.black54),
                            ),

                            // * Result Number
                            Text(
                              "+0",
                              style: context.textTheme.headline2!.copyWith(
                                  color: Colors.grey.withOpacity(.75),
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    final _mobile = Container(
      width: context.width * .8,
      height: context.height * .78,
      padding: EdgeInsets.only(top: kDefaultPadding),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: context.height * .7,
                width: context.width * .7,
                constraints: BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _imagePoster,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "ข้อมูลโควิด-19",
                    style: context
                        .responsiveValue(
                          tablet: context.textTheme.headline4,
                          mobile: context.textTheme.headline4,
                        )
                        ?.copyWith(color: Colors.black87),
                  ),
                  Text(
                    "จังหวัดศรีสะเกษ",
                    style: context.textTheme.headline5!.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _increaseText,
                              style: context
                                  .responsiveValue(
                                    tablet: context.textTheme.headline5,
                                    mobile: context.textTheme.headline6,
                                  )
                                  ?.copyWith(color: Colors.black87),
                            ),
                            Text(
                              "ข้อมูล ณ เวลา 13.40 น.",
                              style: context.textTheme.subtitle2!
                                  .copyWith(color: Colors.black54),
                            ),

                            // * Result Number
                            Text(
                              "+124",
                              style: context.textTheme.headline2!.copyWith(
                                color: kPrimaryColor.withOpacity(.75),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: kDefaultPadding),
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _diedText,
                              style: context
                                  .responsiveValue(
                                    tablet: context.textTheme.headline5,
                                    mobile: context.textTheme.headline6,
                                  )
                                  ?.copyWith(color: Colors.black87),
                            ),
                            Text(
                              "ข้อมูล ณ เวลา 13.40 น.",
                              style: context.textTheme.subtitle2!
                                  .copyWith(color: Colors.black54),
                            ),

                            // * Result Number
                            Text(
                              "+12",
                              style: context.textTheme.headline2!.copyWith(
                                  color: Colors.grey.withOpacity(.75),
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

    return context.responsiveValue(
      desktop: _desktop,
      tablet: _mobile,
      mobile: _mobile,
    )!;
  }
}
