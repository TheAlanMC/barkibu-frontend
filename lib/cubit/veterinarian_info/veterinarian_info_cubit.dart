import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

part 'veterinarian_info_state.dart';

class VeterinarianInfoCubit extends Cubit<VeterinarianInfoState> {
  VeterinarianInfoCubit() : super(const VeterinarianInfoState());

  Future<void> getVeterinarianInfo() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String token = await storage.read(key: 'token') ?? '';
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      VeterinarianInfoDto veterinarianInfo = await VeterinarianInfoService.getVeterinarianInfo(token);
      VeterinarianRankingDto veterinarianRanking = await VeterinarianInfoService.getVeterinarianRanking(token);
      VeterinarianReputationDto veterinarianReputation = await VeterinarianInfoService.getVeterinarianReputation(token);
      List<VeterinarianContributionDto> veterinarianContributions = await VeterinarianInfoService.getVeterinarianContributions(token);
      VeterinaryDto veterinaryResponse = await VeterinaryService.getVeterinaryInfo(token);
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
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Erorr de conexión'));
    }
  }
}
