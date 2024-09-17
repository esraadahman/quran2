import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:qurane2/features/videoCall/data/streamnetwork.dart';

part 'videocall_state.dart';

class VideocallCubit extends Cubit<VideocallState> {
  VideocallCubit() : super(VideocallInitial());

  XFile? profilePic;
  String image_url = "";

  TextEditingController streamname = TextEditingController();
  TextEditingController streamid = TextEditingController();

  var username;
  sendimage({required XFile image}) async {
    try {
      emit(Videocall_image_loadding());
      image_url = await Streamnetwork.takeAndUploadImage(image);
      emit(Videocall_image_success());
    } catch (e) {
      emit(Videocall_image_fail());
    }
  }

  Future<void> createStream(String streamname, String streamid) async {
    emit(StreamCreateLoading());
    try {
      await Streamnetwork.createstream(streamname, image_url, streamid);
      emit(StreamCreateLoaded());
    } catch (e) {
      emit(StreamCreateFailed());
    }
  }


   String username = "";
    Future<void> getusername() async {
    emit(StreamCreateLoading());
    try {
      username = await Streamnetwork.getusername();
      emit(StreamCreateLoaded());
    } catch (e) {
      emit(StreamCreateFailed());
    }
  }
}
