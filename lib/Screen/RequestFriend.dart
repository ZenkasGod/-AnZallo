import 'package:flutter/material.dart';

class RequestFriend extends StatefulWidget {
  const RequestFriend({super.key});

  @override
  RequestFriendState createState() => RequestFriendState();
}

class RequestFriendState extends State<RequestFriend>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lời mời kết bạn',
          style:TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Xử lý sự kiện khi nhấn vào nút setting
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black, // Set text color to black
              tabs: const [
                Tab(text: 'Đã nhận'),
                Tab(text: 'Đã gửi'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                // Tab Đã nhận
                FriendRequestList(sent: false),

                // Tab Đã gửi
                FriendRequestList(sent: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FriendRequestList extends StatelessWidget {
  final bool sent;

  const FriendRequestList({super.key, required this.sent});

  @override
  Widget build(BuildContext context) {
    // TODO: Thay thế dữ liệu dưới đây bằng danh sách lời mời kết bạn thực tế
    List<String> friendRequests = sent
        ? ['Người gửi 1', 'Người gửi 2', 'Người gửi 3']
        : ['Người nhận 1', 'Người nhận 2', 'Người nhận 3'];

    return ListView.builder(
      itemCount: friendRequests.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(friendRequests[index]),
          // Các thuộc tính khác của ListTile có thể được tùy chỉnh theo nhu cầu của bạn
        );
      },
    );
  }
}
