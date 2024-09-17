import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';

class BottomSheetWidget extends StatelessWidget {
  final MuslimCubit cubit;
  int id;

  BottomSheetWidget({required this.cubit , required this.id});

  @override
  Widget build(BuildContext context) {
    return cubit.speedlist
        ? Container(
            height: 50.h,
            decoration: BoxDecoration(color: colors.back_background),
            child: Row(
              children: [
                size.width(30),
                Container(
                  height: 200.h,
                  child: Slider(
                    activeColor: colors.primary,
                    inactiveColor: colors.primary.withOpacity(0.3),
                    min: 0.1,
                    max: 3,
                    value: cubit.player.speed,
                    onChanged: (value) {
                      cubit.player.setSpeed(value);
                    },
                  ),
                ),
                size.width(30),
                Text("x${cubit.player.speed.roundToDouble()}",
                    style: textstyle.subtitle.copyWith(fontSize: 18.sp)),
              ],
            ),
          )
        : Container(
            height: 400.h,
            decoration: BoxDecoration(color: colors.back_background),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(20),
                  for (int i = 0; i < cubit.recitersarabic.length - 1; i++)
                    GestureDetector(
                      onTap: () {
                        cubit.getSurahAudio(
                            cubit.recitersarabic[i]['id'], id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.background,
                          border: Border.all(color: colors.primary, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                         Row(
                          children: [
                            size.width(10),
                            Text(
                              cubit.recitersarabic[i]['reciter_name'],
                              style: textstyle.subtitle.copyWith(
                                  color: colors.text, fontSize: 16.sp),
                            ),
                            size.width(15),
                            Text(
                              cubit.recitersarabic[i]['translated_name']
                                  ['name'],
                              style: textstyle.subtitle.copyWith(
                                  color: colors.text, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  size.height(10),
                  GestureDetector(
                    onTap: () {
                      cubit.bottomsheet = false;
                    },
                    child: Container(
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: textstyle.subtitle.copyWith(
                              color: colors.background, fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
