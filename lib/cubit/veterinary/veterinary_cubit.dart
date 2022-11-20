import 'package:barkibu/dto/veterinary_dto.dart';
import 'package:barkibu/services/veterinary_service.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart';

part 'veterinary_state.dart';

class VeterinaryCubit extends Cubit<VeterinaryState> {
  VeterinaryCubit() : super(const VeterinaryState());
  void updateLocation(double latitude, double longitude) {
    emit(state.copyWith(latitude: latitude, longitude: longitude));
  }
}
