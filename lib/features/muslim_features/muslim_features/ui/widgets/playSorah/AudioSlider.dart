import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';


class AudioSlider extends StatelessWidget {
  final MuslimCubit cubit;

  AudioSlider({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300.w,
          child: Slider(
            activeColor: colors.primary,
            inactiveColor: colors.primary.withOpacity(0.3),
            min: 0,
            max: cubit.duration.inSeconds.toDouble(),
            value: cubit.position.inSeconds.toDouble(),
            onChanged: (value) {
              cubit.player.seek(Duration(seconds: value.toInt()));
              cubit.player.setVolume(cubit.volume / 100);
            },
          ),
        ),
        Row(
          children: [
            size.width(40),
            Text(cubit.timeFormat(cubit.position),
                style: textstyle.subtitle.copyWith(fontSize: 15.sp)),
            size.width(130),
            Text(cubit.timeFormat(cubit.duration),
                style: textstyle.subtitle.copyWith(fontSize: 15.sp)),
          ],
        ),
      ],
    );
  }
}
