import 'dart:developer';

import 'package:petshopdashboard/core/base_view_model.dart';
import 'package:petshopdashboard/modules/login/repositories/login_repository.dart';
import 'package:petshopdashboard/services/storage/secure_storage.dart';

class LoginState {
  LoginState({
    this.isLoadingLogin,
    this.isLoggedInSucces,
    this.errorMessage,
    this.sessionId,
    this.emailError,
    this.passwordError,
    this.hidePassword,
  });

  final bool? isLoadingLogin;
  final bool? isLoggedInSucces;
  final String? errorMessage;
  final String? sessionId;
  final bool? emailError;
  final bool? passwordError;
  final bool? hidePassword;

  LoginState copyWith({
    bool? isLoadingLogin,
    bool? isLoggedInSucces,
    String? errorMessage,
    String? sessionId,
    bool? emailError,
    bool? passwordError,
    bool? hidePassword,
  }) {
    return LoginState(
      isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      isLoggedInSucces: isLoggedInSucces ?? this.isLoggedInSucces,
      errorMessage: errorMessage ?? this.errorMessage,
      sessionId: sessionId ?? this.sessionId,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }
}

class LoginViewModel extends BaseViewModel<LoginState> {
  LoginViewModel({
    required LoginRepository loginRepository,
    required SecureStorage secureStorage,
  }) : _loginRepository = loginRepository,
       _secureStorage = secureStorage;

  initViewModel() {
    initialize(LoginState(hidePassword: true));
  }

  final LoginRepository _loginRepository;
  final SecureStorage _secureStorage;

  void toggleHidePassword() {
    setState(state!.copyWith(hidePassword: !state!.hidePassword!));
  }

  Future<void> _saveSessionIdInStorage(String sessionId) async {
    await _secureStorage.setSessionId(sessionId);
  }

  bool _areFieldsValid(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<void> login(String email, String password) async {
    log("Called login");
    setState(state!.copyWith(isLoadingLogin: true));

    if (!_areFieldsValid(email, password)) {
      setState(
        state!.copyWith(
          isLoadingLogin: false,
          emailError: email.isEmpty,
          passwordError: password.isEmpty,
        ),
      );
      return;
    }

    final result = await _loginRepository.login(email, password);
    result.fold(
      (fail) => setState(
        state!.copyWith(
          isLoggedInSucces: false,
          errorMessage: fail.failure as String,
          isLoadingLogin: false,
        ),
      ),
      (loginResponse) {
        _saveSessionIdInStorage(
          //TODO: uncomment this once the backend return access token
          // loginResponse.accessToken!
          'fake_access_token',
        );
        setState(
          state!.copyWith(
            isLoggedInSucces: true,
            //TODO: uncomment this once the backend return access token
            sessionId: 'fake', //loginResponse.accessToken,
            isLoadingLogin: false,
          ),
        );
      },
    );
  }
}
