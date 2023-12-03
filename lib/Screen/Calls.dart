import 'package:doanchuyende/Screen/RequestFriend.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Calls extends StatelessWidget {
  const Calls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // User not authenticated, handle accordingly
      return const Center(
        child: Text("User not authenticated"),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              icon: const Icon(Icons.person_add),
              onPressed: () {
                // Xử lý khi nhấn vào icon +
              },
            ),
          ],
        ),
        body: SafeArea( // Add SafeArea here
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const TabBar(
                  labelColor: Colors.black, // Set text color to black
                  tabs: [
                    Tab(text: 'Bạn bè'),
                    Tab(text: 'Nhóm'),
                    Tab(text: 'OA'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    buildFriendsTab(currentUser),
                    buildGroupsTab(),
                    buildOATab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFriendsTab(User? currentUser) {
    return ListView(
      children: [
        // Add additional items above the user list
        Builder(
          builder: (context) => ListTile(
            leading: const Icon(Icons.person_add_alt_1, color: Colors.blue),
            title: const Text("Lời mời kết bạn"),
            onTap: () {
              // Chuyển đến trang giao diện Lời mời kết bạn
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RequestFriend(),
              ));
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.account_box_sharp, color: Colors.blue),
          title: const Text("Danh bạ máy"),

          // Add onTap handler for phone book
          onTap: () {
          },
        ),
        ListTile(
          leading: const Icon(Icons.cake_rounded, color: Colors.blue),
          title: const Text("Lịch sinh nhật"),
          // Add onTap handler for birthday calendar
          onTap: () {
          },
        ),
        const Divider(), // Add a divider between additional items and user list

        // Display the list of user tiles
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where('uid', isNotEqualTo: currentUser?.uid) // Exclude the current user
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

              return ListTile(
                onTap: () {

                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name ?? "No name"),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () {
                            // Handle phone icon click
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.videocam),
                          onPressed: () {
                            // Handle camera icon click
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList();

            return Column(
              children: userWidgets,
            );
          },
        ),
      ],
    );
  }



  Widget buildGroupsTab() {
    // You can implement the logic for fetching and displaying groups here
    return const Center(
      child: Text("Content for Nhóm tab"),
    );
  }

  Widget buildOATab() {
    // You can implement the logic for fetching and displaying OA here
    return const Center(
      child: Text("Content for OA tab"),
    );
  }
}
