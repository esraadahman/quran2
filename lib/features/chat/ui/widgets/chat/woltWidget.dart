import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/chat/cubit/chat/cubit/chat_cubit.dart';
import 'package:qurane2/features/chat/data/network/single_chatNetwork.dart';

class WoltWidget extends StatelessWidget {
  final ChatCubit cubit;
  
  String chatid;
  WoltWidget({super.key, required this.cubit, required this.chatid});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: Column(
        children: [
          size.height(10),
          // take photo
          GestureDetector(
            onTap: () async {
              cubit.profilePic =
                  await ImagePicker().pickImage(source: ImageSource.camera);

              if (cubit.profilePic != null) {
                print("enter if not null");

                await cubit.sendimage(chatid, cubit.profilePic!);
              } else {
                print("No image selected");
              }
            },
            child: ListTile(
              leading: Icon(Icons.camera_alt_outlined,
                  size: 25.sp, color: colors.text),
              title: Text('Take photo',
                  style: textstyle.subtitle.copyWith(
                      fontSize: 15.sp,
                      color: colors.text,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          size.height(10),
          // upload photo
          GestureDetector(
            onTap: () async {
              cubit.profilePic =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              if (cubit.profilePic != null) {
                print("enter if not null");

                await cubit.sendimage(chatid, cubit.profilePic!);
              } else {
                print("No image selected");
              }
            },
            child: ListTile(
              leading: Icon(Icons.image, size: 25.sp, color: colors.text),
              title: Text('Upload image',
                  style: textstyle.subtitle.copyWith(
                      fontSize: 15.sp,
                      color: colors.text,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          size.height(10),
          // upload video
          GestureDetector(
            onTap: () async {
              // cubit.video =
              //     await ImagePicker().pickVideo(source: ImageSource.gallery);

              // if (cubit.video != null) {
              //   await cubit.sendvideo(chatid, cubit.video!);
              // } else {
              //   print("No video selected");
              // }
               final XFile? video =
                  await ImagePicker().pickVideo(source: ImageSource.gallery);

              if (video != null) {
                await SingleChatNetwork.uploadVideo(chatid, video);
              } else {
                print("No video selected");
              }
            },
            child: ListTile(
              leading:
                  Icon(Icons.video_collection, size: 25.sp, color: colors.text),
              title: Text('Upload video',
                  style: textstyle.subtitle.copyWith(
                      fontSize: 15.sp,
                      color: colors.text,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
