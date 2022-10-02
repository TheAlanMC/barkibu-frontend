class RegisterPetResponseDto {
  final bool success;
  final String? name;
  final String? specie;
  final String? gender;
  final String? castrated;
  final String? bornDate;
  final int? breed;
  final String? lastRabiesVaccineDate;
  final String? lastPolyvalentVaccineDate;
  final String? lastDewormingDate;
  final String? photoPath;

  RegisterPetResponseDto({
    this.success = false,
    this.name,
    this.specie,
    this.gender,
    this.castrated,
    this.bornDate,
    this.breed,
    this.lastRabiesVaccineDate,
    this.lastPolyvalentVaccineDate,
    this.lastDewormingDate,
    this.photoPath,
  });

  factory RegisterPetResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterPetResponseDto(
        success: json['success'],
        name: json['name'],
        specie: json['specie'],
        gender: json['gender'],
        castrated: json['castrated'],
        bornDate: json['bornDate'],
        breed: json['breed'],
        lastRabiesVaccineDate: json['lastRabiesVaccineDate'],
        lastPolyvalentVaccineDate: json['lastPolyvalentVaccineDate'],
        lastDewormingDate: json['lastDewormingDate'],
        photoPath: json['photoPath']);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'name': name,
      'specie': specie,
      'gender': gender,
      'castrated': castrated,
      'bornDate': bornDate,
      'breed': breed,
      'lastRabiesVaccineDate': lastRabiesVaccineDate,
      'lastPolyvalentVaccineDate': lastPolyvalentVaccineDate,
      'lastDewormingDate': lastDewormingDate,
      'photoPath': photoPath,
    };
  }
}
