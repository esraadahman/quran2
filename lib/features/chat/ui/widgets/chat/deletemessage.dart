import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/chat/cubit/chat/cubit/chat_cubit.dart';
import 'package:qurane2/features/chat/data/network/single_chatNetwork.dart';

class deleteMessage extends StatelessWidget {
  final ChatCubit cubit;
  String chatid;
  String messageid;
  deleteMessage(
      {super.key,
      required this.cubit,
      required this.chatid,
      required this.messageid});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      child: Column(
        children: [
          size.height(10),
          GestureDetector(
            onTap: () {
              cubit.deletemessage(chatid, messageid);
            },
            child: ListTile(
              leading: Icon(Icons.delete, size: 25.sp, color: colors.text),
              title: Text('delete Message',
                  style: textstyle.subtitle.copyWith(
                      fontSize: 15.sp,
                      color: colors.text,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        //  size.height(10),
        ],
      ),
    );
  }
}
