class RegisterUserResponseDto {
  final bool success;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  RegisterUserResponseDto({
    this.success = false,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory RegisterUserResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponseDto(
      success: json['success'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
