part of 'question_filter_cubit.dart';

class QuestionFilterState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final List<CategoryDto>? categories;
  final List<SpecieDto>? species;
  final List<VeterinarianQuestionFilterDto>? questions;
  final String selectedCategory;
  final String selectedSpecies;
  final String answered;
  final int page;
  final int questionId;

  const QuestionFilterState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.categories,
    this.species,
    this.questions,
    this.selectedCategory = '',
    this.selectedSpecies = '',
    this.answered = '',
    this.page = 1,
    this.questionId = 0,
  });

  QuestionFilterState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    List<CategoryDto>? categories,
    List<SpecieDto>? species,
    List<VeterinarianQuestionFilterDto>? questions,
    String? selectedCategory,
    String? selectedSpecies,
    String? answered,
    int? page,
    int? questionId,
  }) {
    return QuestionFilterState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      categories: categories ?? this.categories,
      species: species ?? this.species,
      questions: questions ?? this.questions,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSpecies: selectedSpecies ?? this.selectedSpecies,
      answered: answered ?? this.answered,
      page: page ?? this.page,
      questionId: questionId ?? this.questionId,
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
        questions,
        selectedCategory,
        selectedSpecies,
        answered,
        page,
        questionId,
      ];
}
