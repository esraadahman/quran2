import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/screens/playSourah.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/screens/surah.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/appbarWidget.dart';


class QuranList extends StatefulWidget {
  const QuranList({super.key});

  @override
  State<QuranList> createState() => _QuranListState();
}

class _QuranListState extends State<QuranList> {
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
          return Scaffold(
            appBar: AppBarWidget(text: 'Quran'),
            backgroundColor: colors.back_background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //  size.height(5),
                  //container for last read
                  Row(
                    children: [
                      size.width(20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.sizeOf(context).width - 40,
                        //width: 315.w,
                        height: 180.h,
                        decoration: BoxDecoration(
                            color: colors.primary.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 80, 113, 103),
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // texts
                                Column(
                                  children: [
                                    size.height(20),
                                    // last read
                                    Row(
                                      children: [
                                        Text(
                                          'Last Read',
                                          style: textstyle.maintitle.copyWith(
                                              color: colors.background,
                                              fontSize: 22.sp),
                                        ),
                                      ],
                                    ),
                                    size.height(25),
                                    // surah name
                                    Row(
                                      children: [
                                        Text(
                                          'Surah Al-Fatihah',
                                          style: textstyle.maintitle.copyWith(
                                              color: colors.text,
                                              fontSize: 18.sp),
                                        ),
                                      ],
                                    ),
                                    size.height(30),
                                    // surah No
                                    Row(
                                      children: [
                                        Text(
                                          'Surah NO.1',
                                          style: textstyle.maintitle.copyWith(
                                              color: colors.back_background,
                                              fontSize: 13.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                size.width(20),

                                // quran image
                                Column(
                                  children: [
                                    size.height(20),
                                    Image(
                                      image:
                                          AssetImage('images/Rectangle14.png'),
                                      width: 100.w,
                                      height: 150.h,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  size.height(10),
                  //  Quran list
                  state is QuranListLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: colors.primary,
                          ),
                        )
                      : Container(
                          height: MediaQuery.sizeOf(context).height - 200.h,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cubit.quranlist.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, bottom: 10.0),
                                    child:
                                        // QuarnWidget(x: index)
                                        Container(
                                      height: 90.h,
                                      decoration: BoxDecoration(
                                          color: colors.background,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color.fromARGB(
                                                    255, 80, 113, 103),
                                                blurRadius: 5,
                                                offset: Offset(0, 1))
                                          ]),
                                      child: Row(children: [
                                        size.width(10),
                                        // surah number
                                        Text(
                                          "\u06DD" +
                                              cubit
                                                  .convertNumberToArabic(
                                                      (index! + 1).toString())
                                                  .toString(),
                                          style: textstyle.subtitle.copyWith(
                                              fontSize: 32.sp,
                                              color: colors.primary),
                                        ),
                                        size.width(10),
                                        // surah name in arabic and english
                                        Column(
                                          children: [
                                            size.height(15),
                                            Text(
                                              
                                              cubit.quranlist[index]["name"],
                                              style: textstyle.subtitle
                                                  .copyWith(
                                                      fontSize: 18.sp,
                                                      color: colors.text,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            size.height(2),
                                            Text(
                                              cubit.quranlist[index]
                                                  ['englishName'],
                                              style:
                                                  textstyle.subtitle.copyWith(
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
                                                              context.navigateTo(
                                                            PlaySourah(id:cubit.quranlist[index]['number'],name:cubit.quranlist[index]['name'],englishname: cubit.quranlist[index]['englishName'],));
                                                      },
                                                      child: Container(
                                                        width: 55.w,
                                                        height: 35.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: colors
                                                                  .primary),
                                                          color:
                                                              colors.background,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                         context.navigateTo(Sourah(id:cubit.quranlist[index]['number'],name: cubit.quranlist[
                                                              index]['name'] ,en_name: cubit.quranlist[index]['englishName'],));
                                                        // context.navigateTo(
                                                        //     Sourah());
                                                      },
                                                      child: Container(
                                                        width: 55.w,
                                                        height: 35.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: colors
                                                                  .primary),
                                                          color:
                                                              colors.background,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Center(
                                                            child: Icon(
                                                          Icons
                                                              .menu_book_outlined,
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
                                                  cubit.quranlist[index]
                                                      ['revelationType'],
                                                  style: textstyle.subtitle
                                                      .copyWith(
                                                    fontSize: 14.sp,
                                                    color: colors.text,
                                                  ),
                                                ),
                                                size.width(5),
                                                Text(
                                                  'Ayahs: ' +
                                                      cubit.quranlist[index]
                                                              ['numberOfAyahs']
                                                          .toString(),
                                                  style: textstyle.subtitle
                                                      .copyWith(
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
                                    ));
                              }))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
