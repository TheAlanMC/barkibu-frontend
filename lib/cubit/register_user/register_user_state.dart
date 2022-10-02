part of 'register_user_cubit.dart';

class RegisterUserState extends Equatable {
  final ScreenStatus status;
  final bool registerUserSuccess;
  final String? errorMessage;
  final Exception? exception;
  final String? name;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  const RegisterUserState({
    this.status = ScreenStatus.initial,
    this.registerUserSuccess = false,
    this.errorMessage,
    this.exception,
    this.name,
    this.lastName,
    this.userName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  RegisterUserState copyWith({
    ScreenStatus? status,
    bool? registerUserSuccess,
    String? errorMessage,
    Exception? exception,
    String? name,
    String? lastName,
    String? userName,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterUserState(
      status: status ?? this.status,
      registerUserSuccess: registerUserSuccess ?? this.registerUserSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
        status,
        registerUserSuccess,
        errorMessage,
        exception,
        name,
        lastName,
        userName,
        email,
        password,
        confirmPassword,
      ];
}
