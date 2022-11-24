part of 'question_filter_cubit.dart';

class QuestionFilterState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final List<CategoryDto>? categories;
  final List<SpecieDto>? species;
  final List<SymptomDto>? symptom;
  final List<VeterinarianQuestionFilterDto>? questions;
  final String selectedCategory;
  final String selectedSpecies;
  final String selectedSymptom;
  final String answered;
  final int page;
  final int questionId;
  final List<int>? symptoms;
  final String? selectedtSymptomsName;
  final int symptomId;

  const QuestionFilterState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.categories,
    this.species,
    this.symptom,
    this.questions,
    this.selectedCategory = '',
    this.selectedSpecies = '',
    this.selectedSymptom = '',
    this.answered = '',
    this.page = 1,
    this.questionId = 0,
    this.symptoms,
    this.selectedtSymptomsName,
    this.symptomId = 0,
  });

  QuestionFilterState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    List<CategoryDto>? categories,
    List<SpecieDto>? species,
    List<SymptomDto>? symptom,
    List<VeterinarianQuestionFilterDto>? questions,
    String? selectedCategory,
    String? selectedSpecies,
    String? selectedSymptom,
    String? answered,
    int? page,
    int? questionId,
    List<int>? symptoms,
    String? selectedtSymptomsName,
    int? symptomId,
  }) {
    return QuestionFilterState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      categories: categories ?? this.categories,
      species: species ?? this.species,
      symptom: symptom ?? this.symptom,
      questions: questions ?? this.questions,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSpecies: selectedSpecies ?? this.selectedSpecies,
      selectedSymptom: selectedSymptom ?? this.selectedSymptom,
      answered: answered ?? this.answered,
      page: page ?? this.page,
      questionId: questionId ?? this.questionId,
      symptoms: symptoms ?? this.symptoms,
      selectedtSymptomsName: selectedtSymptomsName ?? this.selectedtSymptomsName,
      symptomId: symptomId ?? this.symptomId,
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
        symptom,
        questions,
        selectedCategory,
        selectedSpecies,
        selectedSymptom,
        answered,
        page,
        questionId,
        symptoms,
        selectedtSymptomsName,
        symptomId,
      ];
}
