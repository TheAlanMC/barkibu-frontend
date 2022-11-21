import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/question_filter_service.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'question_filter_state.dart';

class QuestionFilterCubit extends Cubit<QuestionFilterState> {
  QuestionFilterCubit() : super(const QuestionFilterState());

  Future<void> getFilters() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final List<CategoryDto> categories = await QuestionFilterService.getCategories();
      final List<SpecieDto> species = await QuestionFilterService.getSpecies();
      emit(state.copyWith(status: ScreenStatus.success, categories: categories, species: species));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> getQuestions() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      if (state.hasReachedMax) return;
      final List<VeterinarianQuestionFilterDto> questions =
          await QuestionFilterService.getQuestions(state.selectedCategory, state.selectedSpecies, state.answered, state.page);
      if (questions.isEmpty) {
        emit(state.copyWith(status: ScreenStatus.success, hasReachedMax: true));
      } else {
        emit(state.copyWith(status: ScreenStatus.success, questions: [...state.questions!, ...questions], page: state.page + 1));
      }
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

  void changeSpecies(value) {
    String specieId = value == 0 ? '' : value.toString();
    emit(state.copyWith(status: ScreenStatus.initial, selectedSpecies: specieId));
  }

  void changeQuestions(value) {
    String answered = value == 0
        ? ''
        : value == 1
            ? 'true'
            : 'false';
    emit(state.copyWith(status: ScreenStatus.initial, answered: answered));
  }

  void resetPagination() {
    emit(state.copyWith(status: ScreenStatus.initial, page: 1, hasReachedMax: false));
  }
}