import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/zeker_model.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/appbarWidget.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/zeker/zekre.dart';

class Azkar extends StatefulWidget {
  const Azkar({super.key});

  @override
  State<Azkar> createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MuslimCubit(),
      child: BlocConsumer<MuslimCubit, MuslimState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<MuslimCubit>(context);

          return Scaffold(
            backgroundColor: colors.back_background,
            appBar: AppBarWidget(text: 'Azkar'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(10),
                  Container(
                    height: 50.h,
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        itemCount: azkarcategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              cubit.changecategory(index);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w),
                              width: 120,
                              decoration: BoxDecoration(
                                color: cubit.cateindex == index
                                    ? colors.primary
                                    : colors.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    azkarcategories[index],
                                    style: textstyle.subtitle.copyWith(
                                        fontSize: 17,
                                        color: cubit.cateindex == index
                                            ? colors.background
                                            : colors.primary,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  size.height(10),
                  Container(
                    height: MediaQuery.sizeOf(context).height - 200.h,
                    child: ListView.builder(
                        itemCount: cubit.test.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Zeker(
                              z: AzkerModel(
                                  category: cubit.test[index].category,
                                  count: cubit.test[index].count,
                                  description: cubit.test[index].description,
                                  reference: cubit.test[index].reference,
                                  content: cubit.test[index].content),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, MuslimState state) {},
      ),
    );
  }
}
