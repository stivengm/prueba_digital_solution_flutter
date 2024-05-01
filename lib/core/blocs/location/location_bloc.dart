import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription<Position>? locationStreamSubscription;

  LocationBloc() : super(const LocationState()) {

    on<OnNewLocationEvent>((event, emit) {
      emit( state.copyWith( 
        currentPosition: event.currentPosition,
        myLocationHistory: [ ...state.myLocationHistory, event.currentPosition ]
      ));
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add( OnNewLocationEvent( LatLng( position.latitude, position.longitude ) ) );
  }

  void startFollowingUser() {
    locationStreamSubscription = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add( OnNewLocationEvent( LatLng( position.latitude, position.longitude ) ) );
    });
  }

  void stopFollowingUser() {
    locationStreamSubscription?.cancel();
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
