import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'pet_treatment_state.dart';

class PetTreatmentCubit extends Cubit<PetTreatmentState> {
  PetTreatmentCubit() : super(const PetTreatmentState());

  Future<void> getPetTreatments(int petId) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      final List<TreatmentDto> treatments = await PetTreatmentService.getTreatments();
      final List<PetTreatmentDto> petTreatments = await PetTreatmentService.getPetTreatments(petId);
      emit(state.copyWith(status: ScreenStatus.success, treatments: treatments, petTreatments: petTreatments));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> createPetTreatment({required int petId, required String treatmentLastDate, required String treatmentNextDate}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PetTreatmentService.createPetTreatment(
          petId, state.treatmentId, DateUtil.getAmericanDate(treatmentLastDate), DateUtil.getAmericanDate(treatmentNextDate));
      emit(state.copyWith(status: ScreenStatus.success, result: response, treatmentId: 0));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  void changeTreatmentId(int treatmentId) {
    emit(state.copyWith(status: ScreenStatus.initial, treatmentId: treatmentId));
  }

  loadTreatment(PetTreatmentDto petTreatment) {
    emit(state.copyWith(status: ScreenStatus.initial, petTreatment: petTreatment));
  }
}
