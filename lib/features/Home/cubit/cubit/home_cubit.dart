import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qurane2/features/Home/data/network/network.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  Map<String, String> Adan = {};

  void getAdan(String city, String country) async {
    emit(AdanLoading());
    Adan = await getAdan1(city, country);
    emit(AdanLoaded());
  }






}
