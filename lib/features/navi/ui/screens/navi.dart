import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/Home/ui/screen/Home.dart';
import 'package:qurane2/features/chat/data/network/single_chatNetwork.dart';
import 'package:qurane2/features/chat/ui/screens/chats.dart';
import 'package:qurane2/features/muslim_features/category/ui/screens/category.dart';
import 'package:qurane2/features/user_Info/ui/screens/settings.dart';
import 'package:qurane2/features/videoCall/ui/screens/stremScreen.dart';

List<Widget> screens = [
  Home(),
  Chats(),
  StreamScreen(),
  Category(),
  Settings()
];

class navi extends StatefulWidget {
  const navi({super.key});

  @override
  State<navi> createState() => _naviState();
}

class _naviState extends State<navi> {
  var varscreen = screens[0];
  int selector = 0;
  void selectorfun(int index) {
    setState(() {
      selector = index;
      varscreen = screens[index];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SingleChatNetwork.updateLastseen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: varscreen,
        floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 5, left: 30),
            height: 50.h,
            //  width: 350.sp,
            width: MediaQuery.sizeOf(context).width,
            color: colors.background,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  size.width(10),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            varscreen = screens[0];
                            selectorfun(0);
                          });
                        },
                        icon: Icon(Icons.home),
                        color: selector == 0 ? colors.primary : colors.text,
                        iconSize: 30,
                      ),
                      //  size.height(3),
                      Container(
                        height: 4.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: selector == 0
                              ? colors.primary
                              : colors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                  size.width(10),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            varscreen = screens[1];
                            selectorfun(1);
                          });
                        },
                        icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                        color: selector == 1 ? colors.primary : colors.text,
                        iconSize: 30,
                      ),
                      //  size.height(3),
                      Container(
                        height: 4.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: selector == 1
                              ? colors.primary
                              : colors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                  size.width(10),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            varscreen = screens[2];
                            selectorfun(2);
                          });
                        },
                        icon: Icon(Icons.video_call_outlined),
                        color: selector == 2 ? colors.primary : colors.text,
                        iconSize: 30,
                      ),
                      //  size.height(3),
                      Container(
                        height: 4.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: selector == 2
                              ? colors.primary
                              : colors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                  size.width(10),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            varscreen = screens[3];
                            selectorfun(3);
                          });
                        },
                        icon: Icon(Icons.menu_book_outlined),
                        color: selector == 3 ? colors.primary : colors.text,
                        iconSize: 30,
                      ),
                      //  size.height(3),
                      Container(
                        height: 4.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: selector == 3
                              ? colors.primary
                              : colors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                  size.width(10),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            varscreen = screens[4];
                            selectorfun(4);
                          });
                        },
                        icon: Icon(CupertinoIcons.person_alt_circle_fill),
                        color: selector == 4 ? colors.primary : colors.text,
                        iconSize: 30,
                      ),
                      //  size.height(3),
                      Container(
                        height: 4.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: selector == 4
                              ? colors.primary
                              : colors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                  size.width(10),
                ])));
  }
}
