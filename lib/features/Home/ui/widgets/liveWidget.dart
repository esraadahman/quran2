import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/Home/data/network/models.dart';
import 'package:qurane2/features/Home/ui/widgets/home_header.dart';
import 'package:qurane2/features/Home/ui/widgets/meni_widget.dart';
import 'package:qurane2/features/navi/ui/screens/navi.dart';

class LiveWidget extends StatelessWidget {
  String? image;

  LiveWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundImage: NetworkImage(image!),
          backgroundColor: colors.background,
        ),
        Positioned(
            right: 5,
            bottom: 40,
            child: Container(
                height: 20.h,
                width: 30.w,
                decoration: BoxDecoration(
                    color: colors.LiveIcon,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Live",
                    style: textstyle.subtitle.copyWith(
                        color: colors.background,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )))
      ],
    );
  }
}
