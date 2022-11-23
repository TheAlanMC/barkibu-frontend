part of 'veterinarian_own_answer_cubit.dart';

class VeterinarianOwnAnswerState extends Equatable {
  final ScreenStatus status;
  final String? statusCode;
  final String? errorDetail;
  final List<VeterinarianOwnAnswerDto>? veterinarianOwnAnswers;
  final int page;
  final bool hasReachedMax;

  const VeterinarianOwnAnswerState({
    this.status = ScreenStatus.initial,
    this.statusCode,
    this.errorDetail,
    this.veterinarianOwnAnswers,
    this.page = 0,
    this.hasReachedMax = false,
  });

  VeterinarianOwnAnswerState copyWith({
    ScreenStatus? status,
    String? statusCode,
    String? errorDetail,
    List<VeterinarianOwnAnswerDto>? veterinarianOwnAnswers,
    int? page,
    bool? hasReachedMax,
  }) {
    return VeterinarianOwnAnswerState(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      veterinarianOwnAnswers: veterinarianOwnAnswers ?? this.veterinarianOwnAnswers,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusCode,
        errorDetail,
        veterinarianOwnAnswers,
        page,
        hasReachedMax,
      ];
}
