class LoginResponseDto {
  final bool success;
  final String? token;
  final String? refreshToken;

  LoginResponseDto({
    this.success = false,
    this.token,
    this.refreshToken,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      success: json['success'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
