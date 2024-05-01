import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> clientes = const [
  Marker(
    markerId: MarkerId("marker-client-01"),
    position: LatLng(4.4731111, -74.1297824),
    infoWindow: InfoWindow(
      title: 'Stiven Gómez',
      snippet: 'Calle 138C sur # 14k - 26'
    ),
  ),
  Marker(
    markerId: MarkerId("marker-client-02"),
    position: LatLng(4.4744255, -74.1258423),
    infoWindow: InfoWindow(
      title: 'Cristian Novoa',
      snippet: 'Calle 137 sur # 14b - 44'
    )
  ),
  Marker(
    markerId: MarkerId("marker-client-03"),
    position: LatLng(4.532062, -74.118906),
    infoWindow: InfoWindow(
      title: 'Hugo Pérez',
      snippet: 'Calle 138C sur # 14k - 26'
    )
  ),
  Marker(
    markerId: MarkerId("marker-client-04"),
    position: LatLng(4.617217, -74.071626),
    infoWindow: InfoWindow(
      title: 'Johan López',
      snippet: 'Calle 138C sur # 14k - 26'
    )
  )
];
