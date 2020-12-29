import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

//String url = "https://afynder.com/api/web/v1/"; //live
String url = "http://dev.afynder.com/afynder/api/web/v1/"; //dev

BaseOptions options = new BaseOptions(
    baseUrl: url,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    headers: {"Connection": "Keep-Alive"});
Dio dio = new Dio(options);
