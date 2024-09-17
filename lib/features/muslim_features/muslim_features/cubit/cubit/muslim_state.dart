part of 'muslim_cubit.dart';

@immutable
sealed class MuslimState {}

final class MuslimInitial extends MuslimState {}

final class MusilmLoading extends MuslimState {}

final class MusilmFailed extends MuslimState {}

// quran list
final class QuranListLoading extends MuslimState {}

final class QuranListLoaded extends MuslimState {}

final class QuranListFailed extends MuslimState {}

// getsurah
final class SurahLoading extends MuslimState {}

final class SurahLoaded extends MuslimState {}

final class SurahFailed extends MuslimState {}

// play sourah

final class SurahAudioLoading extends MuslimState {}

final class SurahAudioLoaded extends MuslimState {}

final class SurahAudioFailed extends MuslimState {}







final class RecitersLoading extends MuslimState {}
final class RecitersLoaded extends MuslimState {}
final class RecitersFailed extends MuslimState {}