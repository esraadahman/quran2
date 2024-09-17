import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qurane2/features/chat/data/network/profilenetwork.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Map<String, dynamic> userinfo = {};
  void getuserinfo(String userid) async {
    Map<String, dynamic> basemap = {};
    try {
      emit(Profileloading());
      basemap = await Profilenetwork.getUserinfoById(userid);
      userinfo = basemap;
      emit(Profilesuccess());
    } catch (e) {
      emit(Profilefail());
    }
  }




  Future<void> deletechat(String chatid) async {
    await  Profilenetwork.deletechat(chatid);

  }
}
