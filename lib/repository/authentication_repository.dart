import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test_base/core/data/error/exception.dart';
import 'package:riverpod_test_base/core/data/model/failure.dart';
import 'package:riverpod_test_base/data/providers/data_provider.dart';
import 'package:riverpod_test_base/data/remote/api_client.dart';
import 'package:riverpod_test_base/model/login/login_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, LoginResponseModel>> userLogin({required String code, required String password});
}

final authRepositoryProvider = Provider<AuthenticationRepositoryImpl>((ref) {
  final appDioProvider = ref.watch(apiProvider);
  return AuthenticationRepositoryImpl(appDioProvider);
});

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final ApiClient _apiClient;

  AuthenticationRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, LoginResponseModel>> userLogin({required String code, required String password}) async {
    try {
      final userData = await _apiClient.userLogin(code, password);
      if (userData.statusCode == 200) {
        return Right(userData.data!);
      } else {
        return Left(
          Failure(message: userData.message!),
        );
      }
    } on DioError catch (e) {
      final message = e.message;
      final code = e.response?.statusCode;
      return Left(Failure(message: message, code: code));
    } on CacheException catch (error) {
      final message = error.message;
      final code = error.code;

      return Left(Failure(message: message, code: code));
    } on ServerException catch (error) {
      final message = error.message;
      final code = error.code;

      return Left(Failure(message: message, code: code));
    } catch (error) {
      const message = "5555";
      const code = 5000;

      return Left(Failure(message: message, code: code));
    }
  }
}
