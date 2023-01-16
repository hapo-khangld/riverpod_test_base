import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test_base/core/data/model/failure.dart';
import 'package:riverpod_test_base/core/enum/view_state.dart';
import 'package:riverpod_test_base/model/login/login_response_model.dart';
import 'package:riverpod_test_base/repository/authentication_repository.dart';
import 'package:riverpod_test_base/ui/provider/state_notifier_provider.dart';

final loginViewModelProvider = ChangeNotifierProvider((ref) {
  final authenProvider = ref.watch(authRepositoryProvider);
  return LoginViewModel(authenProvider, ref);
});

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this.authenticationRepositoryImpl, this.ref);
  final AuthenticationRepositoryImpl authenticationRepositoryImpl;
  final Ref ref;

  Future<Either<Failure, LoginResponseModel>> login(String code, String password) async {
    ref.read(viewStateProvider.notifier).state = ViewState.loading;

    final userData = await authenticationRepositoryImpl.userLogin(code: code, password: password);
    notifyListeners();
    return userData;
  }
}
