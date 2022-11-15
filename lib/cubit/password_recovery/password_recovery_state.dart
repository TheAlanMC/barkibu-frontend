part of 'password_recovery_cubit.dart';

class PasswordRecoveryState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final String? email;
  final String? secretCode;

  const PasswordRecoveryState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.email,
    this.secretCode,
  });

  PasswordRecoveryState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    String? email,
    String? secretCode,
  }) {
    return PasswordRecoveryState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      email: email ?? this.email,
      secretCode: secretCode ?? this.secretCode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        result,
        statusCode,
        errorDetail,
        email,
        secretCode,
      ];
}
