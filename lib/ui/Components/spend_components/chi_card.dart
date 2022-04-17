import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/models/khoan_chi.dart';

class ChiCard extends StatefulWidget {
  final int itemItem;
  KhoanChi khoanChi;
  ChiCard(this.itemItem, this.khoanChi);
  @override
  State<ChiCard> createState() => _ChiCardState();
}
class _ChiCardState extends State<ChiCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
        top: 10,
      ),
      padding: EdgeInsets.only(
        left: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.spendColor,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      height: 60,
      width: double.infinity,
      child: InkWell(
        onLongPress: () {},
        onTap: () async {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(Icons.account_balance_wallet_sharp),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity - 200,
                      child: Text(
                        widget.khoanChi.Ten_khoan_chi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('')
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
