import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(NetworkState.initial()){
    connectionCheck();
  }

  void connectionCheck(){
    Connectivity().onConnectivityChanged.listen((event) {
      emit(state.copyWith(status: event.name));
    });
  }

}


