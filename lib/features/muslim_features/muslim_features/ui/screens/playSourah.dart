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
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/playSorah/AudioControls.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/playSorah/AudioSlider.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/playSorah/SurahInfo.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/widgets/playSorah/button_play.dart';

class PlaySourah extends StatefulWidget {
  final int? id;
  final String? name;
  final String? englishname;

  PlaySourah(
      {super.key,
      required this.id,
      required this.name,
      required this.englishname});

  @override
  State<PlaySourah> createState() => _PlaySourahState();
}

class _PlaySourahState extends State<PlaySourah> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MuslimCubit()..getReciters()
        ..getSurahAudio(2, widget.id!)
        ..initial(),
      child: BlocConsumer<MuslimCubit, MuslimState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<MuslimCubit>(context);
          if (state is SurahAudioLoading) {
            return Center(
              child: CircularProgressIndicator(color: colors.primary),
            );
          } else {
            return SafeArea(
              child: Scaffold(
                bottomSheet: cubit.bottomsheet == false
                    ? null
                    : BottomSheetWidget(cubit: cubit, id: widget.id!),
                backgroundColor: colors.background,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      size.height(2),
                      SurahInfo(
                          name: widget.name, englishname: widget.englishname),
                      size.height(10),
                      AudioSlider(cubit: cubit),
                      size.height(15),
                      AudioControls(cubit: cubit),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
