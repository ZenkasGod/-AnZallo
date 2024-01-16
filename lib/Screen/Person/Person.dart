import 'package:flutter/material.dart';
import '../../Const/page.dart';

class Person extends StatelessWidget {
  const Person({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                // Xử lý khi nhấn nút Cài đặt
              },
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column đầu
              Row(
                children: [
                  // Ảnh avatar
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                    radius: 20,
                  ),
                  SizedBox(width: 16),
                  // Tên người dùng và subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên người dùng',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text('Xem trang cá nhân'),
                    ],
                  ),
                  Spacer(),
                  // Icon bên phải
                  Icon(Icons.swap_horizontal_circle_outlined),
                ],
              ),
              Divider(),
              SizedBox(height: 10),
              // Column thứ 2
              ListTile(
                leading: Icon(Icons.music_note, color: Colors.blue),
                title: Text('Nhạc chờ Zalo'),
                subtitle: Text('Đăng ký nhạc chờ thể hiện cá tính'),
              ),
              ListTile(
                leading: Icon(Icons.qr_code, color: Colors.blue),
                title: Text('Ví QR'),
                subtitle: Text('Lưu trữ và xuất trình các mã QR quan trọng'),
              ),
              ListTile(
                leading: Icon(Icons.cloud, color: Colors.blue),
                title: Text('Cloud của tôi'),
                // Add your functionality here
                trailing:
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
              ),
              Divider(),
              SizedBox(height: 10),
              // Column thứ 3
              ListTile(
                leading: Icon(Icons.data_usage, color: Colors.blue),
                title: Text('Dung lượng dữ liệu'),
                // Add your functionality here
                trailing:
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
              ),
              SizedBox(height: 10),
              // Column thứ 4
              Divider(),
              ListTile(
                leading: Icon(Icons.security, color: Colors.blue),
                title: Text('Tài khoản và bảo mật'),
                // Add your functionality here
                trailing:
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.blue),
                title: Text('Quyền riêng tư'),
                // Add your functionality here
                trailing:
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
