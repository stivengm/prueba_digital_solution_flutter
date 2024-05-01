part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowUser;

  final List<Marker> markers;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowUser = false,
    List<Marker>? markers,
  }) 
  : markers = markers ?? const [];

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowUser,

    List<Marker>? markers
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowUser: isFollowUser ?? this.isFollowUser,
    markers: markers ?? this.markers,
  );
  
  @override
  List<Object> get props => [ isMapInitialized, isFollowUser, markers ];
}
