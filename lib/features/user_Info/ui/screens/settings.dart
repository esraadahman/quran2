import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/Auth/data/network.dart';
import 'package:qurane2/features/Auth/ui/screens/signin.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            size.height(50),
            Row(
              children: [
                size.width(10),
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: colors.primary,
                  child: Icon(
                    CupertinoIcons.person_circle,
                    size: 30.sp,
                  ),
                ),
                size.width(10),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "user name",
                          style: textstyle.maintitle.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    size.height(5),
                    Row(
                      children: [
                        size.width(40),
                        Text(
                          "esraadahman@gmail.com",
                          style: textstyle.subtitle.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            size.height(100),
            InkWell(
              onTap: () {
                networkAuth.signOut();
                context.navigateTo(signin());
              },
              child: Container(
                height: 50.h,
                width: 300.w,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "Sign Out",
                    style: textstyle.maintitle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
