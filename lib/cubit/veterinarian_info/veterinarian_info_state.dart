part of 'veterinarian_info_cubit.dart';

class VeterinarianInfoState extends Equatable {
  final ScreenStatus status;
  final String? statusCode;
  final String? errorDetail;
  final VeterinarianInfoDto? veterinarianInfo;
  final VeterinarianRankingDto? veterinarianRanking;
  final VeterinarianReputationDto? veterinarianReputation;
  final List<VeterinarianContributionDto>? veterinarianContributions;
  final VeterinaryDto? veterinary;

  const VeterinarianInfoState({
    this.status = ScreenStatus.initial,
    this.statusCode,
    this.errorDetail,
    this.veterinarianInfo,
    this.veterinarianRanking,
    this.veterinarianReputation,
    this.veterinarianContributions,
    this.veterinary,
  });

  VeterinarianInfoState copyWith({
    ScreenStatus? status,
    String? statusCode,
    String? errorDetail,
    VeterinarianInfoDto? veterinarianInfo,
    VeterinarianRankingDto? veterinarianRanking,
    VeterinarianReputationDto? veterinarianReputation,
    List<VeterinarianContributionDto>? veterinarianContributions,
    VeterinaryDto? veterinary,
  }) {
    return VeterinarianInfoState(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      veterinarianInfo: veterinarianInfo ?? this.veterinarianInfo,
      veterinarianRanking: veterinarianRanking ?? this.veterinarianRanking,
      veterinarianReputation: veterinarianReputation ?? this.veterinarianReputation,
      veterinarianContributions: veterinarianContributions ?? this.veterinarianContributions,
      veterinary: veterinary ?? this.veterinary,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusCode,
        errorDetail,
        veterinarianInfo,
        veterinarianRanking,
        veterinarianReputation,
        veterinarianContributions,
        veterinary,
      ];
}
