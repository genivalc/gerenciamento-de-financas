import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import 'constants.dart';

class PublicDio extends DioForNative {
  PublicDio([BaseOptions options]) : super(options) {
    options.baseUrl = DioConfig.baseUrl;
    options.connectTimeout = DioConfig.connectTimeOut;
    options.receiveTimeout = DioConfig.receiveTimeOut;
    options.contentType = 'application/json';
  }
}