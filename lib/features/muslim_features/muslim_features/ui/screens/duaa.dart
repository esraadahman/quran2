import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/duaa_model.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/zeker_model.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/appbarWidget.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/zeker/zekre.dart';

class Duaa extends StatefulWidget {
  const Duaa({super.key});

  @override
  State<Duaa> createState() => _duaaState();
}

class _duaaState extends State<Duaa> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MuslimCubit(),
        child: BlocConsumer<MuslimCubit, MuslimState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<MuslimCubit>(context);

            return Scaffold(
              backgroundColor: colors.back_background,
              //AppBar
              appBar: AppBarWidget(text: 'Duaa'),
              // body
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    size.height(15),

                    Container(
                      height: 60.h,
                      child: ListView.builder(
                        itemCount: duaacategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              cubit.changecategoryduaa(index);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 40.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                color: cubit.cateindexforduaa == index
                                    ? colors.primary
                                    : colors.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    duaacategories[index],
                                    style: textstyle.maintitle.copyWith(
                                        fontSize: 15.sp,
                                        color: cubit.cateindexforduaa == index
                                            ? colors.background
                                            : colors.primary),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    size.height(15),
                    // listview vertical for zekr
                    Container(
                      height: MediaQuery.of(context).size.height - 200.h,
                      child: ListView.builder(
                        itemCount: cubit.duaatest.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Zeker(
                              z: AzkerModel(
                                  category: cubit.duaatest[index].category,
                                  count: cubit.duaatest[index].count,
                                  description:
                                      cubit.duaatest[index].description,
                                  reference: cubit.duaatest[index].reference,
                                  content: cubit.duaatest[index].content),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ));
  }
}
