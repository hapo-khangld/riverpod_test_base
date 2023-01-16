import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test_base/core/data/dio_config/app_dio_interceptor.dart';
import 'package:riverpod_test_base/data/remote/api_client.dart';

final apiProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(appDioProvider);
  return ApiClient(dio);
});
