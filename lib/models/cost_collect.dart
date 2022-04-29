class CostCollect{
  String ? id;
  String ?idUser;
  String ?idCategoryCollect;
  int money;
  String nameCategoryCollect;
  DateTime? dateTime;
  String ?note;

  CostCollect({this.id, this.idUser,  this.idCategoryCollect, required this.money,
    required this.nameCategoryCollect, this.dateTime, this.note});


  //Gửi lên
  Map<String, dynamic> toJson() => {
    "idUser":idUser,
    "idCategoryCollect":idCategoryCollect,
    "money":money,
    "nameCategoryCollect":nameCategoryCollect,
    "dateTime":dateTime!.toIso8601String(),
    "note":note
  };
  //Lấy về
  factory CostCollect.formJson(Map<String,dynamic> json){
    return CostCollect(
        idUser: json['idUser']??'',
        idCategoryCollect: json['idCategoryCollect']??'',
        money: json['money'],
        nameCategoryCollect: json['nameCategoryCollect'],
        dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
        note: json['note']??''
    );
  }


}