import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gerenciar_financas_app/data/exceptions/api_exception.dart';
import 'package:gerenciar_financas_app/data/exceptions/request_canceled_exception.dart';
import 'package:gerenciar_financas_app/data/exceptions/server_access_exception.dart';
import 'package:gerenciar_financas_app/data/exceptions/server_timeout_exception.dart';
import 'package:gerenciar_financas_app/data/utils/public_dio.dart';

class HttpHelper {
  static Future<Map<String, dynamic>> invoke(
    dynamic url,
    RequestType type, {
    Map<String, String> headers,
    dynamic data,
  }) async {
    try {
      BaseOptions opts = BaseOptions(headers: headers);
      Dio dio = PublicDio(opts);

      Response response;

      print('${dio.options.baseUrl}$url');
      print(jsonEncode(data));

      switch (type) {
        case RequestType.get:
          response = await dio.get(url);
          break;
        case RequestType.post:
          response = await dio.post(url, data: jsonEncode(data));
          break;
        case RequestType.put:
          response = await dio.put(url, data: jsonEncode(data));
          break;
        case RequestType.delete:
          response = await dio.delete(url);
          break;
      }

      return response.data;
    } on DioError catch (error) {
      switch (error.type) {
        case DioErrorType.RESPONSE:
          throw APIException(
            error.response.statusCode,
            error.response.statusMessage,
            error.message,
          );
        case DioErrorType.CONNECT_TIMEOUT:
          throw ServerAccessException(error.message);
        case DioErrorType.RECEIVE_TIMEOUT:
          throw ServerTimeoutException(error.message);
        case DioErrorType.CANCEL:
          throw RequestCanceledException(error.message);
        default:
          throw error?.error ?? error;
      }
    } catch (error) {
      rethrow;
    }
  }
}

enum RequestType { get, post, put, delete }
