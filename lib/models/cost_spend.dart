class CostSpend{
  String ? id;
  String ?idUser;
  String ?idCategorySpend;
  int money;
  String nameCategorySpend;
  DateTime? dateTime;
  String ?note;

  CostSpend({this.id, this.idUser,  this.idCategorySpend, required this.money,
      required this.nameCategorySpend, this.dateTime, this.note});


  //Gửi lên
  Map<String, dynamic> toJson() => {
    "idUser":idUser,
    "idCategorySpend":idCategorySpend,
    "money":money,
    "nameCategorySpend":nameCategorySpend,
    "dateTime":dateTime!.toIso8601String(),
    "note":note
  };
  //Lấy về
factory CostSpend.formJson(Map<String,dynamic> json){
  return CostSpend(
    idUser: json['idUser']??'',
    idCategorySpend: json['idCategorySpend']??'',
      money: json['money'],
    nameCategorySpend: json['nameCategorySpend'],
    dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
    note: json['note']??''
  );
}


}