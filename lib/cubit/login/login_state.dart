part of 'login_cubit.dart';

class LoginState extends Equatable {
  final ScreenStatus status;
  final String? statusCode;
  final String? errorDetail;
  final String? token;
  final String? refreshToken;

  const LoginState({
    this.status = ScreenStatus.initial,
    this.statusCode,
    this.errorDetail,
    this.token,
    this.refreshToken,
  });

  LoginState copyWith({
    ScreenStatus? status,
    String? statusCode,
    String? errorDetail,
    String? token,
    String? refreshToken,
  }) {
    return LoginState(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusCode,
        errorDetail,
        token,
        refreshToken,
      ];
}
