import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  String? username;
  String? lastSeen;
  String? email;
  String? age;
  String? phone;
  String? city;
  String? country;

  ProfileBody(
      {super.key,
      required this.username,
      required this.lastSeen,
      required this.age,
      required this.city,
      required this.country,
      required this.email,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        size.height(20),
        Text(
          "Name -: ${username}",
          style: textstyle.maintitle.copyWith(fontSize: 20.sp),
        ),
        size.height(5),
        Text(
          "  Last Seen ${lastSeen}",
          style: textstyle.subtitle.copyWith(fontSize: 17.sp),
        ),
        size.height(20),
        Text(
          "age -: ${age}",
          style: textstyle.subtitle.copyWith(fontSize: 17.sp),
        ),
          size.height(20),
        Text(
          "city -: ${city}",
          style: textstyle.subtitle.copyWith(fontSize: 17.sp),
        ),
          size.height(20),
        Text(
          "country -: ${country}",
          style: textstyle.subtitle.copyWith(fontSize: 17.sp),
        ),
        //user email
        size.height(20),
        Row(
          //    mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            size.width(MediaQuery.of(context).size.width * 0.2),

            // email icon
            Icon(
              Icons.email_outlined,
              size: 20.sp,
              color: colors.text,
            ),
            size.width(10.w),
            Text(
              " ${email}",
              style: textstyle.maintitle.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
        size.height(20),
        Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            size.width(MediaQuery.of(context).size.width * 0.2),

            // phone icon
            Icon(
              Icons.call_outlined,
              size: 20.sp,
              color: colors.text,
            ),
            size.width(10.w),
            Text(
              '    ${phone}',
              style: textstyle.maintitle.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
        //user phone number
      ],
    );
  }
}
