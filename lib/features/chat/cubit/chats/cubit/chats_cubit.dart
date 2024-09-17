import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:qurane2/features/chat/data/network/chatsNetwork.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  Stream<QuerySnapshot> getallusers() {
    emit(getusersloading());
    emit(getusersloaded());
    return ChatsNetwork.getallusers();
  }

  Stream<QuerySnapshot> getchats() {
    // emit(getchatsloading());
    // emit(getchatsloaded());
    return  ChatsNetwork.getuserchats();
  }

  static String getcurrentuserid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Map<String, String> setinfo_to_get_chat(String id) {
    String name;
    String image;
    String userid;

    if (id == getcurrentuserid()) {
      name = 'otherusername';
      image = 'otheruserimage';
      userid = 'otheruserid';
    } else {
      name = 'username';
      image = 'userimage';
      userid = 'userid';
    }

    return {'name': name, 'image': image , 'userid': userid};
  }

  Future<bool> check_chat(String other_id) {
    return ChatsNetwork.checkchat(other_id);
  }

  String chatid = '';
  String searching = "";
   Future<void> searchbyname(String name) async {
    emit(getusersloading());
    chatid = await ChatsNetwork.searchbyname(name);
    searching = name;
    emit(getusersloaded());
  }
}
