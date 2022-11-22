part of 'question_detail_cubit.dart';

class QuestionDetailState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final QuestionDto? question;
  final QuestionPetInfoDto? questionPetInfo;
  final List<QuestionAnswerDto>? questionAnswers;
  final int? questionId;

  const QuestionDetailState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.question,
    this.questionPetInfo,
    this.questionAnswers,
    this.questionId,
  });

  QuestionDetailState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    QuestionDto? question,
    QuestionPetInfoDto? questionPetInfo,
    List<QuestionAnswerDto>? questionAnswers,
    int? questionId,
  }) {
    return QuestionDetailState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      question: question ?? this.question,
      questionPetInfo: questionPetInfo ?? this.questionPetInfo,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      questionId: questionId ?? this.questionId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        result,
        statusCode,
        errorDetail,
        question,
        questionPetInfo,
        questionAnswers,
        questionId,
      ];
}
