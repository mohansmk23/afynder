import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "http://dev.afynder.com/afynder/api/web/v1",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = new Dio(options);
