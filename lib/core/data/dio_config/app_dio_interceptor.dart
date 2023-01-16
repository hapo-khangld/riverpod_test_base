import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_test_base/app_configs/configs.dart';
import 'package:riverpod_test_base/data/local/shared_preferences_service.dart';

final appDioProvider = Provider(
      (ref) => AppDioInterceptor.provideDio(
    ref.read(sharedPrefServiceProvider),
  ),
);

abstract class AppDioInterceptor {
  static Dio provideDio(SharedPreferencesService sharedPreferencesService) {
    Dio dio;

    var options = BaseOptions(
      baseUrl: AppConfigs.apiBaseUrl,
      connectTimeout: AppConfigs.kConnectApiTimeout,
      receiveTimeout: AppConfigs.kReceiveApiTimeout,
      receiveDataWhenStatusError: true,
    );

    dio = Dio(options);

    dio.interceptors.addAll(
      [
        InterceptorsWrapper(
          onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
            options.headers['Accept'] = "application/json";
            if (options.headers['no-auth'] != null) {
              options.headers.remove('no-auth');
              handler.next(options);
              return;
            }
            if (sharedPreferencesService.authToken != null) {
              options.headers.addAll({"Authorization": "Bearer ${sharedPreferencesService.authToken!}"});
              options.headers.addAll({"Charset": "utf-8"});
            }
            return handler.next(options);
          },
          onResponse: (Response<dynamic> response, ResponseInterceptorHandler handler) {
            return handler.next(response);
          },
          onError: (DioError err, ErrorInterceptorHandler handler) async {
            //console.error(err);
            return handler.next(err);
          }
          // onError: (DioError err, ErrorInterceptorHandler handler) async {
          //   final httpMethod = err.requestOptions.method.toUpperCase();
          //   final url = err.requestOptions.baseUrl + err.requestOptions.path;
          //   debugPrint('\tMETHOD: $httpMethod'); // GET
          //   debugPrint('\tURL: $url'); // URL
          //   // if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
          //   //   /// todo: setup refresh token
          //   //   try {
          //   //     final Dio dioRefresh = Dio(
          //   //       BaseOptions(
          //   //         headers: <String, String>{
          //   //           "content-type": 'application/x-www-form-urlencoded',
          //   //         },
          //   //       ),
          //   //     );
          //   //   } on DioError catch (e) {
          //   //     handler.next(e);
          //   //   }
          //   // }
          //   if (err.response != null) {
          //     debugPrint('\tStatus code: ${err.response!.statusCode}');
          //     if (err.response!.data != null) {
          //       final body = err.response!.data as Map<String, dynamic>; //API Dependant
          //       final code = body['status_code'] as int;
          //       final message = err.response!.statusMessage as String; //API Dependant
          //       debugPrint('\tException: $code');
          //       debugPrint('\tException2: $message');
          //       if (code == 500) {
          //         sharedPreferencesService.removeAll();
          //       }
          //       if (body.containsKey('data')) {
          //         //API Dependant
          //         final data = body['data'] as List<Object?>;
          //         if (data.isNotEmpty) {
          //           debugPrint('\tData: $data');
          //         }
          //       }
          //     } else {
          //       debugPrint('${err.response!.data}');
          //     }
          //   } else if (err.error is SocketException) {
          //     const message = 'No internet connectivity';
          //     debugPrint('\tException: FetchDataException');
          //     debugPrint('\tMessage: $message');
          //   } else {
          //     debugPrint('\tUnknown Error');
          //   }
          // },
        ),
        RetryInterceptor(
          dio: dio,
          logPrint: print,
          retries: 3,
        ),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      ],
    );

    return dio;
  }
}