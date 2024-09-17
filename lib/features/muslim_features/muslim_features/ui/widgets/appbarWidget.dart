import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  String? text;

   AppBarWidget({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: colors.text,
        ),
        onPressed: () {
          context.goBack();
        },
      ),
      title: Text(
      text!,
        style: textstyle.maintitle.copyWith(
          fontSize: 25.sp,
        ),
      ),
      centerTitle: true,
      backgroundColor: colors.back_background,
      elevation: 0,
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
