part of 'password_management_cubit.dart';

class PasswordManagementState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final String? email;
  final String? secretCode;
  final String? password;

  const PasswordManagementState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.email,
    this.secretCode,
    this.password,
  });

  PasswordManagementState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    String? email,
    String? secretCode,
    String? password,
  }) {
    return PasswordManagementState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      email: email ?? this.email,
      secretCode: secretCode ?? this.secretCode,
      password: password ?? this.password,
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
        password,
      ];
}
