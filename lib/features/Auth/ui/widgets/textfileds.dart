import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';

class textfileds extends StatefulWidget {
  const textfileds({super.key});

  @override
  State<textfileds> createState() => _textfiledsState();
}

class _textfiledsState extends State<textfileds> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 290),
          child: Text(
            "Email",
            style: textstyle.subtitle,
          ),
        ),
        size.height(10),
        Container(
          width: 330.sp,
          height: 50.sp,
          decoration: BoxDecoration(
              color: colors.sub_background,
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email),
              hintText: 'Enter Your Email',
            ),
          ),
        ),
        size.height(20),
        Padding(
          padding: const EdgeInsets.only(right: 270),
          child: Text(
            "Password",
            style: textstyle.subtitle,
          ),
        ),
        size.height(10),
        Container(
          width: 330.sp,
          height: 50.sp,
          decoration: BoxDecoration(
              color: colors.sub_background,
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              icon: Icon(Icons.lock),
              hintText: 'Enter Your Password',
              suffixIcon:
                  IconButton(onPressed: () {}, icon: Icon(Icons.visibility)),
            ),
          ),
        ),
      ],
    );
  }
}
