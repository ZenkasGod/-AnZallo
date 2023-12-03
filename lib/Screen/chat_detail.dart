import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';


class ChatDetail extends StatefulWidget {
  final friendUid;
  final friendName;

  const ChatDetail({Key? key, this.friendUid, this.friendName}) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState(friendUid, friendName);
}

class _ChatDetailState extends State<ChatDetail> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final friendUid;
  final friendName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  final _textController = TextEditingController();
  _ChatDetailState(this.friendUid, this.friendName);
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    await chats
        .where('users', isEqualTo: {friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            chatDocId = querySnapshot.docs.single.id;
          });

        } else {
          await chats.add({
            'users': {currentUserId: null, friendUid: null},
            'names':{currentUserId:FirebaseAuth.instance.currentUser?.displayName,friendUid:friendName }
          }).then((value) => {chatDocId = value});
        }
      },
    )
        .catchError((error) {});
  }

  void sendMessage(String msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendName':friendName,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chats
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading"),
          );
        }

        if (snapshot.hasData) {
          var data;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              title: Text(friendName,
                  style: const TextStyle(fontSize: 16),
              ),

              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.phone),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.videocam_fill),
                ),
              ],
            ),
            body: CupertinoPageScaffold(
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        reverse: true,
                        children: snapshot.data!.docs.map(
                              (DocumentSnapshot document) {
                            data = document.data()!;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0), // Đặt bán kính tùy ý
                                child: ChatBubble(
                                  clipper: ChatBubbleClipper6(
                                    nipSize: 0,
                                    radius: 0,
                                    type: isSender(data['uid'].toString())
                                        ? BubbleType.sendBubble
                                        : BubbleType.receiverBubble,
                                  ),
                                  alignment: getAlignment(data['uid'].toString()),
                                  margin: const EdgeInsets.only(top: 20),
                                  backGroundColor: isSender(data['uid'].toString())
                                      ? const Color(0xFF75B6EE)
                                      : const Color(0xffE7E7ED),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            data['msg'],
                                            style: TextStyle(
                                              color: isSender(data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 4), // Khoảng cách giữa nội dung và thời gian
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                                          child: Text(
                                            data['createdOn'] == null
                                                ? DateTime.now().toString()
                                                : DateFormat.Hm().format(data['createdOn'].toDate()),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: isSender(data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: CupertinoTextField(
                              controller: _textController,
                            ),
                          ),
                        ),
                        CupertinoButton(
                            child: const Icon(Icons.send_sharp),
                            onPressed: () => sendMessage(_textController.text))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}