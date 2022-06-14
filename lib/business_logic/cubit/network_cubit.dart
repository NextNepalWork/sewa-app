import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<bool> {
  ConnectivityCubit(bool isOnline) : super(isOnline) {
    Connectivity _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        isOnline = false;
        emit(isOnline);
      } else {
        isOnline = true;
        emit(isOnline);
      }
    });
  }
}
