import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/blocs.dart';

final List<BlocProvider> providerBloc = [
  BlocProvider<GpsBloc>(create: (_) => GpsBloc()),
  BlocProvider<LocationBloc>(create: (_) => LocationBloc()),
];