import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/surah_read/appbar_sourah.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/surah_read/SettingsBottomSheet.dart';

class Sourah extends StatefulWidget {
  int? id;
  String? name;
  String? en_name;
  Sourah(
      {super.key, required this.id, required this.name, required this.en_name});

  @override
  State<Sourah> createState() => _SourahState();
}

class _SourahState extends State<Sourah> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MuslimCubit()..getSurah(widget.id!, " "),
        child:
            BlocConsumer<MuslimCubit, MuslimState>(listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          final cubit = BlocProvider.of<MuslimCubit>(context);
          if (state is SurahLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: colors.primary,
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: colors.back_background,
              appBar: CustomAppBar(
                title: cubit.readingmood == "arabic"
                    ? widget.name.toString()
                    : widget.en_name.toString(),
                onBackPressed: () => context.goBack(),
                onSettingsPressed: () {
                  setState(() {
                    cubit.showsettings = !cubit.showsettings;
                  });
                },
              ),
              body: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.3,
                        image: AssetImage("images/Rectangle13.png"),
                        fit: BoxFit.fitHeight),
                  ),
                  child: Column(
                    children: [
                      size.height(15),
                      widget.id == 1 || widget.id == 9
                          ? size.height(1)
                          : Text(
                              "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيم",
                              style: textstyle.subtitle.copyWith(
                                  fontSize: 25.sp,
                                  color: cubit.color1,
                                  fontWeight: FontWeight.bold),
                            ),
                      size.height(10),
                      // arabic or english or both
                      cubit.readingmood == "both"
                          ? Container(
                              height:
                                  MediaQuery.of(context).size.height - 200.h,
                              child: ListView.separated(
                                itemCount: cubit.surah_ar.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      size.height(15),
                                      Text(
                                        cubit.surah_ar[index]['text']
                                            .toString()
                                            .replaceAll(
                                                'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                                                ''),
                                        style: textstyle.subtitle.copyWith(
                                            fontSize: cubit.sizefont.toDouble(),
                                            color: cubit.color1,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      size.height(10),
                                      Text(
                                        cubit.surah_en[index]['text']
                                            .toString()
                                            .replaceAll(
                                                'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                                                ''),
                                        style: textstyle.subtitle.copyWith(
                                          fontSize: cubit.sizefont.toDouble(),
                                          color: cubit.color1,
                                          fontWeight: FontWeight.bold
                                        ),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      size.height(15),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Container(
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: colors.back_background,
                                    ),
                                    child: Row(
                                      children: [
                                        size.width(30),
                                        Text(
                                          '\u06DD' +
                                              cubit.convertNumberToArabic(cubit
                                                  .surah_en[index]['numberInSurah']
                                                  .toString()),
                                          style: textstyle.subtitle.copyWith(
                                            fontSize: 24.sp,
                                            color: colors.text,
                                          ),
                                        ),
                                        size.width(170),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.bookmark_border,
                                              color: colors.text,
                                            )),
                                        size.width(2),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.copy,
                                              color: colors.text,
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : RichText(
                              textAlign: TextAlign.center,
                              textDirection: cubit.readingmood == "arabic"
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              text: TextSpan(children: [
                                for (int i = 0;
                                    i < cubit.surah_ar.length;
                                    i++) ...{
                                  TextSpan(
                                    text: widget.id != 1
                                        ? cubit.surah_ar[i]['text']
                                                .toString()
                                                .replaceAll(
                                                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                                                    '') +
                                            '\u06DD' +
                                            cubit.convertNumberToArabic(cubit
                                                .surah_ar[i]['numberInSurah']
                                                .toString())
                                        : cubit.surah_ar[i]['text'].toString() +
                                            '\u06DD' +
                                            cubit.convertNumberToArabic(cubit
                                                .surah_ar[i]['numberInSurah']
                                                .toString()),
                                    style: textstyle.subtitle.copyWith(
                                        fontSize: cubit.sizefont.toDouble(),
                                        color: cubit.color1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                }
                              ])),
                    ],
                  ),
                ),
              ),
              bottomSheet: cubit.showsettings
                  ? SettingsBottomSheet(
                      cubit1: cubit,
                      id: widget.id,
                      onSavePressed: () {
                        setState(() {
                          cubit.showsettings = false;
                        });
                      },
                    )
                  : null,
            );
          }
        }));
  }
}
