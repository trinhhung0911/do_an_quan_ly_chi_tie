class KhoanChi {
  String? Id;
  String Id_loaichi;
  final String ID_Userd;
  final String Ten_khoan_chi;
  final int So_tien_chi;
  DateTime? Ngay_chi;
  String? Chu_thich;
  KhoanChi(
      {this.Id,
      required this.Id_loaichi,
      required this.ID_Userd,
      required this.Ten_khoan_chi,
      required this.So_tien_chi,
      this.Ngay_chi,
      this.Chu_thich});
}
