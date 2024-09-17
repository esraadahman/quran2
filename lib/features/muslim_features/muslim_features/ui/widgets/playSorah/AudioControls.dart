import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';



class AudioControls extends StatelessWidget {
  final MuslimCubit cubit;

  AudioControls({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        size.width(35),
        IconButton(
          onPressed: () {
            cubit.bottomsheet = !cubit.bottomsheet;
            cubit.speedlist = !cubit.speedlist;
          },
          icon: Icon(Icons.speed, size: 30, color: colors.primary),
        ),
        IconButton(
          onPressed: () {
            cubit.player.seek(cubit.position - Duration(seconds: 10));
          },
          icon: Icon(CupertinoIcons.backward_end,
              size: 40, color: colors.primary),
        ),
        size.width(10),
        IconButton(
          onPressed: () {
            if (cubit.isPlaying == false) {
              cubit.player.play();
              cubit.isPlaying = true;
            } else {
              cubit.player.stop();
              cubit.isPlaying = false;
            }
          },
          icon: Icon(
            cubit.isPlaying == false
                ? CupertinoIcons.play_circle_fill
                : CupertinoIcons.stop_circle_fill,
            size: 55,
            color: colors.primary,
          ),
        ),
        size.width(15),
        IconButton(
          onPressed: () {
            cubit.player.seek(cubit.position + Duration(seconds: 10));
          },
          icon:
              Icon(CupertinoIcons.forward_end, size: 40, color: colors.primary),
        ),
        IconButton(
          onPressed: () {
            cubit.bottomsheet = !cubit.bottomsheet;
            cubit.speedlist = false;
          },
          icon: Icon(Icons.spatial_audio_off_outlined,
              size: 30, color: colors.primary),
        ),
      ],
    );
  }
}
