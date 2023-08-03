
import 'package:dio/dio.dart';

import '../../shared/constants.dart';
import '../local/cache_helper.dart';


class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
       baseUrl: baseUrl,
      headers:{
        "Accept" :"application/json",
        "lang" : lang,
        "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",

      },
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, Map<String, dynamic>? header}) {
    return dio!.get(
      url,
      options: Options(headers: header),
      queryParameters: query ,
    );
  }

  static Future<Response> postData(
      {required String url, FormData? data, Map<String, dynamic>? header}) async {
    return await dio!.post(
      url,
      options: Options(headers: header ),
      data: data ,
    );
  }
}
