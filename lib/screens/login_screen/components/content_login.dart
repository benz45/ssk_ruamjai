import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssk_ruamjai/components/buttons/k_button.dart';
import 'package:ssk_ruamjai/components/input_text/k_input_field.dart';
import 'package:ssk_ruamjai/components/k_toast.dart';
import 'package:ssk_ruamjai/controllers/navbar_menu_controller.dart';
import 'package:ssk_ruamjai/controllers/user.controller.dart';
import 'package:ssk_ruamjai/model/login.model.dart';
import 'package:ssk_ruamjai/util/constants.dart';

class ContentLogin extends StatefulWidget {
  @override
  _ContentLoginState createState() => _ContentLoginState();
}

class _ContentLoginState extends State<ContentLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = Get.find<UserController>();

  void _toHomePoster() {
    Get.find<NavBarMenuController>().setSelectedIndex(0);
  }

  // Loading button
  bool _isLoading = false;

  void _eventLoad() {
    setState(() => _isLoading = !_isLoading);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kDefaultPadding * 24,
      padding: EdgeInsets.symmetric(
        horizontal: context.isPhone ? kDefaultPadding : 0,
      ),
      child: formLogin(),
    );
  }

  Column formAuthenticated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ข้อมูลเจ้าหน้าที่',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 22),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'อีเมล',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                // TODO
                '',
                // '${}',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'วันที่สร้าง',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  // TODO
                  "",
                  // KFormatDate.getDateUs(date: '${_user.metadata.creationTime}', time: true),
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'เข้าสู่ระบบล่าสุด',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  // TODO:
                  "",
                  // KFormatDate.getDateUs(date: '${_user.metadata.lastSignInTime}', time: true),
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        KButton(
          isLoading: _isLoading,
          text: 'ออกจากระบบ',
          onPressed: () {
            _toHomePoster();
            // TODO:
          },
        ),
      ],
    );
  }

  Form formLogin() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KInputField(
            controller: _emailController,
            hintText: 'อีเมลเจ้าหน้าที่',
            onSubmitted: (_) => _onLogin(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ),
          KInputField(
            obscureText: true,
            controller: _passwordController,
            hintText: 'รหัสผ่าน',
            onSubmitted: (_) => _onLogin(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ),
          KButton(
            isLoading: _isLoading,
            text: 'เข้าสู่ระบบ',
            onPressed: () => _onLogin(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ),
        ],
      ),
    );
  }

  void _onLogin({required String email, required String password}) async {
    try {
      _eventLoad();
      final res = await _userController
          .login(LoginModel(username: email, password: password));

      if (!res.status!) {
        _eventLoad();
        if (res.message == LoginResponse.LoginBadStatus.toString()) {
          kToast(
            'อีเมล หรือรหัสผ่านไม่ถูกต้อง',
            Text('กรุณาตรวจสอบข้อมูลใหม่อีกครั้ง'),
          );
        }

        if (res.message == LoginResponse.InternalServerError.toString()) {
          kToast(
            'เกิดข้อผิดพลาด 500',
            Text('LoginResponse.InternalServerError'),
          );
        }
      }
    } catch (e) {
      kToast(
        'เกิดข้อผิดพลาดบางอย่างในการเข้าสู่ระบบ',
        Text('$e'),
      );
      _eventLoad();
    }
  }
}
