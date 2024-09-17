import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';

class streamcard extends StatelessWidget {
  streamcard({
    super.key,
    required this.username,
    required this.userimage,
    required this.countrycity,
    required this.streamtitle,
    required this.streamimage,
    required this.viewers,
  });
  String? username;
  String? userimage;
  String? countrycity;
  String? streamtitle;
  String? streamimage;
  int? viewers;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.4,
        height: MediaQuery.sizeOf(context).height * 0.4,
        //  height: 200,
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // stream image
            Stack(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.21,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(streamimage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // live icon
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                      height: 20.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: colors.LiveIcon,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Center(
                        child: Text(
                          'Live',
                          style: textstyle.subtitle.copyWith(
                              color: colors.background, fontSize: 13.sp,fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                // count of viewers
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                      height: 20.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: colors.text,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Center(
                        child: Text(
                          '${viewers!} 👁',
                          style: textstyle.subtitle.copyWith(
                              color: colors.background, fontSize: 10.sp),
                        ),
                      )),
                ),
                // stream title
                Positioned(
                  bottom: 10,
                  left: 7,
                  child: Center(
                    child: Text(
                      streamtitle!,
                      style: textstyle.maintitle.copyWith(
                          fontSize: 20.sp,
                          color: colors.primary),
                    ),
                  ),
                ),
              ],
            ),
            // user details [image , name and country and city]
            Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                height: MediaQuery.sizeOf(context).height * 0.08,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(userimage!),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username!,
                            style:
                                textstyle.maintitle.copyWith(fontSize: 17.sp),
                          ),
                          Text(
                            countrycity!,
                            style: textstyle.subtitle.copyWith(fontSize: 7.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
