import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/Auth/cubit/cubit/auth_cubit.dart';
import 'package:qurane2/features/Auth/ui/screens/signin.dart';
import 'package:qurane2/features/Auth/ui/widgets/buttons_for_sign.dart';
import 'package:qurane2/features/Auth/ui/widgets/signheader.dart';
import 'package:qurane2/features/Auth/ui/widgets/textfiled1.dart';
import 'package:qurane2/features/user_Info/ui/screens/user_ifo.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: colors.back_background,
                content: Text(
                  state.response,
                  style: textstyle.subtitle
                      .copyWith(color: colors.text, fontSize: 20.sp),
                )));
            if (state.response == 'SignUp success') {
              context.navigateTo(UserInfoScreen());
            }
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<AuthCubit>(context);
          return Scaffold(
            backgroundColor: colors.background,
            body: SingleChildScrollView(
                child: Column(
              children: [
                signHeader(subheader: "Create Account"),
                // textfileds(),
                textfiled1(
                    controller: cubit.email_up,
                    name: "Email",
                    hinttext: "Enter your Email",
                    icon: Icon(Icons.email_outlined),
                    password: false),
                size.height(10),
                textfiled1(
                    controller: cubit.pass_up,
                    name: "Password",
                    hinttext: "Enter your password",
                    icon: Icon(Icons.lock_open),
                    password: true),
                size.height(10),
                Row(children: [
                  size.width(40),
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    checkColor: colors.subtext,
                  ),
                  Text('I agree with',
                      style: textstyle.subtitle
                          .copyWith(fontSize: 15, color: colors.text)),
                  Text(' Terms & condtions',
                      style: textstyle.subtitle.copyWith(
                          fontSize: 15,
                          color: colors.primary,
                          fontWeight: FontWeight.bold)),
                ]),
                size.height(10),
                GestureDetector(
                  onTap: () {
                    // print(email.text.trim() + "       ");
                    // print(pass.text.trim() + " ");

                    cubit.signUp(
                        cubit.email_up.text.trim(), cubit.pass_up.text.trim());
                  },
                  child: Container(
                    width: 300.sp,
                    height: 50.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.primary),
                    child: Center(
                      child: Text(
                        state is SignUpLoading ? 'Loading..' : 'Sign Up',
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
                    size.width(50),
                    Text(
                      "Do you have account ?",
                      style: textstyle.subtitle
                          .copyWith(color: colors.text, fontSize: 17),
                    ),
                    TextButton(
                        onPressed: () {
                          context.navigateTo(signin());
                        },
                        child: Text(
                          "Sign in Now!",
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
