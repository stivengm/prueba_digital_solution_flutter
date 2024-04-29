import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/blocs.dart';

class GPSAccessView extends StatelessWidget {
  const GPSAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            print(state);
            return !state.isGpsEnabled
            ? const _GpsEnable()
            : const _AccessButton();
          },
        ),
        // child: _GpsEnable(),
        // child: _AccessButton(),
      ),
    );
  }
}

class _GpsEnable extends StatelessWidget {
  const _GpsEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Habilite el GPS",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Es necesario el acceso a la localización GPS",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        MaterialButton(child: const Text("Solicitar acceso"), onPressed: () {})
      ],
    );
  }
}
