
import 'package:flutter/cupertino.dart';

import '../../Const/page.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);

  var Screen = [const Chats(), const Calls(), const Diary(), const Person()];

  @override
  Widget build (BuildContext context){
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        resizeToAvoidBottomInset: true,
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              label: "Tin nhắn",
              icon: Icon(CupertinoIcons.chat_bubble_text),
            ),
            BottomNavigationBarItem(
              label: "Danh bạ",
              icon: Icon(CupertinoIcons.person_crop_square_fill),
            ),
            BottomNavigationBarItem(
              label: "Nhật ký",
              icon: Icon(CupertinoIcons.clock_solid),
            ),
            BottomNavigationBarItem(
              label: "Cá nhân",
              icon: Icon(CupertinoIcons.person),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return Screen[index];
        },
      ),
    );
  }
}