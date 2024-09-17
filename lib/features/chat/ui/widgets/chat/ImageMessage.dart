import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/chat/cubit/chat/cubit/chat_cubit.dart';
import 'package:video_player/video_player.dart';

class ImageMessage extends StatefulWidget {
  String? username;
  String? time;
  String? messageUrl;
  bool? seen;
  bool? isSender;
  bool? isVideo;
  final ChatCubit cubit;

  ImageMessage(
      {super.key,
      required this.username,
      required this.time,
      required this.messageUrl,
      required this.seen,
      required this.isSender,
      required this.isVideo,
      required this.cubit});

  @override
  State<ImageMessage> createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      // autoPlay: true,
      allowFullScreen: true,
      autoInitialize: true,
      showControls: true,
      showOptions: true,
    );

    print("     issender ${widget.isSender}   ");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isVideo == true
          ? MediaQuery.sizeOf(context).width * .6
          : MediaQuery.sizeOf(context).width * .5,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20, left: 10),
      decoration: BoxDecoration(
        color: widget.isSender == true ? colors.primary : colors.background,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: widget.isSender == false
                ? Radius.circular(20)
                : Radius.circular(0),
            bottomLeft: widget.isSender == true
                ? Radius.circular(20)
                : Radius.circular(0)),
      ),
      child: Column(
        children: [
          size.height(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.username!,
                style: textstyle.subtitle
                    .copyWith(fontSize: 12.sp, color: colors.text),
              ),
              size.width(10.w),
            ],
          ),
          Container(
              width: MediaQuery.sizeOf(context).width * .5,
              height: 150.h,
              decoration: widget.isVideo == true
                  ? BoxDecoration()
                  : BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.messageUrl!),
                          fit: BoxFit.cover)),
              child: widget.isVideo == true
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Chewie(
                        controller: _chewieController,
                      ))
                  : null),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              size.width(5.w),
              Text(
                widget.time!,
                style: textstyle.subtitle
                    .copyWith(fontSize: 12.sp, color: colors.text),
              ),
              size.width(80.w),
              widget.isSender == true
                  ? Icon(
                      widget.seen == true ? Icons.done_all : Icons.done,
                      color: widget.seen == true ? colors.primary : colors.text,
                    )
                  : SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
