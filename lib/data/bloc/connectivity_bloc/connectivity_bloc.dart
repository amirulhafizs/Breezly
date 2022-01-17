import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivity>(_onCheckConnectivity);
  }

  void _onCheckConnectivity(event, emit) async {
    late ConnectivityResult connectionResult;

    try {
      connectionResult = await Connectivity().checkConnectivity();
      if (connectionResult == ConnectivityResult.none) {
        emit(Disconnected());
      } else {
        emit(Connected());
      }
    } catch (e) {
      developer.log('Failed to check connectivity status', error: e);
      emit(Disconnected());
    }
  }
}
