import 'package:barkibu/dto/dto.dart';

class DropDownMenu {
  static Map<int, String> getCountries(List<CountryDto>? countries) {
    Map<int, String> countriesMap = {};
    countriesMap[0] = 'Seleccione un país';
    countries?.forEach((element) {
      countriesMap[element.countryId] = element.country;
    });
    return countriesMap;
  }

  static Map<int, String> getStates(List<StateDto>? states, int? countryId) {
    Map<int, String> statesMap = {};
    statesMap[0] = 'Seleccione un estado';
    states?.forEach((element) {
      if (element.countryId == countryId) {
        statesMap[element.stateId] = element.state;
      }
    });
    return statesMap;
  }

  static Map<int, String> getCities(List<CityDto>? cities, int? stateId) {
    Map<int, String> citiesMap = {};
    citiesMap[0] = 'Seleccione una ciudad';
    cities?.forEach((element) {
      if (element.stateId == stateId) {
        citiesMap[element.cityId] = element.city;
      }
    });
    return citiesMap;
  }

  static Map<int, String> getCategoriesFilter(List<CategoryDto>? categories) {
    Map<int, String> categoriesMap = {};
    categoriesMap[0] = 'Todas las categorías';
    categories?.forEach((element) {
      categoriesMap[element.categoryId] = element.category;
    });
    return categoriesMap;
  }

  static Map<int, String> getSpeciesFilter(List<SpecieDto>? species) {
    Map<int, String> speciesMap = {};
    speciesMap[0] = 'Todas las especies';
    species?.forEach((element) {
      speciesMap[element.specieId] = element.specie;
    });
    return speciesMap;
  }

  static Map<int, String> getSpecies(List<SpecieDto>? species) {
    Map<int, String> speciesMap = {};
    speciesMap[0] = 'Seleccione una especie';
    species?.forEach((element) {
      speciesMap[element.specieId] = element.specie;
    });
    return speciesMap;
  }

  static Map<int, String> getBreeds(List<BreedDto>? breeds, int? specieId) {
    Map<int, String> breedsMap = {};
    breedsMap[0] = 'Seleccione una raza';
    breeds?.forEach((element) {
      if (element.specieId == specieId) {
        breedsMap[element.breedId] = element.breed;
      }
    });
    return breedsMap;
  }

  static Map<int, String> getSymptomFilter(List<SymptomDto>? symptom) {
    Map<int, String> symptomMap = {};
    symptomMap[0] = 'Todas los sintomas';
    symptom?.forEach((element) {
      symptomMap[element.symptomId] = element.symptom;
    });
    return symptomMap;
  }

  static Map<int, String> getTreatment(List<TreatmentDto>? treatment) {
    Map<int, String> treatmentMap = {};
    treatmentMap[0] = 'Seleccione un tratamiento';
    treatment?.forEach((element) {
      treatmentMap[element.treatmentId] = element.treatment;
    });
    return treatmentMap;
  }

  static String getTreatmentById(List<TreatmentDto>? treatment, int? treatmentId) {
    String treatmentName = '';
    treatment?.forEach((element) {
      if (element.treatmentId == treatmentId) {
        treatmentName = element.description;
      }
    });
    return treatmentName;
  }
}
