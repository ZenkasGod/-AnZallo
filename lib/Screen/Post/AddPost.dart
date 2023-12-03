import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: const CircleAvatar(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: const Text(
                      "Huy Huynh",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.more_horiz),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 150,
              minWidth: 150,
              maxHeight: 350.0,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Image.network(
                "https://cdn.oneesports.vn/cdn-data/sites/4/2023/08/One-Piece-Gear-5.jpg"),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    likeCount += isLiked ? 1 : -1;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, right: 8.0),
                  alignment: Alignment.center,
                  height: 27,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 30,
                        child: Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.pink : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yêu thích',
                              style: TextStyle(
                                fontSize: 12,
                                color: isLiked ? Colors.pink : Colors.grey,
                              ),
                            ),
                            Text(
                              '$likeCount',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 8.0),
                alignment: Alignment.center,
                height: 50,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 30,
                      child: const Icon(Icons.chat, color: Colors.grey),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Chat',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
