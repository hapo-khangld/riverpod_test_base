import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_test_base/core/data/model/api_response.dart';
import 'package:riverpod_test_base/model/login/login_response_model.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/login")
  Future<ApiResponse<LoginResponseModel>> userLogin(
    @Part(name: 'code') String? code,
    @Part(name: 'password') String? password,
  );
}
