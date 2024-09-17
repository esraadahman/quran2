import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';

class textfiled1 extends StatefulWidget {
  String? name;
  String? hinttext;
  Icon? icon;
  bool? password;
  TextEditingController? controller;
  textfiled1(
      {super.key,
      required this.name,
      required this.hinttext,
      required this.icon,
      required this.password,
      required this.controller});

  @override
  State<textfiled1> createState() => _textfiledsState();
}

class _textfiledsState extends State<textfiled1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            size.width(30),
            Text(
              widget.name!,
              style: textstyle.maintitle.copyWith(fontSize: 20),
            ),
          ],
        ),
        size.height(10),
        Row(
          children: [
            size.width(25),
            Container(
              width: 280.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                  color: colors.sub_background,
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: widget.controller,
                obscureText: widget.password!,
                decoration: InputDecoration(
                  prefixIcon: widget.icon,
                  hintText: widget.hinttext,
                  suffixIcon: widget.password!
                      ? IconButton(
                          onPressed: () {}, icon: Icon(Icons.visibility_off))
                      : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
