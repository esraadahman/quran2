part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}


final class Profileloading extends ProfileState {}

final class Profilesuccess extends ProfileState {}
final class Profilefail extends ProfileState {}
