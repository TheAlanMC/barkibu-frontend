class LoginResponseDto {
  final bool success;
  final String? token;
  final String? refreshToken;
  final String? firstName;
  final String? lastName;

  LoginResponseDto({this.success = false, this.token, this.refreshToken, this.firstName, this.lastName});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      success: json['success'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'token': token,
      'refreshToken': refreshToken,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
