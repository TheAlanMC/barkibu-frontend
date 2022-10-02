part of 'login_cubit.dart';

class LoginState extends Equatable {
  final ScreenStatus status;
  final bool loginSuccess;
  final String? errorMessage;
  final Exception? exception;
  final String? token;
  final String? refreshToken;

  const LoginState({
    this.status = ScreenStatus.initial,
    this.loginSuccess = false,
    this.errorMessage,
    this.exception,
    this.token,
    this.refreshToken,
  });

  LoginState copyWith({
    GlobalKey<FormState>? formKey,
    ScreenStatus? status,
    bool? loginSuccess,
    String? errorMessage,
    Exception? exception,
    String? token,
    String? refreshToken,
  }) {
    return LoginState(
      status: status ?? this.status,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object?> get props => [
        status,
        loginSuccess,
        errorMessage,
        exception,
        token,
        refreshToken,
      ];
}
