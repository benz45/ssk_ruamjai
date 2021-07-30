import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssk_ruamjai/model/hospital.model.dart';
import 'package:ssk_ruamjai/model/login.model.dart';
import 'package:ssk_ruamjai/model/response.model.dart';
import 'package:ssk_ruamjai/model/user.model.dart';
import 'package:http/http.dart' as http;

enum LoginResponse {
  LoginSuccess,
  LoginBadStatus,
  InternalServerError,
  WriteTokenError
}
enum GetProfileResponse { GetProfileSuccess, GetProfileBadStatus }

class UserController extends GetxController {
  // * Setter
  final storage = GetStorage();
  final _user = UserModel().obs;
  final _isUser = false.obs;
  final _isLoading = false.obs;

  // * Init controller
  @override
  void onInit() async {
    super.onInit();
    final token = storage.read('token');
    if (token != null) {
      _isLoading.value = true;
      await _getUserProfile(token);
      _isLoading.value = false;
    }
  }

  // * Getter
  bool get getIsUser => _isUser.value;

  // Detail user data
  UserModel get getUser => _user.value;

  // Is loading data user from api
  bool get getIsLoading => _isLoading.value;

  District? getDistrictUser() {
    final districtUser = districtValues.map![_user.value.profile!.district!];
    return District.values.firstWhere(
      (e) => e == districtUser,
      orElse: null,
    );
  }

  Future<Res> login(LoginModel data) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_LOGIN']}'),
        body: jsonEncode(data.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
        },
      );

      if (response.statusCode != 200) {
        return Res(
          status: false,
          message: "${LoginResponse.LoginBadStatus}",
        );
      }

      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      final String token = responseJson['token'];

      return storage.write('token', token).then((_) async {
        final _user = await _getUserProfile(token);

        if (!_user.status!) {
          return Res(
            status: false,
            message: "${_user.message}",
          );
        }

        return Res(
          status: true,
          message: "${LoginResponse.LoginSuccess}",
        );
      }).catchError((_) {
        return Res(
          status: false,
          message: "${LoginResponse.WriteTokenError}",
        );
      });
    } catch (err) {
      return Res(
        status: false,
        message: "${err.toString()}",
      );
    }
  }

  // Get user profile from token
  Future<Res> _getUserProfile(String token) async {
    try {
      var url = Uri.parse('${dotenv.env['API_GET_PROFILE']}');
      var response = await http.get(url, headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Token $token"
      });

      if (response.statusCode == 500) {
        return Res(
          status: false,
          message: "${LoginResponse.InternalServerError}",
        );
      }

      if (response.statusCode != 200) {
        return Res(
          status: false,
          message: "${GetProfileResponse.GetProfileBadStatus}",
        );
      }

      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      _isUser.value = true;

      final jsonToRes = Res.fromJson(responseJson).data;
      final user = UserModel.fromJson(jsonToRes);

      _user.value = user;

      return Res(
        status: true,
        message: "${GetProfileResponse.GetProfileSuccess}",
      );
    } catch (err) {
      if (_isUser.value) _isUser.value = false;

      return Res(status: false, message: "${err.toString()}");
    }
  }

  logout() {
    storage.remove('token');
    _isUser.value = false;
    _user.value = UserModel();
  }
}
