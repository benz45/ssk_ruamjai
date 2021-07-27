class LoginModel {
  LoginModel({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
