import 'package:barkibu/dto/owner_own_question_dto.dart';
import 'package:barkibu/services/owner_own_question_service.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'owner_own_question_state.dart';

class OwnerOwnQuestionCubit extends Cubit<OwnerOwnQuestionState> {
  OwnerOwnQuestionCubit() : super(const OwnerOwnQuestionState());

  Future<void> getOwnerOwnQuestion() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      List<OwnerOwnQuestionDto> ownerOwnQuestions =
          await OwnerOwnQuestionService.getOwnerOwnQuestion();
      emit(state.copyWith(
        status: ScreenStatus.success,
        ownerOwnQuestions: ownerOwnQuestions,
      ));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(
          status: ScreenStatus.failure,
          statusCode: ex.statusCode,
          errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(
          status: ScreenStatus.failure,
          statusCode: '',
          errorDetail: 'Error de conexión'));
    }
  }

  void setQuestionId(int questionId) {
    emit(state.copyWith(status: ScreenStatus.success, questionId: questionId));
  }
}
