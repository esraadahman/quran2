part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class AdanLoaded extends HomeState {}

final class AdanLoading extends HomeState {}
