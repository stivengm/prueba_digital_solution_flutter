import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/blocs.dart';
import 'package:prueba_digitalsolution_flutter/core/models/clientes_models.dart';
import 'package:prueba_digitalsolution_flutter/core/models/route_destination.dart';
import 'package:prueba_digitalsolution_flutter/core/services/get_route_service.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  LocationBloc locationBloc;
  GetRouteService getRouteService;
  GoogleMapController? _mapController;
  StreamSubscription<LocationState>? _locationStateSubscription;

  MapBloc({
    required this.locationBloc,
    required this.getRouteService
  }) : super(const MapState()) {

    on<OnMapInitializedEvent>( _onInitMap );
    on<OnStartFollowingUserEvent>( _onStartFollowingUser );
    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith( isFollowUser: false) ));
    on<UpdateUserPolylineEvent>( _onPolylineHistory );
    on<DisplayPolylinesEvent>((event, emit) => emit( state.copyWith( polylines: event.polylines) ));

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

  void drawRoutePolyline( RouteDestination destination ) async {

    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.blue,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['route'] = myRoute;

    add( DisplayPolylinesEvent( currentPolylines ) );

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

  Future<RouteDestination> getCoorsStartToEnd() async {

    final List<LatLng> markers = [];

    for (var i = 0; i < state.markers.length; i++) {
      markers.add( state.markers[i].position );
    }

    final resp = await getRouteService.getCoorsStartToEnd(markers);

    final geometry = resp.routes[0].geometry;
    final distance = resp.routes[0].distance;
    final duration = resp.routes[0].duration;

    final points = decodePolyline(geometry, accuracyExponent: 6);
    final latLngList = points.map(( coor ) => LatLng(coor[0].toDouble(), coor[1].toDouble())).toList();


    return RouteDestination(
      points: latLngList, 
      duration: duration, 
      distance: distance
    );

  }

  @override
  Future<void> close() {
    _locationStateSubscription?.cancel();
    return super.close();
  }

}
