import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/question_filter_service.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'question_filter_state.dart';

class QuestionFilterCubit extends Cubit<QuestionFilterState> {
  QuestionFilterCubit() : super(const QuestionFilterState());

  void reset() {
    emit(const QuestionFilterState());
  }

  Future<void> getFilters() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final List<CategoryDto> categories = await QuestionFilterService.getCategories();
      final List<SpecieDto> species = await QuestionFilterService.getSpecies();
      final List<SymptomDto> symptom = await QuestionFilterService.getSymptom();
      emit(state.copyWith(status: ScreenStatus.success, categories: categories, species: species, symptom: symptom, symptoms: [], symptomId: 0));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> getQuestions() async {
    emit(state.copyWith(status: ScreenStatus.loading, questions: [], page: 1));
    try {
      final List<VeterinarianQuestionFilterDto> questions =
          await QuestionFilterService.getQuestions(state.selectedCategory, state.selectedSpecies, state.answered, state.page);
      for (final VeterinarianQuestionFilterDto question in questions) {
        await question.validatePhotoPath();
      }
      emit(state.copyWith(status: ScreenStatus.success, questions: questions, page: state.page + 1, questionId: 0));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> getMoreQuestions() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final List<VeterinarianQuestionFilterDto> questions =
          await QuestionFilterService.getQuestions(state.selectedCategory, state.selectedSpecies, state.answered, state.page);
      for (final VeterinarianQuestionFilterDto question in questions) {
        await question.validatePhotoPath();
      }
      emit(state.copyWith(status: ScreenStatus.initial, questions: [...state.questions!, ...questions], page: state.page + 1));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  void changeCategory(value) {
    String categoryId = value == 0 ? '' : value.toString();
    emit(state.copyWith(status: ScreenStatus.initial, selectedCategory: categoryId));
  }

  void changeSymptom(value) {
    String symptomId = value == 0 ? '' : value.toString();
    emit(state.copyWith(status: ScreenStatus.initial, selectedSymptom: symptomId));
  }

  void changeSpecies(value) {
    String specieId = value == 0 ? '' : value.toString();
    emit(state.copyWith(status: ScreenStatus.initial, selectedSpecies: specieId));
  }

  void changeKeyWord(value) {
    String answered = value.toString();
    emit(state.copyWith(status: ScreenStatus.initial, answered: answered));
  }

  void changeQuestions(value) {
    String answered = value == 0
        ? ''
        : value == 1
            ? 'true'
            : 'false';
    emit(state.copyWith(status: ScreenStatus.initial, answered: answered));
  }

  setQuestionId(int questionId) {
    emit(state.copyWith(status: ScreenStatus.success, questionId: questionId));
  }

  Future<void> getQuestionsOwner() async {
    emit(state.copyWith(status: ScreenStatus.loading, questions: [], page: 1));
    try {
      final List<VeterinarianQuestionFilterDto> questions =
          await QuestionFilterService.getQuestionsOwner(state.selectedCategory, state.selectedSpecies, state.answered, state.page);
      for (final VeterinarianQuestionFilterDto question in questions) {
        await question.validatePhotoPath();
      }
      emit(state.copyWith(status: ScreenStatus.success, questions: questions, page: state.page + 1, questionId: 0));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  void changeSymptomId(value) {
    emit(state.copyWith(status: ScreenStatus.initial, symptomId: value));
  }

  void changeCategoryId(value) {
    emit(state.copyWith(status: ScreenStatus.initial, categoryId: value));
  }

  void addSymptom() {
    int selectedSymptom = state.symptomId;
    if (selectedSymptom == 0) {
      return;
    }
    List<int> symptom = state.symptoms;
    if (!symptom.contains(selectedSymptom)) {
      symptom.add(selectedSymptom);
    }
    emit(state.copyWith(status: ScreenStatus.initial, symptoms: symptom));
  }

  void deleteSymptom() {
    List<int> symptom = state.symptoms;
    if (symptom.isNotEmpty) {
      symptom.removeLast();
    }
    emit(state.copyWith(status: ScreenStatus.initial, symptoms: symptom));
  }

  Future<void> registerQuestion({required int petId, required String problem, required String detailedDescription}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final String response = await QuestionFilterService.registerQuestion(state.categoryId, petId, problem, detailedDescription, state.symptoms);
      emit(state.copyWith(status: ScreenStatus.success, statusCode: response));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }
}
