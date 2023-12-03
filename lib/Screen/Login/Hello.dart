import 'package:doanchuyende/Screen/Login/RegisterAccount.dart';
import 'package:flutter/material.dart';
import 'LoginSceen.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/zalo_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Logo
              Image.asset(
                'images/zalo_logo.png',
                width: 370,
                height: 370,
              ),
              const SizedBox(height: 30),

              // Nút "Đăng nhập" mở rộng
              // Nút "Đăng nhập" với phần trái và phải thành nửa hình tròn
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Màu trắng cho chữ
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(50), right: Radius.circular(50)),
                  ),
                ),
                child: const SizedBox(
                  width: 200,
                  child: Center(child: Text("Đăng nhập")),
                ),
              ),
              const SizedBox(height: 20),

              // Nút "Đăng ký" với phần trái và phải thành nửa hình tròn
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterAccount()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue, backgroundColor: Colors.white, // Màu xanh cho chữ
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(50), right: Radius.circular(50)),
                  ),
                ),
                child: const SizedBox(
                  width: 200,
                  child: Center(child: Text("Đăng ký")),
                ),
              ),
              const SizedBox(height: 20),

              // Lựa chọn ngôn ngữ
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Xử lý khi chọn Tiếng Việt
                    },
                    child: const Text(
                      "Tiếng Việt",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      // Xử lý khi chọn English
                    },
                    child: const Text(
                      "English",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
