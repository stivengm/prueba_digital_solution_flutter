import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GpsAndPermissionEvent>((event, emit) {
      emit(
        state.copyWith( 
          isGpsEnabled: event.isGpsEnabled, 
          isGpsPermissionGranted: state.isGpsPermissionGranted 
        )
      );
    });
  }
}
