class UserModel {
  UserModel({
    this.account,
    this.profile,
  });

  Account? account;
  Profile? profile;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "account": account == null ? null : account!.toJson(),
        "profile": profile == null ? null : profile!.toJson(),
      };
}

class Account {
  Account({
    this.id,
    this.username,
    this.groups,
  });

  int? id;
  String? username;
  List<int>? groups;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        groups: json["groups"] == null
            ? null
            : List<int>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "groups":
            groups == null ? null : List<dynamic>.from(groups!.map((x) => x)),
      };
}

class Profile {
  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.office,
    this.phone,
    this.district,
    this.user,
    this.roles,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? office;
  String? phone;
  String? district;
  int? user;
  List<String>? roles;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        office: json["office"] == null ? null : json["office"],
        phone: json["phone"] == null ? null : json["phone"],
        district: json["district"] == null ? null : json["district"],
        user: json["user"] == null ? null : json["user"],
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "office": office == null ? null : office,
        "phone": phone == null ? null : phone,
        "district": district == null ? null : district,
        "user": user == null ? null : user,
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
      };
}
