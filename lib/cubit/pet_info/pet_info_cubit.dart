import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'pet_info_state.dart';

class PetInfoCubit extends Cubit<PetInfoState> {
  PetInfoCubit() : super(const PetInfoState());
  void reset() {
    emit(const PetInfoState());
  }

  Future<void> getPetInfo() async {
    // TODO CHANGE TO LOADING
    emit(state.copyWith(status: ScreenStatus.success));
    try {
      List<PetInfoDto> pets = await PetInfoService.getPetInfo();
      for (final PetInfoDto pet in pets) {
        await pet.validatePhotoPath();
      }
      emit(state.copyWith(status: ScreenStatus.success, pets: pets));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }
}
