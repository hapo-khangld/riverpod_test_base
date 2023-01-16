import 'package:riverpod_test_base/core/data/error/failure.dart';

class Failure extends BaseFailure {
  Failure({required String message, int? code}) : super(message: message, code: code);
}
