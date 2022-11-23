import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'veterinary_state.dart';

class VeterinaryCubit extends Cubit<VeterinaryState> {
  VeterinaryCubit() : super(const VeterinaryState());

  void reset() {
    emit(const VeterinaryState());
  }

  void updateLocation(double latitude, double longitude) {
    emit(state.copyWith(status: ScreenStatus.initial, latitude: latitude, longitude: longitude));
  }

  Future<void> registerVeterinary({required String name, required String address, required String description}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await VeterinaryService.registerVeterinary(name, address, state.latitude, state.longitude, description);
      emit(state.copyWith(status: ScreenStatus.success, result: response));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> getVeterinary() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      VeterinaryDto veterinaryResponse = await VeterinaryService.getVeterinary();
      emit(state.copyWith(status: ScreenStatus.success, veterinary: veterinaryResponse));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> updateVeterinary({required String name, required String address, required String description}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await VeterinaryService.updateVeterinary(name, address, state.latitude, state.longitude, description);
      emit(state.copyWith(status: ScreenStatus.success, result: response));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }
}
