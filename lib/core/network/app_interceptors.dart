import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors();
  static bool isInternet = true;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    isInternet = true;

    if (options.data is FormData) {
      options.contentType = null;
      options.headers.remove(Headers.contentTypeHeader);
      options.headers.remove('Content-Type');
      options.headers.remove('content-type');
    } else {
      options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    }

    final lang = HiveMethods.getLang();
    options.headers['lang'] = lang == 'en' ? 'en-GB' : lang;

    final token = HiveMethods.getToken();
    if (token != null && options.extra['skipAuth'] != true) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
