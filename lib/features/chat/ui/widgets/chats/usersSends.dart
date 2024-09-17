import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';

class UsersSends extends StatefulWidget {
  String imgPath;
  String userName;
  String message;
  String time;

  UsersSends(
      {super.key,
      required this.imgPath,
      required this.userName,
      required this.message,
      required this.time});

  @override
  State<UsersSends> createState() => _UsersSendsState();
}

class _UsersSendsState extends State<UsersSends> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.r,
        //  backgroundImage: AssetImage("images/Rectangle5.png"),
        backgroundImage: NetworkImage(widget.imgPath),
      ),
      title: Text(
        widget.userName,
        style: textstyle.maintitle.copyWith(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        widget.message,
        style: textstyle.subtitle.copyWith(fontSize: 15, color: colors.text),
      ),
      trailing: Text(
        widget.time,
        style: textstyle.subtitle.copyWith(fontSize: 15, color: colors.text),
      ),
    );
  }
}
