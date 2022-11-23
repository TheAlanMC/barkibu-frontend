import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/veterinarian_info_service.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'veterinarian_own_answer_state.dart';

class VeterinarianOwnAnswerCubit extends Cubit<VeterinarianOwnAnswerState> {
  VeterinarianOwnAnswerCubit() : super(const VeterinarianOwnAnswerState());

  void reset() {
    emit(const VeterinarianOwnAnswerState());
  }

  Future<void> getVeterinarianOwnAnswers() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final List<VeterinarianOwnAnswerDto> veterinarianOwnAnswers = await VeterinarianInfoService.getVeterinarianOwnAnswers();
      for (final veterinarianOwnAnswer in veterinarianOwnAnswers) {
        await veterinarianOwnAnswer.validatePhotoPath();
      }
      emit(state.copyWith(status: ScreenStatus.success, veterinarianOwnAnswers: veterinarianOwnAnswers));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }
}
