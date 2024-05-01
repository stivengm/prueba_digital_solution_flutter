import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/blocs.dart';
import 'package:prueba_digitalsolution_flutter/core/models/clientes_models.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  LocationBloc locationBloc;
  GoogleMapController? _mapController;
  StreamSubscription<LocationState>? _locationStateSubscription;

  MapBloc({
    required this.locationBloc
  }) : super(const MapState()) {

    on<OnMapInitializedEvent>( _onInitMap );
    on<OnStartFollowingUserEvent>( _onStartFollowingUser );
    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith( isFollowUser: false) ));
    on<UpdateUserPolylineEvent>( _onPolylineHistory );

    _locationStateSubscription = locationBloc.stream.listen(( locationState ) {
      if ( locationState.currentPosition != null) {
        add( UpdateUserPolylineEvent( locationState.myLocationHistory ) );
      }
      if ( !state.isFollowUser ) return;
      if ( locationState.currentPosition == null ) return;
      moveCamera( locationState.currentPosition );
    });

  }

  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit ) {
    _mapController = event.controller;

    emit( state.copyWith( isMapInitialized: true, markers: clientes ) );
  }

  void _onPolylineHistory( UpdateUserPolylineEvent event, Emitter<MapState> emit ) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.blue.withOpacity(.5),
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocation
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['myRoute'] = myRoute;
    
    emit( state.copyWith( polylines: currentPolylines ));
  }

  void moveCamera( newLocation ) {
    final cameraUpdate = CameraUpdate.newLatLng( newLocation );
    _mapController?.animateCamera( cameraUpdate );
  }

  void _onStartFollowingUser(OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit( state.copyWith( isFollowUser: true ) );
    if( locationBloc.state.currentPosition == null ) return;
    moveCamera(locationBloc.state.currentPosition!);
  }

  @override
  Future<void> close() {
    _locationStateSubscription?.cancel();
    return super.close();
  }

}
