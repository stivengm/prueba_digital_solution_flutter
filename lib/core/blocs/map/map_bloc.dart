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

  MapBloc({
    required this.locationBloc
  }) : super(const MapState()) {

    on<OnMapInitializedEvent>( _onInitMap );
    on<OnStartFollowingUserEvent>( _onStartFollowingUser );
    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith( isFollowUser: false) ));

    locationBloc.stream.listen(( locationState ) {
      if ( !state.isFollowUser ) return;
      if ( locationState.currentPosition == null ) return;
      moveCamera( locationState.currentPosition );
    });

  }

  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit ) {
    _mapController = event.controller;

    emit( state.copyWith( isMapInitialized: true, markers: clientes ) );
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

}
