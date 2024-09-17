import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/chat/cubit/profile/cubit/profile_cubit.dart';
import 'package:qurane2/features/chat/ui/screens/chats.dart';
import 'package:qurane2/features/chat/ui/widgets/profile/buttons.dart';
import 'package:qurane2/features/chat/ui/widgets/profile/profileBody.dart';
import 'package:qurane2/features/chat/ui/widgets/profile/profileHead.dart';

class ProfileScreen extends StatelessWidget {
  // String name;
  // String imagepath;
  // String lastSeen;
  // String info;
  // String email;
  // String phone;
  String chatid;
  String userid;

// info = location
  ProfileScreen(
      {
      //   required this.name,
      // required this.imagepath,
      // required this.email,
      // required this.phone,
      // required this.info,
      // required this.lastSeen,
      required this.chatid,
      required this.userid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getuserinfo(userid),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<ProfileCubit>(context);

          return Scaffold(
              backgroundColor: colors.back_background,
              body: state is Profileloading?
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: colors.primary,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                        ProfileHeader(
                          imagePath: cubit.userinfo['userimage'],
                        ),

                        // user name
                        ProfileBody(
                          username: cubit.userinfo['username'],
                          lastSeen: cubit.userinfo['lastseen'],
                          city: cubit.userinfo['city'],
                          country: cubit.userinfo['country'],
                          email: cubit.userinfo['email'],
                          phone: cubit.userinfo['phonenumber'],
                          age: cubit.userinfo['age'],
                        ),

                        // delete and block buttons
                        size.height(40),
                        Row(
                          children: [
                            size.width(MediaQuery.of(context).size.width * 0.1),
                            // delete button
                            GestureDetector(
                              onTap: () {
                                cubit.deletechat(chatid);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: colors.primary,
                                  content: Text(
                                    "chat deleted ",
                                    style: TextStyle(color: colors.background),
                                  ),
                                  duration: Duration(seconds: 1),
                                ));
                                context.navigateTo(const Chats());
                              },
                              child: Buttons(
                                text: 'Delete',
                                colorButton: colors.background,
                                colortext: colors.primary,
                              ),
                            ),
                            size.width(20.w),
                            // block button
                            GestureDetector(
                              onTap: () {},
                              child: Buttons(
                                text: 'Block',
                                colorButton: colors.primary,
                                colortext: colors.background,
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ));
        },
      ),
    );
  }
}
