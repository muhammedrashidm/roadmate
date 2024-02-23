
import 'package:dio/dio.dart';

const APPLICATION_JSON = 'application/json';
const CONTENT_TYPE = 'content-type';
const ACCEPT = 'accept';
const AUTHORIZATION = 'Authorization';
const DEFAULT_LANGUAGE = 'language';

const _BASE_URL =
    "https://roadmate.in/admin/public/api";
// "";
final Map<String, String> mainheaders = {
  CONTENT_TYPE: APPLICATION_JSON,
  ACCEPT: '*/*',
  DEFAULT_LANGUAGE: 'en',
};
class Api  {


  Dio dio = Dio(BaseOptions(
    baseUrl: _BASE_URL,
    sendTimeout: Duration(seconds: 30),
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  ));

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(url,
        queryParameters: {...?queryParameters},
        options: Options(
          headers: mainheaders,
        ));
  }

  Future<Response> post(
      String url, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParams,
      }) async {
    return await dio.post(url,
        data: data,
        queryParameters: queryParams,
        options: Options(
          headers: mainheaders,
        ));
  }

}