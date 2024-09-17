import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/tasphmodel.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/appbarWidget.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/tasph/tasph_widget.dart';


class Taspih extends StatefulWidget {
  const Taspih({super.key});

  @override
  State<Taspih> createState() => _TaspihState();
}

class _TaspihState extends State<Taspih> {
//  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MuslimCubit(),
      child: BlocConsumer<MuslimCubit, MuslimState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<MuslimCubit>(context);
          return Scaffold(
            backgroundColor: colors.back_background,
            appBar: AppBarWidget(text: 'Tasbih'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(10),
                  Container(
                      height: 220.h,
                      child: ListView.builder(
                        itemCount: tasabehList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return TasphWidget(
                            x: index,
                          );
                        },
                      )),
                  size.height(100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.resettasbeh();
                        },
                        child: Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: colors.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.restart_alt_outlined,
                            color: colors.primary,
                            size: 30.sp,
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.incresetasbeh();
                        },
                        child: Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: colors.background,
                            size: 30.sp,
                          )),
                        ),
                      ),
                    ],
                  ),
                  size.height(30),
                  // circle avatar for counter
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: colors.primary,
                    child: Center(
                        child: Column(
                      children: [
                        size.height(20),
                        Text(
                          //  count.toString(),
                          cubit.tasbehcount.toString(),
                          style: textstyle.maintitle.copyWith(
                              fontSize: 25.sp, color: colors.background),
                        ),
                        Text(
                          'Tasbeha',
                          style: textstyle.maintitle.copyWith(
                              fontSize: 15.sp, color: colors.background),
                        ),
                      ],
                    )),
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
