part of 'veterinary_cubit.dart';

class VeterinaryState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final double latitude;
  final double longitude;

  const VeterinaryState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.latitude = -16.52290219088327,
    this.longitude = -68.11199388477854,
  });

  VeterinaryState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    double? latitude,
    double? longitude,
  }) {
    return VeterinaryState(
        status: status ?? this.status,
        result: result ?? this.result,
        statusCode: statusCode ?? this.statusCode,
        errorDetail: errorDetail ?? this.errorDetail,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }

  @override
  List<Object?> get props => [status, result, statusCode, errorDetail, latitude, longitude];
}
