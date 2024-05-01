import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:prueba_digitalsolution_flutter/core/models/data_response_route.dart';
import 'package:prueba_digitalsolution_flutter/core/services/get_route_interceptor.dart';

class GetRouteService {

  final Dio _dio;


  final String _baseUrl = "https://api.mapbox.com/directions/v5/mapbox/driving/";

  GetRouteService()
    : _dio = Dio()..interceptors.add( GetRouteInterceptor() );

  Future<DataResponseRoute> getCoorsStartToEnd( List<LatLng> coors ) async {

    var markers = "";
    for (var i = 0; i < coors.length; i++) {
      if (i != 0 && i != coors.length -1) {
        markers += "${coors[i].longitude},${coors[i].latitude};";
      }
    }

    var coorsString = '${coors.first.longitude},${coors.first.latitude};$markers${coors.last.longitude},${coors.last.latitude}';
    final url = '$_baseUrl$coorsString';
    final response = await _dio.get(url);
    final data = DataResponseRoute.fromMap(response.data);

    return data;
  }



}