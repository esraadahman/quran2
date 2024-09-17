import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/navi/ui/screens/navi.dart';
import 'package:qurane2/features/Auth/ui/widgets/textfiled1.dart';
import 'package:qurane2/features/user_Info/cubit/cubit/user_info_cubit.dart';
import 'package:qurane2/features/user_Info/data/network_user.dart';
import 'package:qurane2/features/user_Info/ui/widgets/phone_textfiled.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoCubit(),
      child: BlocConsumer<UserInfoCubit, UserInfoState>(
        listener: (context, state) {
            if (state is SendUserDataFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: colors.background,
              content: Text(
                state!.failed!,
                style: textstyle.subtitle.copyWith(color: colors.primary),
              ),
            ));
          }
          if (state is SendUserDataLoaded) {
            context.navigateTo(navi());
          }
            if (state is GetcitiesLoading) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: colors.background,
              content: Text(
                'Loading...',
                style: textstyle.subtitle.copyWith(color: colors.primary),
              ),
            ));
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<UserInfoCubit>(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(80),
                  Row(
                    children: [
                      size.width(60),
                      Text(
                        "Profile Information",
                        style: textstyle.maintitle.copyWith(fontSize: 30),
                      )
                    ],
                  ),
                  size.height(25),
                  textfiled1(
                      controller: cubit.name,
                      name: "  Name",
                      hinttext: "  Enter your name",
                      icon: null,
                      password: false),
                  size.height(10),
                  Column(
            children: [
              Row(
                children: [
                  size.width(30),
                  Text(
                    "Phone",
                    style: textstyle.maintitle.copyWith(fontSize: 20),
                  ),
                ],
              ),
              size.height(10),
              Row(
                children: [
                  size.width(15),
                  cubit.code == false
                      ? IconButton(
                          color: colors.primary,
                          onPressed: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode:
                                  true, // optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  cubit.pagecountry = country;
                                  cubit.code = true;
                                  cubit.getCities(
                                      cubit.pagecountry!.name.toString());
                                });
                              },
                            );
                          },
                          icon: Icon(Icons.flag, color: colors.text))
                      : GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode:
                                  true, // optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  cubit.pagecountry = country;
                                  cubit.getCities(
                                      cubit.pagecountry!.name.toString());
                                });
                              },
                            );
                          },
                          child: Text(
                            cubit.pagecountry!.flagEmoji.toString(),
                            style: textstyle.subtitle,
                          )),

                  size.width(10),
                  // phone field
                  cubit.code == false
                      ? size.width(3)
                      : state is GetcitiesLoaded
                          ? Container(
                              width: 80.w,
                              height: 50.h,
                              child: DropdownButton(
                                value: cubit.selectedvalue.isEmpty?cubit.cities[0]:cubit.selectedvalue,
                                items: [
                                  for (int i = 0;
                                      i <= cubit.cities.length - 1;
                                      i++) ...{
                                    DropdownMenuItem(
                                      child: Text(cubit.cities[i]),
                                      value: '${cubit.cities[i]}',
                                    )
                                  }
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    cubit.selectedvalue = value.toString();
                                  });
                                },
                              ))
                          : size.width(10),

                  size.width(10),
                  Container(
                    width: 150.sp,
                    height: 40.sp,
                    decoration: BoxDecoration(
                        color: colors.sub_background,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: cubit.phone,
                      decoration: InputDecoration(
                        hintText: " Phone",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

                  // Textfiled_phone(
                  //   name: 'Phone',
                  // ),
                  size.height(15),
                  Row(
                    children: [
                      size.width(25),
                      Text(
                        "  Age",
                        style: textstyle.maintitle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  size.height(5),
                  Row(
                    children: [
                      Container(
                        width: 300.sp,
                        child: Slider(
                          thumbColor: colors.background,
                          value: cubit.age,
                          onChanged: (value) {
                            setState(() {
                              cubit.age = value;
                            });
                          },
                          min: 0,
                          max: 100,
                          activeColor: colors.primary,
                          inactiveColor: colors.primary.withOpacity(.3),
                        ),
                      ),
                      Text(
                        cubit.age.toStringAsFixed(0),
                        style: textstyle.maintitle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                  size.height(10),
                  Row(
                    children: [
                      size.width(25),
                      Text(
                        " Gender",
                        style: textstyle.maintitle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      size.width(30),
                      Container(
                        width: 218.sp,
                        height: 50.sp,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            size.width(6),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  cubit.male = true;
                                });
                              },
                              child: Container(
                                width: 100.sp,
                                height: 46.sp,
                                decoration: BoxDecoration(
                                  color: cubit.male
                                      ? colors.background
                                      : colors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    size.width(10),
                                    Icon(
                                      Icons.male,
                                      size: 20,
                                      color: cubit.male
                                          ? colors.primary
                                          : colors.background,
                                    ),
                                    size.width(5),
                                    Text(
                                      "Male",
                                      style: textstyle.maintitle.copyWith(
                                          fontSize: 20,
                                          color: cubit.male
                                              ? colors.primary
                                              : colors.background),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            size.width(6),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  cubit.male = false;
                                });
                              },
                              child: Container(
                                width: 100.sp,
                                height: 46.sp,
                                decoration: BoxDecoration(
                                  color: cubit.male
                                      ? colors.primary
                                      : colors.background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    size.width(10),
                                    Icon(
                                      Icons.female,
                                      size: 20,
                                      color: cubit.male
                                          ? colors.background
                                          : colors.primary,
                                    ),
                                    size.width(5),
                                    Text(
                                      "Female",
                                      style: textstyle.maintitle.copyWith(
                                          fontSize: 20,
                                          color: cubit.male
                                              ? colors.background
                                              : colors.primary),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  size.height(25),
                  GestureDetector(
                    onTap: () {
                    cubit.sendUserData(cubit.name.text.trim() ,
                          cubit.selectedvalue ,
                           cubit.pagecountry!.name.toString(),
                          cubit.phone.text.trim() ,
                          cubit.age.round().toString() ,
                          cubit.male == true ? 'Male' : 'Female',
                          );
  //  print(cubit.name.text.trim() +
  //                       "     "+  cubit.selectedvalue +"   "+
  //                          cubit.pagecountry!.name.toString() +
  //                           "   " +
  //                         cubit.phone.text.trim()  +
  //                           "   " +
  //                         cubit.age.round().toString()  +
  //                                   "   " +
  //               '${cubit.male == true ? 'Male' : 'Female'}'
  //                         );
                    },
                    child: Container(
                      width: 300.sp,
                      height: 50.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.primary),
                      child: Center(
                        child: Text(
                            state is SendUserDataLoading
                              ? 'Loading...'
                              : 'Save changes',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
