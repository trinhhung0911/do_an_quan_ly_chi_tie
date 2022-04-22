import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';


class AddSpendScreen extends StatefulWidget {
  const AddSpendScreen({Key? key}) : super(key: key);
  @override
  _AddSpendScreenState createState() => _AddSpendScreenState();
}

class _AddSpendScreenState extends State<AddSpendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Thêm khoản chi')),

      ),
      body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Số tiền',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900),
                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                              autofocus: true,
                              decoration: InputDecoration(
                                suffixText: 'đ',
                                prefix: Icon(
                                  Icons.monetization_on,
                                  color: Theme.of(context).accentColor,
                                  size: 26,
                                ),
                                hintText: '0',
                                hintStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () {
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: const Icon(
                                  Icons.category,
                                  size: 28,
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text('Chọn hạng mục',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: const Icon(
                                  Icons.subject,
                                  size: 28,
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Chú thích',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              child: const Icon(
                                Icons.calendar_today,
                                size: 28,
                              ),
                            ),
                            const Expanded(
                              flex: 3,
                              child: InkWell(
                                child: Text('14/2/2022',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const InkWell(
                              child: Text(
                                '3/4/2022',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: 50,
                                  child:
                                  Icon(Icons.account_balance_wallet, size: 28,)

                              ),
                              const Expanded(
                                flex: 1,
                                child: Text('Chọn tài khoản',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.save,
                            size: 28,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Ghi',
                          ),
                        ],
                      ),
                    ),
                    onPressed:(){
                      print('Thêm thành công');
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),),

    );
  }
}
