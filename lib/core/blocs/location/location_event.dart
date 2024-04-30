part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnNewLocationEvent extends LocationEvent {
  final LatLng currentPosition;
  const OnNewLocationEvent(this.currentPosition);
}
