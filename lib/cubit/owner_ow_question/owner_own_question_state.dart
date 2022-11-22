part of 'owner_own_question_cubit.dart';

class OwnerOwnQuestionState extends Equatable {
  final ScreenStatus status;
  final String? statusCode;
  final String? errorDetail;
  final List<OwnerOwnQuestionDto>? ownerOwnQuestions;

  const OwnerOwnQuestionState({
    this.status = ScreenStatus.initial,
    this.statusCode,
    this.errorDetail,
    this.ownerOwnQuestions,
  });

  OwnerOwnQuestionState copyWith({
    ScreenStatus? status,
    String? statusCode,
    String? errorDetail,
    List<OwnerOwnQuestionDto>? ownerOwnQuestions,
  }) {
    return OwnerOwnQuestionState(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      ownerOwnQuestions: ownerOwnQuestions ?? this.ownerOwnQuestions,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusCode,
        errorDetail,
        ownerOwnQuestions,
      ];
}
