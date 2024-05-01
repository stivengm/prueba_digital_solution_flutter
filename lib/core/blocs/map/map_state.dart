part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowUser;
  final bool isShowInfoMarker;

  final Map<String, Polyline> polylines;
  final List<Marker> markers;
  final Cliente? cliente;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowUser = false,
    this.isShowInfoMarker = false,
    Map<String, Polyline>? polylines,
    List<Marker>? markers,
    this.cliente
  }) 
  : polylines = polylines ?? const {},
    markers = markers ?? const [];

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowUser,
    bool? isShowInfoMarker,

    Map<String, Polyline>? polylines,
    List<Marker>? markers,
    Cliente? cliente
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowUser: isFollowUser ?? this.isFollowUser,
    isShowInfoMarker: isShowInfoMarker ?? this.isShowInfoMarker,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
    cliente: cliente ?? this.cliente
  );
  
  @override
  List<Object?> get props => [ isMapInitialized, isFollowUser, isShowInfoMarker, polylines, markers, cliente ];
}
