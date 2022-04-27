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
    "sumMoney": sumMoney,
    "startDate": startDate!.toIso8601String(),
  };



}
