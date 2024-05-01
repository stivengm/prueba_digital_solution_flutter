import 'package:dio/dio.dart';

class GetRouteInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiZ2FtZWdhbWVwbGF5MCIsImEiOiJja2M2YXpkM3UwcHY3MnlwMmVkajNwN2VvIn0.LdqYgbiObo0d138vXzrjGg';
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });


    super.onRequest(options, handler);
  }


}