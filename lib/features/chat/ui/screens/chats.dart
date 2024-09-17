import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/chat/cubit/chats/cubit/chats_cubit.dart';
import 'package:qurane2/features/chat/data/network/chatsNetwork.dart';
import 'package:qurane2/features/chat/data/network/single_chatNetwork.dart';
import 'package:qurane2/features/chat/ui/screens/SingleChat.dart';
import 'package:qurane2/features/chat/ui/widgets/chats/IconRow.dart';
import 'package:qurane2/features/chat/ui/widgets/chats/chatHead.dart';
import 'package:qurane2/features/chat/ui/widgets/chats/liveUsers.dart';
import 'package:qurane2/features/chat/ui/widgets/chats/search.dart';
import 'package:qurane2/features/chat/ui/widgets/chats/usersSends.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  bool G_S = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()
        ..getallusers()
        ..getchats(),
      child: BlocConsumer<ChatsCubit, ChatsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<ChatsCubit>(context);
          return Scaffold(
            backgroundColor: colors.back_background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(40),
                  ChatsHeader(
                    text: 'Chats',
                    cubit: cubit,
                  ),
                  size.height(10),
                  Container(
                    height: 100.h,
                    child: StreamBuilder(
                        stream: cubit.getchats(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var chatInfo = cubit.setinfo_to_get_chat(
                                      snapshot.data!.docs[index]['userid']);
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          context.navigateTo(SingleChat(
                                            imgPath: snapshot.data!.docs[index]
                                                ['${chatInfo['image']}'],
                                            userName: snapshot.data!.docs[index]
                                                ['${chatInfo['name']}'],
                                            chat_id: snapshot.data!.docs[index]
                                                ['chatid'],
                                            userid: snapshot.data!.docs[index]
                                                ['${chatInfo['userid']}'],
                                          ));
                                        },
                                        child: LiveUsers(
                                            image: snapshot.data!.docs[index]
                                                ['${chatInfo['image']}']),
                                      ));
                                });
                          } else {
                            return Container(
                              child: Center(
                                  child: Text(
                                "No users online ",
                                style:
                                    textstyle.maintitle.copyWith(fontSize: 20),
                              )),
                            );
                          }
                        }),
                  ),
                  Search(),
                  size.height(15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //  size.width(20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            G_S = false;
                          });
                        },
                        child: IconsRow(
                          text: 'Chat 1-1',
                          icon: CupertinoIcons.chat_bubble_2_fill,
                          G_S: !G_S,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            G_S = true;
                          });
                        },
                        child: IconsRow(
                          text: 'Chat Group',
                          icon: CupertinoIcons.group_solid,
                          G_S: G_S,
                        ),
                      ),
                    ],
                  ),
                  G_S == false
                      ?
                      cubit.searching==""?
                      Container(
                          height: MediaQuery.sizeOf(context).height * 0.35,
                          child: StreamBuilder(
                            stream: cubit.getchats(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: colors.primary,
                                ));
                              } else if (snapshot.hasData) {
                                return ListView.separated(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var chatInfo = cubit.setinfo_to_get_chat(
                                        snapshot.data!.docs[index]['userid']);
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: GestureDetector(
                                            onTap: () {
                                              context.navigateTo(SingleChat(
                                                imgPath: snapshot
                                                        .data!.docs[index]
                                                    ['${chatInfo['image']}'],
                                                userName:
                                                    snapshot.data!.docs[index]
                                                        ['${chatInfo['name']}'],
                                                chat_id: snapshot.data!
                                                    .docs[index]['chatid'],
                                                userid: snapshot
                                                        .data!.docs[index]
                                                    ['${chatInfo['userid']}'],
                                              ));
                                            },
                                            child: UsersSends(
                                              imgPath:
                                                  snapshot.data!.docs[index]
                                                      ['${chatInfo['image']}'],
                                              userName:
                                                  snapshot.data!.docs[index]
                                                      ['${chatInfo['name']}'],
                                              message: snapshot.data!
                                                  .docs[index]['lastmassage'],
                                              time: snapshot.data!.docs[index]
                                                  ['lastmassagetime'],
                                            )));
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Divider(
                                        color: colors.subtext,
                                        thickness: 2.0,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: Text(
                                  "No chats yet",
                                  style: textstyle.maintitle,
                                ));
                              }
                            },
                          ),
                        )
                        :
                              Container(
                              height: MediaQuery.sizeOf(context).height * 0.35,
                              child: StreamBuilder(
                                stream: ChatsNetwork.getchatbychatid(cubit.chatid),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: colors.primary,
                                    ));
                                  } else if (snapshot.hasData) {
                                    return ListView.separated(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var chatInfo =
                                            cubit.setinfo_to_get_chat(snapshot
                                                .data!.docs[index]['userid']);
                                        return Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.w, right: 10.w),
                                            child: GestureDetector(
                                                onTap: () {
                                                  context.navigateTo(SingleChat(
                                                    imgPath: snapshot
                                                            .data!.docs[index][
                                                        '${chatInfo['image']}'],
                                                    userName: snapshot
                                                            .data!.docs[index]
                                                        ['${chatInfo['name']}'],
                                                    chat_id: snapshot.data!
                                                        .docs[index]['chatid'],
                                                    userid: snapshot
                                                            .data!.docs[index][
                                                        '${chatInfo['userid']}'],
                                                        // email: snapshot.data!
                                                        // .docs[index]['chatid'],
                                                  ));
                                                },
                                                child: UsersSends(
                                                  imgPath: snapshot
                                                          .data!.docs[index]
                                                      ['${chatInfo['image']}'],
                                                  userName: snapshot
                                                          .data!.docs[index]
                                                      ['${chatInfo['name']}'],
                                                  message:
                                                      snapshot.data!.docs[index]
                                                          ['lastmassage'],
                                                  time:
                                                      snapshot.data!.docs[index]
                                                          ['lastmassagetime'],
                                                )));
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Divider(
                                            color: colors.subtext,
                                            thickness: 2.0,
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                        child: Text(
                                      "No chats yet",
                                      style: textstyle.maintitle,
                                    ));
                                  }
                                },
                              ),
                            )
                      : Container(
                          child: Center(
                              child: Text(
                            "No groups yet ",
                            style: textstyle.maintitle.copyWith(fontSize: 20),
                          )),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
