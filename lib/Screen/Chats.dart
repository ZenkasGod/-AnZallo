import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doanchuyende/Screen/chat_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  void callChatDetailScreen(BuildContext context, String? name, String? uid) {
    if (name != null && uid != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetail(
            friendName: name,
            friendUid: uid,
          ),
        ),
      );
    } else {
      // Handle the case where name or uid is null
    }
  }

  void _showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        const PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.person_add, color: Colors.grey),
              SizedBox(width: 8),
              Text("Thêm bạn"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.group, color: Colors.grey),
              SizedBox(width: 8),
              Text("Tạo nhóm"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(Icons.cloud, color: Colors.grey),
              SizedBox(width: 8),
              Text("Cloud của tôi"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              Icon(Icons.calendar_month, color: Colors.grey),
              SizedBox(width: 8),
              Text("Lịch Zalo"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 5,
          child: Row(
            children: [
              Icon(Icons.videocam, color: Colors.grey),
              SizedBox(width: 8),
              Text("Tạo cuộc gọi nhóm"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 6,
          child: Row(
            children: [
              Icon(Icons.computer_outlined, color: Colors.grey),
              SizedBox(width: 8),
              Text("Quản lý thiết bị đăng nhập"),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // User not authenticated, handle accordingly
      return const Center(
        child: Text("User not authenticated"),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .where('uid', isNotEqualTo: currentUser.uid) // Exclude the current user
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading state while data is being fetched
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("Error occurred. Please try again later."),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          // No other users found
          return const Center(
            child: Text("No other users available"),
          );
        }

        // Data available, build the UI
        List<Widget> userWidgets = snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
          String? name = userData['name'];
          String? uid = userData['uid'];

          return ListTile(  // Change CupertinoListTile to ListTile
            onTap: () => callChatDetailScreen(context, name, uid),
            title: Text(name ?? "No name"),
            subtitle: Text(userData['msg'] ?? "No status"),
          );
        }).toList();

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () {
                  // Xử lý khi nhấn vào icon scan
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _showPopupMenu(context);
                },
              ),
            ],
          ),
          body: ListView(
            children: userWidgets,
          ),

        );
      },
    );
  }
}
