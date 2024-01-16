import 'package:flutter/material.dart';

import '../../../../Const/page.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            icon: const Icon(Icons.photo_camera_back_rounded),
            color: Colors.white,
            onPressed: () {
              // Xử lý khi nhấn nút Scan
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_alert_sharp),
            color: Colors.white,
            onPressed: () {
              // Xử lý khi nhấn nút Scan
            },
          ),

        ],
      ),
    );
  }
}
