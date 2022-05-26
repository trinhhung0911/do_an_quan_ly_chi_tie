class Users {
  String? uid;
  String? id;
  String? name;
  String email;
  String password;
  int? sumMoney;
  DateTime? startDate;

  Users(
      {this.uid,
      this.id,
      this.name,
      required this.email,
      required this.password,
      this.sumMoney=0,
      this.startDate,
      });
//gửi lên
  Map<String, dynamic> toJson() => {
    "uId": uid,
    "name": name,
    "email": email,
    "password": password,
    "sumMoney": sumMoney as int,
    "startDate": startDate!.toIso8601String(),
  };

  //lấy về
  factory Users.formJson(Map<String,dynamic> json){
    return Users(
        uid: json['uId'] ?? '',
        name: json['name'] ?? '',
        email: json['email'],
        password: json['password'],
        sumMoney: json['sumMoney'] as int,
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
    );
  }



}
