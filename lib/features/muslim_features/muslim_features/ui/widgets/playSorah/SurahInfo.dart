import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/appbarWidget.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/network/quran_network.dart';


class SurahInfo extends StatelessWidget {
  final String? name;
  final String? englishname;

  SurahInfo({required this.name, required this.englishname});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/Rectangle14.png'),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        children: [
          size.height(50),
          Row(
            children: [
              size.width(MediaQuery.of(context).size.width * 0.25),
              Text(name!, style: textstyle.maintitle),
            ],
          ),
          Row(
            children: [
              size.width(MediaQuery.of(context).size.width * 0.35),
              Text(englishname!,
                  style: textstyle.subtitle.copyWith(color: colors.background)),
            ],
          ),
        ],
      ),
    );
  }
}
