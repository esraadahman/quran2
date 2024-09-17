import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';

class textstyle {
  static TextStyle maintitle = TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: colors.text,
      fontFamily: 'Lexend');

  static TextStyle subtitle = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.normal,
      color: colors.subtext,
      fontFamily: 'Lexend');
}

double fontSize(int lenght) {
  if (lenght > 80)
    return 16.sp;
  else if (lenght >= 50)
    return 18.sp;
  else if (lenght >= 30)
    return 24.sp;
  else
    return 25.sp;
}

double subfontsize(int length) {
  if (length >= 80)
    return 8.sp;
  else if (length >= 50)
    return 12.sp;
  else if (length >= 30)
    return 18.sp;
  else
    return 15.sp;
}
