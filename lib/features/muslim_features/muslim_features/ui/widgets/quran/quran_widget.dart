import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';


class QuarnWidget extends StatelessWidget {
  final int? index;
  QuarnWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MuslimCubit()..getQuranList(),
      child: BlocConsumer<MuslimCubit, MuslimState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<MuslimCubit>(context);
          return Container(
            height: 90.h,
            decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(255, 80, 113, 103),
                      blurRadius: 5,
                      offset: Offset(0, 1))
                ]),
            child: Row(children: [
              size.width(10),
              // surah number
              Text(
                "\u06DD" +
                    cubit.convertNumberToArabic((index! + 1).toString()).toString(),
                style: textstyle.subtitle
                    .copyWith(fontSize: 32.sp, color: colors.primary),
              ),
              size.width(10),
              // surah name in arabic and english
              Column(
                children: [
                  size.height(15),
                  Text(
                    cubit.quranlist[index!]["name"],
                    style: textstyle.subtitle.copyWith(
                        fontSize: 18.sp,
                        color: colors.text,
                        fontWeight: FontWeight.bold),
                  ),
                  size.height(2),
                  Text(
                    cubit.quranlist[index!]['englishName'],
                    style: textstyle.subtitle.copyWith(
                      fontSize: 14.sp,
                      color: colors.text,
                    ),
                  ),
                ],
              ),
              size.width(15),

              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          size.height(15),
                          GestureDetector(
                            onTap: () {
                              //        context.navigateTo(playSuarh(id:cubit.quranlist[index!]['number'],name:cubit.quranlist[index!]['name'],englishname: cubit.quranlist[index!]['englishName'],));
                            },
                            child: Container(
                              width: 55.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: colors.primary),
                                color: colors.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.play_arrow,
                                color: colors.primary,
                              )),
                            ),
                          ),
                        ],
                      ),
                      size.width(10),
                      Column(
                        children: [
                          size.height(15),
                          GestureDetector(
                            onTap: () {
                              //  context.navigateTo(surah(id:cubit.quranlist[index!]['number'],name:cubit.quranlist[index!]['name'],englishname: cubit.quranlist[index!]['englishName'],));
                            },
                            child: Container(
                              width: 55.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: colors.primary),
                                color: colors.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.menu_book_outlined,
                                color: colors.primary,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  size.height(15),
                  Row(
                    children: [
                      Text(
                        cubit.quranlist[index!]['revelationType'],
                        style: textstyle.subtitle.copyWith(
                          fontSize: 14.sp,
                          color: colors.text,
                        ),
                      ),
                      size.width(5),
                      Text(
                        'Ayahs: ' +
                            cubit.quranlist[index!]['numberOfAyahs'].toString(),
                        style: textstyle.subtitle.copyWith(
                          fontSize: 13.sp,
                          color: colors.text,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              size.width(15),

              // type of the surah and its ayat count
            ]),
          );
        },
      ),
    );
  }
}
