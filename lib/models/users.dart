class Users {
  String? uId;
  String? id;
  String? name;
  String email;
  String password;
  int? sumMoney;
  DateTime? startDate;

  Users(
      {this.uId,
      this.id,
      this.name,
      required this.email,
      required this.password,
      this.sumMoney=0,
      this.startDate,
      });
  // nhận về
  /*factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      country: json["address"] ?? "",
      isActive: json["isActive"] ?? false,
      dateActive: json['dateActive'] != null
          ? DateTime.parse(json["dateActive"])
          : null,
      linkGit: json['linkGit'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatarUrl'],
      role: json['role'],
    );
  }*/
//gửi lên
  Map<String, dynamic> toJson() => {
    "uId": uId,
    "name": name,
    "email": email,
    "password": password,
    "sumMoney": sumMoney,
    "startDate": startDate!.toIso8601String(),
  };



}
