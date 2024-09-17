import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/Auth/cubit/cubit/auth_cubit.dart';

class buttons_for_sign extends StatefulWidget {
  buttons_for_sign({
    super.key,
  });

  @override
  State<buttons_for_sign> createState() => _buttons_for_signState();
}

class _buttons_for_signState extends State<buttons_for_sign> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<AuthCubit>(context);
          return Column(
            children: [
              size.height(10),
              Text(
                "Or continue with",
                style: textstyle.subtitle.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  size.width(100),
                  IconButton(
                      onPressed: () {
                        cubit.signInWithGoogle();
                      },
                      icon: Icon(
                        Bootstrap.google,
                        size: 50,
                        color: colors.primary,
                      )),
                  size.width(25),
                  Container(
                    color: colors.sub_background,
                    height: 40.h,
                    width: 2.h,
                  ),
                  size.width(25),
                  Icon(
                    Icons.facebook_outlined,
                    size: 70,
                    color: colors.primary,
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
