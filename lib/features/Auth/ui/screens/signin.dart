import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/Auth/cubit/cubit/auth_cubit.dart';
import 'package:qurane2/features/Auth/ui/screens/signup.dart';
import 'package:qurane2/features/Auth/ui/widgets/buttons_for_sign.dart';
import 'package:qurane2/features/Auth/ui/widgets/signheader.dart';
import 'package:qurane2/features/Auth/ui/widgets/textfiled1.dart';
import 'package:qurane2/features/Auth/ui/widgets/textfileds.dart';
import 'package:qurane2/features/Home/ui/screen/Home.dart';
import 'package:qurane2/features/navi/ui/screens/navi.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';


class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignInLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: colors.background,
                content: Text(
                  state.response,
                  style: textstyle.subtitle
                      .copyWith(color: colors.text, fontSize: 12.sp),
                )));

            if (state.response == 'SignIn success') {
              context.navigateTo(navi());
            }
          }
          if (state is ForgetPasswordLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: colors.background,
                content: Text(
                  state.response,
                  style: textstyle.subtitle
                      .copyWith(color: colors.text, fontSize: 12.sp),
                )));
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<AuthCubit>(context);

          return Scaffold(
            backgroundColor: colors.background,
            body: SingleChildScrollView(
                child: Column(
              children: [
                signHeader(subheader: "Welcome Back"),
                // textfileds(),
                textfiled1(
                    controller: cubit.email_in,
                    name: "Email",
                    hinttext: "Enter your Email",
                    icon: Icon(Icons.email),
                    password: false),
                size.height(10),
                textfiled1(
                    controller: cubit.pass_in,
                    name: "Password",
                    hinttext: "Enter your password",
                    icon: Icon(Icons.lock_open),
                    password: true),
                size.height(10),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      WoltModalSheet.show<void>(
                        // pageIndexNotifier: pageIndexNotifier,
                        context: context,
                        pageListBuilder: (modalSheetContext) {
                          return [
                            WoltModalSheetPage(
                              backgroundColor: colors.background,
                              child: Container(
                                height: 300.h,
                                child: Column(
                                  children: [
                                    size.height(20),
                                    Text('Forget Password ?',
                                        style: textstyle.maintitle
                                            .copyWith(fontSize: 20)),
                                    size.height(20),
                                    textfiled1(
                                      controller: cubit.forgetemail,
                                      name: 'Email',
                                      hinttext: 'Enter email',
                                      icon: Icon(Icons.email_outlined),
                                      password: false,
                                    ),
                                    size.height(20),
                                    GestureDetector(
                                      onTap: () {
                                        cubit.forgetPassword(
                                            cubit.forgetemail.text.trim());
                                      },
                                      child: Container(
                                        width: 300.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.primary),
                                        child: Center(
                                          child: Text(
                                              state is ForgetPasswordLoading
                                                  ? 'Loading..'
                                                  : 'Send Email',
                                              style: textstyle.subtitle
                                                  .copyWith(
                                                      color:
                                                          colors.background)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ];
                        },
                      );
                    },
                    child: Text('Forgot Password',
                        style: textstyle.subtitle
                            .copyWith(fontSize: 15, color: colors.primary)),
                  ),
                ),

                size.height(10),
                GestureDetector(
                  onTap: () {
                    cubit.signIn(
                        cubit.email_in.text.trim(), cubit.pass_in.text.trim());
                  },
                  child: Container(
                    width: 300.sp,
                    height: 50.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.primary),
                    child: Center(
                      child: Text(
                        state is SignInLoading ? 'Loading..' : 'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                size.height(10),
                buttons_for_sign(),
                size.height(10),

                Row(
                  children: [
                    size.width(10),
                    Text(
                      "Do you not have account ?",
                      style: textstyle.subtitle
                          .copyWith(color: colors.text, fontSize: 17),
                    ),
                    TextButton(
                        onPressed: () {
                          context.navigateTo(Sign_up());
                        },
                        child: Text(
                          "Sign up Now!",
                          style: textstyle.maintitle
                              .copyWith(fontSize: 20, color: colors.primary),
                        ))
                  ],
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
