part of 'question_filter_cubit.dart';

class QuestionFilterState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final List<CategoryDto>? categories;
  final List<SpecieDto>? species;

  const QuestionFilterState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.categories,
    this.species,
  });

  QuestionFilterState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    List<CategoryDto>? categories,
    List<SpecieDto>? species,
  }) {
    return QuestionFilterState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      categories: categories ?? this.categories,
      species: species ?? this.species,
    );
  }

  @override
  List<Object?> get props => [
        status,
        result,
        statusCode,
        errorDetail,
        categories,
        species,
      ];
}
