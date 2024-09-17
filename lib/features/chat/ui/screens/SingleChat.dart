import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/chat/cubit/chat/cubit/chat_cubit.dart';
import 'package:qurane2/features/chat/cubit/chats/cubit/chats_cubit.dart';
import 'package:qurane2/features/chat/data/network/single_chatNetwork.dart';
import 'package:qurane2/features/chat/ui/widgets/chat/sendMessage.dart';
import 'package:qurane2/features/chat/ui/widgets/chat/showMessages.dart';
import 'package:qurane2/features/chat/ui/widgets/userInfo.dart';

class SingleChat extends StatefulWidget {
  String imgPath;
  String userName;
  String chat_id;
  String userid;
  //String email;

  SingleChat({
    super.key,
    required this.userid,
    required this.chat_id,
    required this.imgPath,
    required this.userName,
  //  required this.email
  });

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  String lastseen = "";
  void getlastseen() async {
    String baselastseen = await SingleChatNetwork.getLastseen(widget.userid);
    setState(() {
      lastseen = baselastseen;
    });
  }

  @override
  void initState() {
    super.initState();
    getlastseen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()
        ..set_chatid(widget.chat_id)
        ..getallmessages(widget.chat_id)
        ..getLastseen(widget.userid)
        ..sennmark(widget.chat_id, widget.userid),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<ChatCubit>(context);

          return Scaffold(
            backgroundColor: colors.back_background,
            floatingActionButton: SendMessage(
              chatid: widget.chat_id,
            ),
            body: state is GetallMessagesLoading
                ? const CircularProgressIndicator(
                    color: colors.primary,
                  )
                : state is GetallMessagesSuccess
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            size.height(45.h),
                            Row(
                              children: [
                                size.width(20.w),
                                GestureDetector(
                                  onTap: () {
                                    context.goBack();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 25.sp,
                                    color: colors.text,
                                  ),
                                ),
                                size.width(5.w),
                                UserInfo(
                                  imgPath: widget.imgPath,
                                  userName: widget.userName,
                                  other: lastseen,
                                  userid: widget.userid, chatid: widget.chat_id,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .05,
                                ),
                                Icon(
                                  Icons.call_outlined,
                                  size: 25.sp,
                                  color: colors.text,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .1,
                                ),
                                Icon(
                                  Icons.videocam_outlined,
                                  size: 25.sp,
                                  color: colors.text,
                                ),
                              ],
                            ),

                            // contant of chat
                            Container(
                                height: MediaQuery.sizeOf(context).height * .68,
                                child: ShowMessage(
                                  chatid: widget.chat_id,
                                  cubit: cubit,
                                )),
                          ],
                        ),
                      )
                    : Container(
                        child: const Center(child: Text("error")),
                      ),
          );
        },
      ),
    );
  }
}
