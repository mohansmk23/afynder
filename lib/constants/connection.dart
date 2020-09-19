import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
    baseUrl: "http://dev.afynder.com/afynder/api/web/v1",
    connectTimeout: 10000,
    receiveTimeout: 10000,
    headers: {"Connection": "Keep-Alive"});
Dio dio = new Dio(options);
