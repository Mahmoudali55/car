import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors();
  static bool isInternet = true;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    isInternet = true;

    options.headers['Content-Type'] = 'application/x-www-form-urlencoded';

    final lang = HiveMethods.getLang();
    options.headers['lang'] = lang == 'en' ? 'en-GB' : lang;

    final token = HiveMethods.getToken();
    if (token != null && options.extra['skipAuth'] != true) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
