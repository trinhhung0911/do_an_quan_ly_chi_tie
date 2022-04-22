import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/models/loai_chi.dart';

class AppData {
static List<SalesData> danhmucchi=[
  SalesData('Quần áo', 350000),
  SalesData('Giày dép', 280000),
  SalesData('Du lịch', 34000),
  SalesData('Điện nước', 32000),
  SalesData('Sức khỏe', 40000),
];
static List<LoaiChi> listLoaiChi=[
  LoaiChi('1', '1', 'Quần áo', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('2', '1', 'Giay dép', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('3', '2', 'Du lịch', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('4', '2', 'Mỹ phẩm', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('5', '2', 'Súc khỏe', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('1', '1', 'Quần áo', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('2', '1', 'Giay dép', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('3', '2', 'Du lịch', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('4', '2', 'Mỹ phẩm', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('5', '2', 'Súc khỏe', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('1', '1', 'Quần áo', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('2', '1', 'Giay dép', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('3', '2', 'Du lịch', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('4', '2', 'Mỹ phẩm', 2000, 'Chi tiêu mua quần áo'),
  LoaiChi('5', '2', 'Súc khỏe', 2000, 'Chi tiêu mua quần áo'),
];
}
class SalesData {
  SalesData(this.name, this.money);
  final String name;
  final double money;
}