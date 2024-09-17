import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  String? text;
  Color? colortext;
  Color? colorButton;
  Buttons(
      {super.key,
      required this.text,
      required this.colorButton,
      required this.colortext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: colorButton,
        border: Border.all(
          color: colortext!,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
          child: Text(
        text!,
        style: textstyle.maintitle
            .copyWith(color: colortext, fontSize: 18.sp),
      )),
    );
  }
}
