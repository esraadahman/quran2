import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/tasphmodel.dart';


class TasphWidget extends StatelessWidget {
  int? x;

  TasphWidget({super.key, required this.x});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      height: 40.h,
      width: 270.w,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          size.height(40),
          Text(
            tasabehList[x!].content,
            style: textstyle.maintitle
                .copyWith(fontSize: fontSize(tasabehList[x!].content.length)
                    //fontSize: 20
                    ),
            textAlign: TextAlign.center,
          ),
          size.height(30),
          Text(
            tasabehList[x!].description,
            style: textstyle.maintitle.copyWith(
                fontSize: subfontsize(tasabehList[x!].description.length),
                color: colors.subtext),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
    
  }
}
