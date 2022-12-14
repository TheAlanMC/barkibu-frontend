import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'veterinarian_info_state.dart';

class VeterinarianInfoCubit extends Cubit<VeterinarianInfoState> {
  VeterinarianInfoCubit() : super(const VeterinarianInfoState());

  void reset() {
    emit(const VeterinarianInfoState());
  }

  Future<void> getVeterinarianInfo() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      VeterinarianInfoDto veterinarianInfo = await VeterinarianInfoService.getVeterinarianInfo();
      await veterinarianInfo.validatePhotoPath();
      VeterinarianRankingDto veterinarianRanking = await VeterinarianInfoService.getVeterinarianRanking();
      VeterinarianReputationDto veterinarianReputation = await VeterinarianInfoService.getVeterinarianReputation();
      List<VeterinarianContributionDto> veterinarianContributions = await VeterinarianInfoService.getVeterinarianContributions();
      VeterinaryDto veterinaryResponse = await VeterinaryService.getVeterinary();
      emit(state.copyWith(
        status: ScreenStatus.success,
        veterinarianInfo: veterinarianInfo,
        veterinarianRanking: veterinarianRanking,
        veterinarianReputation: veterinarianReputation,
        veterinarianContributions: veterinarianContributions,
        veterinary: veterinaryResponse,
      ));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }
}
