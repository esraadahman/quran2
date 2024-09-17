part of 'videocall_cubit.dart';

@immutable
sealed class VideocallState {}

final class VideocallInitial extends VideocallState {}


final class Videocall_image_loadding extends VideocallState {}
final class Videocall_image_success extends VideocallState {}
final class Videocall_image_fail extends VideocallState {}


final class StreamCreateLoading extends VideocallState {}

final class StreamCreateLoaded extends VideocallState {}

final class StreamCreateFailed extends VideocallState {}
