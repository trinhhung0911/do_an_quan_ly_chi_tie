// import 'package:flutter/material.dart';
// import 'package:quan_ly_chi_tieu/configs/app_data.dart';
//
// import '../../../configs/themes.dart';
//
// class ItemChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: AppData.danhmucchi
//               .map(
//                 (data) => Container(
//                   padding: const EdgeInsets.symmetric(vertical: 2),
//                   child: buildIndicator(
//                     color: data.color,
//                     text: data.name,
//                     // isSquare: true,
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       );
//
//   Widget buildIndicator({
//     @required Color? color,
//     @required String? text,
//     bool isSquare = false,
//     double size = 16,
//
//   }) =>
//       Row(
//         children: <Widget>[
//           Container(
//             width: size,
//             height: size,
//             decoration: BoxDecoration(
//               shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
//               color: color,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(text!, style: AppThemes.lightText.copyWith(color: Colors.black))
//         ],
//       );
// }
