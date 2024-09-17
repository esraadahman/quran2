import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';

class SettingsBottomSheet extends StatefulWidget {
  final MuslimCubit cubit1;
  final int? id;
  final VoidCallback onSavePressed;

  SettingsBottomSheet(
      {required this.cubit1, required this.id, required this.onSavePressed});

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      child: Column(
        children: [
          size.height(20),
          Text('Reading Mood',
              style: textstyle.maintitle.copyWith(fontSize: 20)),
          size.height(20),
          // Reading Mood Buttons
          Row(
            children: [
              size.width(20),
              GestureDetector(
                onTap: () {
                  widget.cubit1.setReadingMood('arabic', widget.id!);
                },
                child: Container(
                  width: 100.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.cubit1.readingmood == "arabic"
                        ? colors.primary
                        : colors.background,
                  ),
                  child: Center(
                    child: Text(
                      'Arabic',
                      style: textstyle.subtitle.copyWith(color: colors.text),
                    ),
                  ),
                ),
              ),
              size.width(10),
              GestureDetector(
                onTap: () {
                  widget.cubit1.setReadingMood('english', widget.id!);
                },
                child: Container(
                  width: 100.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.cubit1.readingmood == "english"
                        ? colors.primary
                        : colors.background,
                  ),
                  child: Center(
                    child: Text(
                      'English',
                      style: textstyle.subtitle.copyWith(color: colors.text),
                    ),
                  ),
                ),
              ),
              size.width(10),
              GestureDetector(
                onTap: () {
                  widget.cubit1.setReadingMood('both', widget.id!);
                },
                child: Container(
                  width: 100.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.cubit1.readingmood == "both"
                        ? colors.primary
                        : colors.background,
                  ),
                  child: Center(
                    child: Text(
                      'Both',
                      style: textstyle.subtitle.copyWith(color: colors.text),
                    ),
                  ),
                ),
              ),
            ],
          ),
          size.height(10),
          Text('Font Size ${widget.cubit1.sizefont}',
              style: textstyle.maintitle.copyWith(fontSize: 16.sp)),
          size.height(10),
          Slider(
            min: 10,
            max: 100,
            value: widget.cubit1.sizefont.toDouble(),
            onChanged: (value) {
              widget.cubit1.setfontsize(value.toInt());
            },
            activeColor: colors.primary,
            inactiveColor: colors.primary.withOpacity(0.3),
          ),
          size.height(20),
          Text('Font Color',
              style: textstyle.maintitle.copyWith(fontSize: 16.sp)),
          size.height(10),
          Row(
            children: [
              size.width(100),
              GestureDetector(
                onTap: () {
                  widget.cubit1.setcolor(
                    Color.fromARGB(255, 3, 105, 7),
                  );
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Color.fromARGB(255, 3, 105, 7),
                ),
              ),
              size.width(10),
              GestureDetector(
                onTap: () {
                  widget.cubit1.setcolor(colors.text);
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: colors.text,
                ),
              ),
              size.width(10),
              GestureDetector(
                onTap: () {
                  widget.cubit1.setcolor(colors.LiveIcon);
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: colors.LiveIcon,
                ),
              ),
            ],
          ),
          size.height(20),
          GestureDetector(
            onTap: () {
            
              widget.onSavePressed();
            },
            child: Container(
              width: 300.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors.primary,
              ),
              child: Center(
                child: Text('Save',
                    style:
                        textstyle.subtitle.copyWith(color: colors.background)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
