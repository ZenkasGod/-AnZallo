import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 20,
                // Đặt ảnh avatar tại đây
              ),
              SizedBox(width: 8.0),
              Text(
                'Hôm nay bạn thế nào ?',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          buildZaloStories(),
        ],
      ),
    );
  }

  Widget buildZaloStories() {
    return SizedBox(
      height: 30.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: buildStoryButtons(),
      ),
    );
  }

  List<Widget> buildStoryButtons() {
    return [
      _buildIconTextContainer(Icons.image, Colors.greenAccent, "Ảnh"),
      const SizedBox(width: 8.0),
      _buildIconTextContainer(Icons.videocam, Colors.purpleAccent, "Video"),
      const SizedBox(width: 8.0),
      _buildIconTextContainer(Icons.photo_camera_back, Colors.blue, "Album"),
      const SizedBox(width: 8.0),
      _buildIconTextContainer(Icons.lock_clock, Colors.redAccent, "Kỷ niệm"),
    ];
  }

  Widget _buildIconTextContainer(IconData icon, Color color, String text) {
    return ElevatedButton.icon(
      onPressed: () {
        // Xử lý khi nhấn vào biểu tượng
      },
      icon: Icon(
        icon,
        color: color,
      ),
      label: Text(
        text,
        style: const TextStyle(fontSize: 10, color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ), backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      ),
    );
  }
}
