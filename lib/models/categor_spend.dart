
class CategorySpend {
  String ? id;
  String ? idUser;
  final String name;
  int ? maximum;
  String ?note;
  CategorySpend({this.id, this.idUser, required this.name, this.maximum, this.note});
  //gửi lên
  Map<String, dynamic> toJson() => {
    "name": name,
    "maximum":maximum,
    "note":note,
    "idUser":idUser,
  };
  factory CategorySpend.fromJson(Map<String, dynamic> json){
    return   CategorySpend(
      idUser: json['idUser'] ?? '',
      name: json['name'] ?? '',
      note: json['note'] ?? '',
      maximum: json['maximum']??0,
    );
  }

}