import 'package:flutter/material.dart';

import '../../Const/page.dart';


class Diary extends StatelessWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            children: [MyAppBar() , NewPost(), Stories(), AddPost()],
          ),
        ),
      ),
    );
  }
}