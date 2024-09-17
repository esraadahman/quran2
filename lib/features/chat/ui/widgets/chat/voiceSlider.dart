import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/chat/cubit/chat/cubit/chat_cubit.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';

class VoiceSlider extends StatelessWidget {
  String url;

  VoiceSlider({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getAudio(url),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<ChatCubit>(context);
          return Column(
            children: [
              Row(
                children: [
                  state is GetVoiceLoading?
                  CircularProgressIndicator(color: colors.primary,)
                  :
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
                      size: 25,
                      color: colors.primary,
                    ),
                  ),
                  Container(
                    width: 135.w,
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
                ],
              ),
              Row(
                children: [
                  size.width(5.w),
                  Text(cubit.timeFormat(cubit.position),
                      style: textstyle.subtitle.copyWith(fontSize: 15.sp)),
                  size.width(50.w),
                  Text(cubit.timeFormat(cubit.duration),
                      style: textstyle.subtitle.copyWith(fontSize: 15.sp)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
