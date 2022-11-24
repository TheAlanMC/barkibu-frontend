part of 'user_pet_owner_cubit.dart';

class UserPetOwnerState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final UserPetOwnerDto? userPetOwnerDto;

  const UserPetOwnerState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.userPetOwnerDto,
  });

  UserPetOwnerState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    UserPetOwnerDto? userPetOwnerDto,
  }) {
    return UserPetOwnerState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      userPetOwnerDto: userPetOwnerDto ?? this.userPetOwnerDto,
    );
  }

  @override
  List<Object?> get props => [status, result, statusCode, errorDetail, userPetOwnerDto];
}
