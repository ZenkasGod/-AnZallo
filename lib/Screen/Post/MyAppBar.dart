import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: kToolbarHeight,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Tìm kiếm",
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.photo_camera_back),
          onPressed: () {
            // Xử lý khi nhấn vào icon scan
          },
        ),
        IconButton(
          icon: const Icon(Icons.add_alert_sharp),
          onPressed: () {
            // Xử lý khi nhấn vào icon thêm
          },
        ),
      ],
    );
  }
}
