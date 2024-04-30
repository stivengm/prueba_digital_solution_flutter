part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? currentPosition;
  final List<LatLng> allLocations;

  const LocationState({
    this.followingUser = false,
    this.currentPosition,
    allLocations
  }) : allLocations = allLocations ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? currentPosition,
    List<LatLng>? allLocations
  }) => LocationState(
    followingUser: followingUser ?? this.followingUser,
    currentPosition: currentPosition ?? this.currentPosition,
    allLocations: allLocations ?? this.allLocations
  );
  
  @override
  List<Object?> get props => [ followingUser, currentPosition, allLocations ];
}
