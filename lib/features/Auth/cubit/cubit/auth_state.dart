part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//* sign up **************************/
final class SignUpLoading extends AuthState {}

final class SignUpLoaded extends AuthState {
  final String response;
  SignUpLoaded(this.response);
}

final class SignUpFailed extends AuthState {}

//* sign in **************************/
final class SignInLoading extends AuthState {}

final class SignInLoaded extends AuthState {
  final String response;
  SignInLoaded(this.response);
}

final class SignInFailed extends AuthState {}

//* froget password **************************/
final class ForgetPasswordLoading extends AuthState {}

final class ForgetPasswordLoaded extends AuthState {
  final String response;
  ForgetPasswordLoaded(this.response);
}

final class ForgetPasswordFailed extends AuthState {}
