import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  List<Post> posts = [
    Post(username: "Huy Huynh", imageURL: "https://cdn.oneesports.vn/cdn-data/sites/4/2023/08/One-Piece-Gear-5.jpg"),
    Post(username: "Le Bao", imageURL: "https://i.pinimg.com/originals/3a/3c/ab/3a3cabd94347cf64dade52882308c780.jpg"),

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: posts.map((post) => buildPost(post)).toList(),
    );
  }

  Widget buildPost(Post post) {
    return Container(
      height: 380,
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
                    child: Text(
                      post.username,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
            child: Image.network(post.imageURL),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    post.isLiked = !post.isLiked;
                    post.likeCount += post.isLiked ? 1 : -1;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, right: 8.0),
                  alignment: Alignment.center,
                  height: 35,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 30,
                        child: Icon(
                          Icons.favorite,
                          color: post.isLiked ? Colors.pink : Colors.grey,
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
                                color: post.isLiked ? Colors.pink : Colors.grey,
                              ),
                            ),
                            Text(
                              '${post.likeCount}',
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

class Post {
  final String username;
  final String imageURL;
  bool isLiked;
  int likeCount;

  Post({required this.username, required this.imageURL, this.isLiked = false, this.likeCount = 0});
}
