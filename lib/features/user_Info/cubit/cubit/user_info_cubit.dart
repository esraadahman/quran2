import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qurane2/features/user_Info/data/network_user.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());

  double age = 0.0;
  bool male = true;

  TextEditingController name = TextEditingController();

  bool code = false;
  Country? pagecountry;

  TextEditingController phone = TextEditingController();
  List cities = [];
  String selectedvalue = "";

  // get cities

  void getCities(String country) async {
    emit(GetcitiesLoading());
    try {
      cities = await UserNetwork.getcities(country);
      emit(GetcitiesLoaded());
    } catch (e) {
      emit(GetcitiesFailed());
    }
  }
  // add user data to firebase

  void sendUserData(String name, String country, String city,
      String phonenumber, String age, String gender) {
    if (name.isEmpty ||
        country.isEmpty ||
        city.isEmpty ||
        phonenumber.isEmpty ||
        age.isEmpty ||
        gender.isEmpty) {
      emit(SendUserDataFailed(failed: "Please fill all the fields"));
    } else {
      print("enter function cubit");
      emit(SendUserDataLoading());
      try {
        print("enter function cubit loading done");
        UserNetwork.sendUserData(
            name: name,
            city: city,
            country: country,
            phonenumber: phonenumber,
            age: age,
            gender: gender);
        print("enter function cubit loaded done");
        emit(SendUserDataLoaded());
      } catch (e) {
        emit(SendUserDataFailed(failed: e.toString()));
      }
    }
  }
}
