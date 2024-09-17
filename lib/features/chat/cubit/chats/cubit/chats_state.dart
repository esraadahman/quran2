part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}



final class getusersloading extends ChatsState {}

final class getusersloaded extends ChatsState {}

final class getusersfailed extends ChatsState {}



final class getchatsloading extends ChatsState {}

final class getchatsloaded extends ChatsState {}

final class getchatsfailed extends ChatsState {}



final class Searchloading extends ChatsState {}

final class Searchloaded extends ChatsState {}

final class Searchfailed extends ChatsState {}
