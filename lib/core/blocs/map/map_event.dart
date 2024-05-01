part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  final List<Marker>? markers; 
  const OnMapInitializedEvent({
    required this.controller, 
    this.markers
  });
}

class OnStartFollowingUserEvent extends MapEvent {}
class OnStopFollowingUserEvent extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocation;
  const UpdateUserPolylineEvent(this.userLocation);
}

class DisplayMarkersEvent extends MapEvent {
  final Map<String, Marker> markers;
  const DisplayMarkersEvent(this.markers);
}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  const DisplayPolylinesEvent(this.polylines);
}

class DisplayInformationCliente extends MapEvent {
  final Cliente? cliente;
  const DisplayInformationCliente(this.cliente);
}