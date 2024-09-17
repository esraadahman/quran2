import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/chat/ui/widgets/chat/voiceSlider.dart';

class VoicMessage extends StatelessWidget {
  String? username;
  String? time;
  String? message;
  bool? seen;
  bool? isSender;

  VoicMessage(
      {super.key,
      required this.username,
      required this.time,
      required this.message,
      required this.seen,
      required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .6,
      
      padding: EdgeInsets.only(left: 2,right: 2),
      margin: EdgeInsets.only(right: 20, left: 10),
      decoration: BoxDecoration(
        color: isSender == true ? colors.primary : colors.background,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: isSender == false
                ? Radius.circular(20)
                : Radius.circular(0),
            bottomLeft: isSender == true
                ? Radius.circular(20)
                : Radius.circular(0)),
      ),
      child: Column(
        children: [
          size.height(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                username!,
                style: textstyle.subtitle
                    .copyWith(fontSize: 12.sp, color: colors.text),
              ),
              size.width(10.w),
            ],
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * .5,
            height:65.h,
            child: VoiceSlider(url: message!,),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              size.width(5.w),
              Text(
                time!,
                style: textstyle.subtitle
                    .copyWith(fontSize: 12.sp, color: colors.text),
              ),
              size.width(80.w),
              isSender == true
                  ? Icon(
                      seen == true ? Icons.done_all : Icons.done,
                      color: seen == true ? colors.primary : colors.text,
                    )
                  : SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
