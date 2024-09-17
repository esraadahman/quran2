import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/zeker_model.dart';

class Zeker extends StatefulWidget {
  AzkerModel z;

  Zeker({super.key, required this.z});

  @override
  State<Zeker> createState() => _ZekerState();
}

class _ZekerState extends State<Zeker> {
  late int x = widget.z.count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.sp,
      decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.primary, width: 2.w)),
      child: Column(
        children: [
          size.height(20),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Text(
              widget.z.content,
              style: textstyle.subtitle.copyWith(
                fontSize: fontSize(widget.z.content.length),
                color: colors.text,
                fontWeight: FontWeight.bold,
              ),
              //  textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
          ),
          size.height(10),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Text(
              widget.z.description,
              style: textstyle.subtitle.copyWith(
                fontSize: 15,
                color: colors.subtext,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          size.height(10),
          GestureDetector(
            onTap: () {
              if (x > 0) {
                setState(() {
                  x--;
                });
              }
            },
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: x == 0
                  ? const Color.fromARGB(255, 185, 187, 194)
                  : colors.primary,
              child: Text(
                x.toString(),
                style: textstyle.maintitle
                    .copyWith(fontSize: 22, color: colors.background),
              ),
            ),
          )
        ],
      ),
    );
  }
}
