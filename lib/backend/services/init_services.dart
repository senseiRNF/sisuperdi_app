import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class InitServices {
  Dio dio = Dio();

  Future<Dio> clientAdapter() async {
    dio.options = BaseOptions(
      baseUrl: 'http://10.0.2.2:80/sisuperdi/',
      headers: {
        'Accept': 'application/json',
      },
    );

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      return client;
    };

    return dio;
  }
}