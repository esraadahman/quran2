import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/navi/ui/screens/navi.dart';
import 'package:qurane2/features/user_Info/cubit/cubit/user_info_cubit.dart';

class Textfiled_phone extends StatefulWidget {
  String? name;

  Textfiled_phone({
    super.key,
    required this.name,
  });

  @override
  State<Textfiled_phone> createState() => _textfiledsState();
}

class _textfiledsState extends State<Textfiled_phone> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoCubit(),
      child: BlocConsumer<UserInfoCubit, UserInfoState>(
        listener: (context, state) {
        
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<UserInfoCubit>(context);
          return Container();
        },
      ),
    );
  }
}
