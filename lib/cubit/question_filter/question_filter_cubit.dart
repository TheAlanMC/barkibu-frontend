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
}
