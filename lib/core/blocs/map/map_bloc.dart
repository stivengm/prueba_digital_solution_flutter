import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_digitalsolution_flutter/core/themes/map.theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  GoogleMapController? _mapController;

  MapBloc() : super(const MapState()) {

    on<OnMapInitializedEvent>( _onInitMap );

  }

  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit ) {
    _mapController = event.controller;

    _mapController?.setMapStyle( jsonEncode(mapStyleTheme));

    emit( state.copyWith( isMapInitialized: true ) );
  }
}
