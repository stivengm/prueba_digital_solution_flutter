import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/location/location_bloc.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/map/map_bloc.dart';
import 'package:prueba_digitalsolution_flutter/core/models/clientes_models.dart';
import 'package:prueba_digitalsolution_flutter/core/themes/map.theme.dart';
import 'package:prueba_digitalsolution_flutter/ui/widgets/widgets.dart';

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

          final mapBloc = context.read<MapBloc>();
          List<Marker> markers = mapBloc.state.markers;

          final clearCliente = Cliente(
            id: 0,
            name: "",
            address: ""
          );
      
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                SizedBox(
                  width: media.width,
                  height: media.height,
                  child: Listener(
                    onPointerMove: (pointerMoveEvent) {
                      mapBloc.add( OnStopFollowingUserEvent() );
                      mapBloc.add( DisplayInformationCliente(clearCliente) );
                    },
                    onPointerHover: (event) {
                      mapBloc.add( DisplayInformationCliente(clearCliente) );
                    },
                    child: GoogleMap(
                      initialCameraPosition: initialCameraPosition,
                      compassEnabled: false,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      style: jsonEncode(mapStyleTheme),
                      polylines: mapBloc.state.polylines.values.toSet(),
                      markers: Set<Marker>.of(markers),
                      onMapCreated: ( controller ) => mapBloc.add( OnMapInitializedEvent(controller: controller) ),
                    ),
                  ),
                ),

                mapBloc.state.cliente?.name != '' && mapBloc.state.cliente?.name != null ? const InformationCliente() : const SizedBox(),

                Positioned(
                  bottom: 40,
                  left: (media.width - 0.7) / 6,
                  child: SizedBox(
                    width: media.width * 0.7,
                    child: PrimaryButton(text: 'Iniciar viaje', onPressed: () async {

                      final resp = await mapBloc.getCoorsStartToEnd();
                      mapBloc.drawRoutePolyline(resp);

                    })
                  )
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnFollowUser(),
          BtnAddMarker()
        ],
      )
    );
  }
}