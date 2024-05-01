part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? currentPosition;
  final List<LatLng> allLocations;
  final List<LatLng> myLocationHistory;

  const LocationState({
    this.followingUser = false,
    this.currentPosition,
    allLocations,
    myLocationHistory
  }) 
    : allLocations = allLocations ?? const [],
      myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? currentPosition,
    List<LatLng>? allLocations,
    List<LatLng>? myLocationHistory
  }) => LocationState(
    followingUser: followingUser ?? this.followingUser,
    currentPosition: currentPosition ?? this.currentPosition,
    allLocations: allLocations ?? this.allLocations,
    myLocationHistory: myLocationHistory ?? this.myLocationHistory
  );
  
  @override
  List<Object?> get props => [ followingUser, currentPosition, allLocations, myLocationHistory ];
}
