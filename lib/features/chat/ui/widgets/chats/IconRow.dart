import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';

class IconsRow extends StatelessWidget {
  String text;
  IconData icon;
  //VoidCallback onPressed;
  bool G_S;

  IconsRow(
      {super.key,
      required this.text,
      required this.icon,
      required this.G_S});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
    width: MediaQuery.sizeOf(context).width*0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //  color: colors.background,
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              icon as IconData?,
              size: 25,
              color:G_S? colors.primary: colors.text,
            ),
            Text(
              text,
              style: textstyle.subtitle
                  .copyWith(fontSize: 15, color: G_S? colors.primary : colors.text),
            ),
            Divider(
              color: G_S ? colors.primary : colors.text,
              thickness: 2.0,
            )
          ],
        ),
      ),
    );
  }
}
