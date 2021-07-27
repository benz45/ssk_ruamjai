class Res {
  Res({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  dynamic data;

  factory Res.fromJson(Map<String, dynamic> json) => Res(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data,
      };
}
