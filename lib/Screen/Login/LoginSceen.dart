import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(), // Mũi tên "Back" trên tiêu đề
        title: const Text("Đăng Nhập"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Vui lòng nhập số điện thoại và mật khẩu để đăng nhập.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Số Điện Thoại",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: "Mật Khẩu",
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft, // Đặt vị trí "Lấy lại mật khẩu" sang bên trái
              child: GestureDetector(
                onTap: () {
                  // Xử lý lấy lại mật khẩu ở đây
                  // Ví dụ: Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                  // Thay thế ví dụ trên bằng cách mở màn hình "Lấy Lại Mật Khẩu"
                },
                child: const Text(
                  "Lấy lại mật khẩu",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Xử lý câu hỏi thường gặp ở đây
                        // Ví dụ: Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
                        // Thay thế ví dụ trên bằng cách mở màn hình "Câu Hỏi Thường Gặp"
                      },
                      child: const Text("Câu hỏi thường gặp >"),
                    ),
                    ElevatedButton(
                      onPressed: () {

                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<CircleBorder>(
                          const CircleBorder(),
                        ),
                      ),
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
