import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/blocs.dart';
import 'package:prueba_digitalsolution_flutter/ui/delegates/search_marker_delegate.dart';

class BtnAddMarker extends StatelessWidget {
  const BtnAddMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon( 
                Icons.add, 
                color: Colors.black
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchMarkerDelegate());
              }
            );
          },
        ),
      ),
    );
  }
}