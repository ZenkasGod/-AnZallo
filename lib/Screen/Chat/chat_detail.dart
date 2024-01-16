import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatDetail extends StatefulWidget {
  final friendUid;
  final friendName;

  const ChatDetail({Key? key, this.friendUid, this.friendName})
      : super(key: key);

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
            'names': {
              currentUserId: FirebaseAuth.instance.currentUser?.displayName,
              friendUid: friendName
            }
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
      'friendName': friendName,
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
              backgroundColor: Colors.blue,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              title: Text(
                friendName,
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.videocam),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      reverse: true,
                      children: snapshot.data!.docs.map(
                            (DocumentSnapshot document) {
                          data = document.data()!;
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ChatBubble(
                              clipper: CustomChatBubbleClipper(
                                radius: 8.0,
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
                                  maxWidth:
                                  MediaQuery.of(context).size.width * 0.4,
                                  maxHeight: MediaQuery.of(context).size.height *
                                      0.4,
                                ),
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        data['msg'],
                                        style: TextStyle(
                                          color: isSender(
                                              data['uid'].toString())
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                        4),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, right: 8.0),
                                      child: Text(
                                        data['createdOn'] == null
                                            ? DateTime.now().toString()
                                            : DateFormat.Hm().format(
                                            data['createdOn'].toDate()),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: isSender(
                                              data['uid'].toString())
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
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
                            placeholder: 'Tin nhắn',
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class CustomChatBubbleClipper extends CustomClipper<Path> {
  final double radius;
  final BubbleType type;

  CustomChatBubbleClipper({required this.radius, required this.type});

  @override
  Path getClip(Size size) {
    Path path = Path();
    if (type == BubbleType.sendBubble) {
      path.moveTo(size.width, size.height);
      path.lineTo(size.width, radius);
      path.quadraticBezierTo(
          size.width, 0, size.width - radius, 0);
      path.lineTo(radius, 0);
      path.quadraticBezierTo(0, 0, 0, radius);
      path.lineTo(0, size.height - radius);
      path.quadraticBezierTo(0, size.height, radius, size.height);
      path.lineTo(size.width - radius, size.height);
      path.quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius);
      path.close();
    } else {
      path.moveTo(0, size.height);
      path.lineTo(0, radius);
      path.quadraticBezierTo(0, 0, radius, 0);
      path.lineTo(size.width - radius, 0);
      path.quadraticBezierTo(
          size.width, 0, size.width, radius);
      path.lineTo(size.width, size.height - radius);
      path.quadraticBezierTo(
          size.width, size.height, size.width - radius, size.height);
      path.lineTo(radius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - radius);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

enum BubbleType {
  sendBubble,
  receiverBubble,
}
