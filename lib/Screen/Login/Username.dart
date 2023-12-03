import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doanchuyende/Screen/Home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Username extends StatefulWidget {
  const Username({Key? key}) : super(key: key);

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final _text = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  void createUserInFirestore() {
    users
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        // Use set instead of add
        users.doc(FirebaseAuth.instance.currentUser!.uid).set({
          'name': _text.text,
          'phone': FirebaseAuth.instance.currentUser!.phoneNumber,
          'status': 'Available',
          'uid': FirebaseAuth.instance.currentUser!.uid
        });
      }
    }).catchError((error) {
      // Handle error
    });
  }


  @override
  void initState() {
    _text.text = (FirebaseAuth.instance.currentUser?.displayName ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 4),
            const Text(
              'Tạo tài khoản',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: const Text(
                      'Tên Zalo',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          child: TextField(
                            controller: _text,
                            decoration: const InputDecoration(
                              hintText: 'Nhập tên của bạn',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.lightBlue,
                    height: 1,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 32, top: 8),
                    child: Text(
                      'Lưu ý khi đặt tên:',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, right: 35, top: 16),
                    child: Text('1. Không vi phạm Quy định đặt tên trên Zalo.'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, right: 35, top: 11),
                    child: Text('2. Nên sử dụng tên thật để giúp bạn bè nhận ra bạn.'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.currentUser
                      ?.updateProfile(displayName: _text.text);
                  // You can access the password with _password.text here
                  createUserInFirestore();
                  // For example, print(_password.text);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
