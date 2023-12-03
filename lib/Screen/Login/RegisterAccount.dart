import 'package:doanchuyende/Screen/Login/verify_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({super.key});

  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  bool agreement1 = false;
  bool agreement2 = false;
  final _enterPhoneNumber = TextEditingController();
  Map<String, dynamic> data = {"name": "VN", "code": "+84"};
  Map<String, dynamic>? dataResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tạo tài khoản',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Nhập số điện thoại của bạn để tạo tài khoản mới',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButton<String>(
                        value: 'VN',
                        items: <String>[
                          'VN',
                          'US',
                          'CA',
                          // Thêm các quốc gia khác ở đây
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.blue), // Màu chữ
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _enterPhoneNumber,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Nhập số điện thoại',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: agreement1,
                    onChanged: (bool? value) {
                      setState(() {
                        agreement1 = value ?? false;
                      });
                    },
                  ),
                  const Text('Tôi đồng ý với các điều khoản sử dụng Zalo'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: agreement2,
                    onChanged: (bool? value) {
                      setState(() {
                        agreement2 = value ?? false;
                      });
                    },
                  ),
                  const Text('Tôi đồng ý với các điều khoản Mạng xã hội của Zalo'),
                ],
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                if (agreement1 && agreement2) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => VerifyNumber(
                            number: data['code']! + _enterPhoneNumber.text,
                          )));
                } else {
                  // Hiển thị thông báo hoặc xử lý khác
                }
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
