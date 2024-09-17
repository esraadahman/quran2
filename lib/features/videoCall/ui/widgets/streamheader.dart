import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/videoCall/cubit/cubit/videocall_cubit.dart';
import 'package:qurane2/features/videoCall/ui/widgets/newstream.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class StreamHeader extends StatelessWidget {
  String text;
   //final VideocallCubit cubit;
  StreamHeader({super.key, required this.text,
  //  required this.cubit
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.h),
          child: Text(
            text,
            style: textstyle.maintitle.copyWith(fontSize: 28.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.w, top: 10.h),
          child: GestureDetector(
            onTap: () {
            WoltModalSheet.show<void>(
                // pageIndexNotifier: pageIndexNotifier,
                context: context,
                pageListBuilder: (modalSheetContext) {
                  return [
                    WoltModalSheetPage(
                      backgroundColor: colors.back_background,
                      child: newStream(),
                    ),
                  ];
                },
              );
            },
            child: Icon(
              Icons.add_circle_outline_sharp,
              size: 30.sp,
              color: colors.text,
            ),
          ),
        )
      ],
    );
  }
}
