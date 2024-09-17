import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/duaa_model.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/network/quran_network.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/zeker_model.dart';
import 'package:qurane2/features/muslim_features/muslim_features/ui/screens/duaa.dart';

part 'muslim_state.dart';

class MuslimCubit extends Cubit<MuslimState> {
  MuslimCubit() : super(MuslimInitial());

  List<AzkerModel> test = azkarElsabah;
  int cateindex = 0;

  changecategory(int index) {
    cateindex = index;

    if (index == 0) {
      test = azkarElsabah;
    } else if (index == 1) {
      test = azkarELmasa2;
    } else if (index == 2) {
      test = azkarba3delsalah;
    } else if (index == 3) {
      test = azkarSleepList;
    } else if (index == 4) {
      test = azkarWakeupList;
    } else {
      test = azkarElsabah;
    }
    emit(MuslimInitial());
  }

  //tasbih ************************
  int tasbehcount = 0;

  incresetasbeh() {
    tasbehcount++;
    emit(MuslimInitial());
  }

  resettasbeh() {
    tasbehcount = 0;
    emit(MuslimInitial());
  }

  /* duaa ****************************************/
  List<DuaaModel> duaatest = duaafromQuranList;
  int cateindexforduaa = 0;

  changecategoryduaa(int index) {
    cateindexforduaa = index;

    if (index == 0) {
      duaatest = duaafromQuranList;
    } else if (index == 1) {
      duaatest = duaafromanbya2List;
    } else {
      duaatest = duaafromQuranList;
    }
    emit(MuslimInitial());
  }

  /* quran list */

  String convertNumberToArabic(String englishNumber) {
    if (englishNumber == null || englishNumber.isEmpty) {
      return '';
    }

    Map<String, String> numberMap = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    String arabicNumber = '';
    for (int i = 0; i < englishNumber.length; i++) {
      arabicNumber += numberMap[englishNumber[i]] ?? englishNumber[i];
    }

    return arabicNumber;
  }

  List<dynamic> quranlist = [];

  getQuranList() async {
    emit(QuranListLoading());
    try {
      quranlist = await quran_network.getQuranList();
      emit(QuranListLoaded());
    } catch (e) {
      emit(QuranListFailed());
    }
  }

  /*  sourah */

  String readingmood = "arabic";
  int sizefont = 18;
  Color color1 = colors.text;

  List<dynamic> surah_ar = [];

  List<dynamic> surah_en = [];

  bool showsettings = false;

  getSurah(int id, String langage) async {
    emit(SurahLoading());
    try {
      surah_ar = await quran_network.getSurah(id, langage);
      emit(SurahLoaded());
    } catch (e) {
      emit(SurahFailed());
    }
  }

  setfontsize(int size) {
    emit(MusilmLoading());
    try {
      sizefont = size;
      emit(MuslimInitial());
    } catch (e) {
      emit(MusilmFailed());
    }
  }

  setReadingMood(String mood, int id) {
    emit(MusilmLoading());
    try {
      readingmood = mood;
      if (readingmood == 'arabic') {
        getSurah(id, 'ar');
      } else if (readingmood == 'english') {
        getSurah(id, 'en');
      } else {
        getSurahBoth(id);
      }
      emit(MuslimInitial());
    } catch (e) {
      emit(MusilmFailed());
    }
  }

  getSurahBoth(int id) async {
    emit(SurahLoading());
    try {
      surah_ar = await quran_network.getSurah(id, 'ar');
      surah_en = await quran_network.getSurah(id, 'en');

      emit(SurahLoaded());
    } catch (e) {
      emit(SurahFailed());
    }
  }

  setcolor(Color color) {
    emit(MusilmLoading());
    try {
      this.color1 = color;
      emit(MuslimInitial());
    } catch (e) {
      emit(MusilmFailed());
    }
  }

/*  surah audio*/

  String surahUrl = "";
  final player = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;


  getSurahAudio(int id, int chapter_number) async {
    emit(SurahAudioLoading());
    try {
      surahUrl = await quran_network.getSurahAudio(id, chapter_number);
      duration = await player.setUrl(
        surahUrl,
      ) as Duration;

      player.durationStream.listen((duration0) {
        duration = duration0 as Duration;
      });

      player.positionStream.listen((position0) {
        position = position0 as Duration;
      });

      Timer.periodic(Duration(seconds: 1), (timer) {
        initial();
      });
      

      emit(SurahAudioLoaded());
    } catch (e) {
      emit(SurahAudioFailed());
    }
  }


    String timeFormat(Duration duration) {
    return "${duration.inHours.remainder(60).toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }


  bool isPlaying = false;
    bool bottomsheet = false;
  bool speedlist = false;
  int volume = 50;
   

    initial() {
    player.durationStream.listen((duration0) {
      duration = duration0 as Duration;
    });

    player.positionStream.listen((position0) {
      position = position0 as Duration;
    });
    emit(SurahLoaded());
  }


  List<dynamic> recitersarabic = [];
  getReciters() async {
    emit(RecitersLoading());
    try {
      recitersarabic = await quran_network.getReciters('ar');
      emit(RecitersLoaded());
    } catch (e) {
      emit(RecitersFailed());
    }
  }
}
