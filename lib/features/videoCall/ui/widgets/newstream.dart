import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/videoCall/cubit/cubit/videocall_cubit.dart';

class newStream extends StatelessWidget {
  newStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideocallCubit(),
      child: BlocConsumer<VideocallCubit, VideocallState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<VideocallCubit>(context);
          return Container(
            height: 400.h,
            child: Column(
              children: [
                size.height(5),
                Text('Start a new stream',
                    style: textstyle.maintitle.copyWith(fontSize: 20.sp)),
                size.height(20),
                // upload stream's Image
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          //cubit.uploadImage(false);
                          cubit.profilePic = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (cubit.profilePic != null) {
                            print("enter if not null");

                            await cubit.sendimage(
                              image: cubit.profilePic!,
                            );
                          } else {
                            print("No image selected");
                          }
                        },
                        child: Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: colors.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: state is Videocall_image_success
                              ? Image(
                                  image: NetworkImage(
                                    cubit.image_url,
                                  ),
                                  fit: BoxFit.fitWidth,
                                )
                              : Icon(
                                  Icons.add_a_photo,
                                  size: 50.sp,
                                  color: colors.text,
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Upload Stream Image',
                                style: textstyle.maintitle
                                    .copyWith(fontSize: 16.sp)),
                            size.height(10.h),
                            Text('Select an image or take it',
                                style: textstyle.maintitle
                                    .copyWith(fontSize: 12.sp)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                size.height(20),
                // text field for stream title
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: TextField(
                    controller:cubit.streamname,
                    decoration: InputDecoration(
                      filled: true,
                      
                      fillColor: colors.background,
                      hintText: 'Stream Title',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: colors.sub_background, width: 0)),
                    ),
                  ),
                ),
                size.height(20),
                // text field for stream id
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: TextField(
                    controller: cubit.streamid,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colors.background,
                      hintText: 'Stream ID  [write 4 numbers]',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: colors.sub_background, width: 0)),
                    ),
                  ),
                ),
                size.height(20),
                // create button
                GestureDetector(
                  onTap: () {
                    if (cubit.image_url.isNotEmpty) {
                      cubit.createStream(cubit.streamname.text, cubit.streamid.text);
                    }
                    context.navigateTo(JoinScreen(streamname:streamname.text,id:"",join:false));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Container(
                      height: 50.h,
                      width: 100.w,0.
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('Create',
                            style: textstyle.maintitle.copyWith(
                                fontSize: 16.sp, color: colors.background)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
