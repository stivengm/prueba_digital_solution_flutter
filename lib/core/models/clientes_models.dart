import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_digitalsolution_flutter/core/models/products_model.dart';

class Cliente {

  final int id;
  final String name;
  final String address;
  final List<Product>? products;
  final Marker? marker;

  Cliente({
    required this.id,
    required this.name,
    required this.address,
    this.products,
    this.marker
  });

}

List<Cliente> clientes = [

  Cliente(
    id: 1, 
    name: "Stiven Gomez", 
    address: "Calle 138C sur # 14k - 26",
    products: [
      Product(
        id: 1, 
        name: "Coca cola Litro"
      ),
      Product(
        id: 4,
        name: "Seven Up"
      ),
    ], 
    marker: const Marker(
      markerId: MarkerId("marker-client-01"),
      position: LatLng(4.4731111, -74.1297824),
      infoWindow: InfoWindow(
        title: 'Stiven Gómez',
        snippet: 'Calle 138C sur # 14k - 26'
      ),
    ),
  ),
  Cliente(
    id: 2, 
    name: "Cristian Novoa", 
    address: "Calle 137 sur # 14b - 44",
    products: [
      Product(
        id: 1, 
        name: "Coca cola Litro"
      ),
      Product(
        id: 2,
        name: "Agua Pura Botella"
      ),
    ], 
    marker: const Marker(
      markerId: MarkerId("marker-client-02"),
      position: LatLng(4.4744255, -74.1258423),
      infoWindow: InfoWindow(
        title: 'Cristian Novoa',
        snippet: 'Calle 137 sur # 14b - 44'
      )
    ),
  ),
  Cliente(
    id: 3, 
    name: "Hugo Pérez", 
    address: "Calle 138C sur # 14k - 26",
    products: [
      Product(
        id: 1, 
        name: "Coca cola Litro"
      ),
      Product(
        id: 2,
        name: "Agua Pura Botella"
      ),
    ], 
    marker: const Marker(
      markerId: MarkerId("marker-client-03"),
      position: LatLng(4.532062, -74.118906),
      infoWindow: InfoWindow(
        title: 'Hugo Pérez',
        snippet: 'Calle 138C sur # 14k - 26'
      )
    ),
  ),
  Cliente(
    id: 4, 
    name: "Johan López", 
    address: "Calle 138C sur # 14k - 26",
    products: [
      Product(
        id: 1, 
        name: "Coca cola Litro"
      ),
      Product(
        id: 2,
        name: "Agua Pura Botella"
      ),
      Product(
        id: 3,
        name: "Agua Pura litiro"
      ),
    ], 
    marker: const Marker(
      markerId: MarkerId("marker-client-04"),
      position: LatLng(4.617217, -74.071626),
      infoWindow: InfoWindow(
        title: 'Johan López',
        snippet: 'Calle 138C sur # 14k - 26'
      )
    )
  )

];
