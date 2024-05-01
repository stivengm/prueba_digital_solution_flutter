import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_digitalsolution_flutter/core/blocs/map/map_bloc.dart';
import 'package:prueba_digitalsolution_flutter/ui/widgets/rich_text_widget.dart';

class InformationCliente extends StatelessWidget {
  const InformationCliente({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            width: media.width,
            height: media.height * .3,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HeaderInformationCliente(text: "Información del cliente"),
                const SizedBox(height: 5.0),
                RichTextWidget(title: "Nombre: ", subtitle: "${state.cliente?.name}",),
                RichTextWidget(title: "Dirección: ", subtitle: "${state.cliente?.address}",),
                const _HeaderInformationCliente(text: "Productos a entregar"),
                state.isShowInfoMarker ?
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: state.cliente?.products!.length,
                    itemBuilder: ( context, index) {
                      return Text(" - ${state.cliente!.products![index].name}");
                    }
                  ),
                ) : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderInformationCliente extends StatelessWidget {
  final String text;
  const _HeaderInformationCliente({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: 20.0 ),);
  }
}
