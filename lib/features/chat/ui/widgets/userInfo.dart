import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/chat/ui/screens/Profile.dart';

class UserInfo extends StatelessWidget {
  String imgPath;
  String userName;
  String other;
  String userid;
  String chatid;

  UserInfo(
      {super.key,
      required this.imgPath,
      required this.userName,
      required this.other,
      required this.userid,
      required this.chatid
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateTo(ProfileScreen(
          // name: userName,
          // imagepath: imgPath,
          // email: "esraa@",
          // phone: '123456789',
          // info: 'cairo',
          // lastSeen: other,
          userid: userid, chatid: chatid,
        ));
      },
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 30.r,
            //  backgroundImage: AssetImage("images/Rectangle5.png"),
            backgroundImage: NetworkImage(imgPath),
          ),
          size.width(5),
          Column(
            children: [
              Text(
                userName,
                style: textstyle.maintitle.copyWith(
                  fontSize: 20,
                ),
              ),
              Text(
                "Last seen $other",
                style: textstyle.subtitle
                    .copyWith(fontSize: 15, color: colors.text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
