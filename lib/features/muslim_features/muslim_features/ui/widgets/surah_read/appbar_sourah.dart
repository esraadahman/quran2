import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';




class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;
  final VoidCallback onSettingsPressed;

  CustomAppBar({
    required this.title,
    required this.onBackPressed,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: colors.text,
        ),
        onPressed: onBackPressed,
      ),
      title: Text(
        title,
        style: textstyle.maintitle.copyWith(
          fontSize: 25.sp,
        ),
      ),
      centerTitle: true,
      backgroundColor: colors.back_background,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: colors.text,
          ),
          onPressed: () {
            // Navigator.pushNamed(context, AppRouter.search);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: colors.text,
          ),
          onPressed: onSettingsPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
