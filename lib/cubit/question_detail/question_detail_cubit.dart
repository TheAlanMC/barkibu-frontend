import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'question_detail_state.dart';

class QuestionDetailCubit extends Cubit<QuestionDetailState> {
  QuestionDetailCubit() : super(const QuestionDetailState());

  void reset() {
    emit(const QuestionDetailState());
  }

  Future<void> getQuestionDetail(int questionId) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final QuestionDto question = await QuestionDetailService.getQuestion(questionId);
      final QuestionPetInfoDto questionPetInfo = await QuestionDetailService.getQuestionPetInfo(questionId);
      final List<QuestionAnswerDto> questionAnswers = await QuestionDetailService.getQuestionAnswer(questionId);
      emit(state.copyWith(
          status: ScreenStatus.success,
          question: question,
          questionPetInfo: questionPetInfo,
          questionAnswers: questionAnswers,
          questionId: questionId));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> postQuestionAnswer(String answer) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final String result = await AnswerService.postAnswer(state.questionId!, answer);
      emit(state.copyWith(status: ScreenStatus.success, result: result));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> updateQuestionAnswer(String answer) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final String result = await AnswerService.updateAnswer(state.questionId!, answer);
      emit(state.copyWith(status: ScreenStatus.success, result: result));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> supportAnswer(int answerId) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final String result = await AnswerService.supportAnswer(answerId);
      emit(state.copyWith(status: ScreenStatus.success, result: result));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }
}
