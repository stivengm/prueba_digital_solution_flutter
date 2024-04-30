import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/location/location_bloc.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
    super.initState();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
      
          if ( state.currentPosition == null ) return const Center( child: Text('Espere por favor...'));
      
          final CameraPosition initialCameraPosition = CameraPosition(
            target: state.currentPosition!,
            zoom: 15
          );

          Size media = MediaQuery.of(context).size;

      
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                SizedBox(
                  width: media.width,
                  height: media.height,
                  child: GoogleMap(
                    initialCameraPosition: initialCameraPosition,
                    compassEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    // markers: ,
                  ),
                ),
      
                // TODO: Los botones.
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // BtnCurrentLocation()
        ],
      ),
    );
  }
}