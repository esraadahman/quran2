import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qurane2/features/Auth/data/network.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  TextEditingController email_up = TextEditingController();
  TextEditingController pass_up = TextEditingController();

  void signUp(String email, String password) async {
    print("enter function cubit");

    if (email.isEmpty || password.isEmpty) {
      emit(SignUpLoaded('Please fill all fields'));
    }
    emit(SignUpLoading());
    try {
      String response = await networkAuth().signUp(email, password);
      emit(SignUpLoaded(response));
    } catch (e) {
      emit(SignUpFailed());
    }
  }

  /* sign in  */

  TextEditingController email_in = TextEditingController();
  TextEditingController forgetemail = TextEditingController();
  TextEditingController pass_in = TextEditingController();

  void signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(SignInLoaded('Please fill all fields'));
    }
    emit(SignInLoading());
    try {
      String response = await networkAuth().signIn(email, password);
      emit(SignInLoaded(response));
    } catch (e) {
      emit(SignInFailed());
    }
  }

  void forgetPassword(String email) async {
    if (email.isEmpty) {
      emit(ForgetPasswordLoaded('Please write your email'));
    }
    emit(ForgetPasswordLoading());
    try {
      String response = await networkAuth().forgetPassword(email);
      emit(ForgetPasswordLoaded(response));
    } catch (e) {
      emit(ForgetPasswordFailed());
    }
  }

  void signInWithGoogle() async {
    emit(SignInLoading());
    try {
      await networkAuth().signInWithGoogle();
      emit(SignInLoaded('SignIn success'));
    } catch (e) {
      emit(SignInFailed());
    }
  }
}
