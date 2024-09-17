import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';

class MeniWidget extends StatefulWidget {
  String? name;
  String? imagePath;

  MeniWidget({super.key,required this.name, required this.imagePath});

  @override
  State<MeniWidget> createState() => _MeniWidgetState();
}

class _MeniWidgetState extends State<MeniWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          size.height(5),
          Image(
              image: AssetImage(widget.imagePath!), width: 80.sp, height: 100.sp),
          size.width(5),
          Text(
            widget.name!,
            style: textstyle.subtitle.copyWith(
                fontSize: 25,
                color: colors.primary,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
