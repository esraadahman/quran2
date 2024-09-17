import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qurane2/features/chat/data/network/single_chatNetwork.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  TextEditingController message = TextEditingController();

  String chat_id = "";

  set_chatid(String id) {
    chat_id = id;
  }

  sendMessage(String chatid, String massage, String type) {
    SingleChatNetwork.sendmassage(chatid, massage, type);
  }

  XFile? profilePic;
  XFile? video;

  sendimage(String chatid, XFile image) {
    SingleChatNetwork.takeAndUploadImage(chatid, image);
  }

  sendvideo(String chatid, XFile video) {
    SingleChatNetwork.uploadVideo(chatid, video);
  }

  getallmessages(String chatid) {
    try {
      emit(GetallMessagesLoading());
      SingleChatNetwork.getmassages(chatid);
      emit(GetallMessagesSuccess());
    } catch (e) {
      emit(GetallMessagesFailer());
    }
  }

  getcurrentUserId() {
    SingleChatNetwork.getcurrentuserid();
  }

  final record = AudioRecorder();

  bool isRecording = false;
  String path = "";

  start_record() async {
    final location = await getApplicationDocumentsDirectory();
    if (await record.hasPermission()) {
      // Start recording to file
      await record.start(const RecordConfig(),
          path: location.path + Uuid().v4() + 'm4a');

      isRecording = true;
    }
  }

  stop_record(String chatid) async {
    String? basepath = await record.stop();

    path = basepath!;
    isRecording = false;
    SingleChatNetwork.uploadAudio(chatid, path, "voice record");
    //  firebase_chats.uploadAudio(widget.chatid!, path!, "voice record");
  }

  String timeFormat(Duration duration) {
    return "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  final player = AudioPlayer();
  bool isPlaying = false;
  bool bottomsheet = false;
  bool speedlist = false;
  int volume = 50;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  getAudio(String voiceUrl) async {
    emit(GetVoiceLoading());
    try {
      duration = await player.setUrl(
        voiceUrl,
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

      emit(GetVoiceSuccess());
    } catch (e) {
      emit(GetVoiceFailer());
    }
  }

  // initial
  initial() {
    player.durationStream.listen((duration0) {
      duration = duration0 as Duration;
    });

    player.positionStream.listen((position0) {
      position = position0 as Duration;
    });
    emit(GetVoiceSuccess());
  }

  String lastseen = "";
getLastseen(String userid) async{
    String base = await SingleChatNetwork.getLastseen(userid) ;
    lastseen = base;
  }

  sennmark(String chatid, String senderid) {
    SingleChatNetwork.markSeen(chatid, senderid);
  }


  Future<void> deletemessage(String chatid, String messageid) async {
    await SingleChatNetwork.deletemassage(chatid, messageid);

  }
}
