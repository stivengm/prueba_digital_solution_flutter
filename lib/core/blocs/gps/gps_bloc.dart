import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(GpsInitial()) {
    on<GpsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
