
class CategoryCollect {
  String ? id;
  String ? idUser;
  final String name;
  String ?note;
  CategoryCollect({this.id, this.idUser, required this.name,  this.note});
  //gửi lên
  Map<String, dynamic> toJson() => {
    "name": name,
    "note":note,
    "idUser":idUser,
  };
//Lấy về
  factory CategoryCollect.fromJson(Map<String, dynamic> json){
    return  CategoryCollect(
      idUser: json['idUser'] ?? '',
      name: json['name'] ?? '',
      note: json['note'] ?? '',
    );
  }

}