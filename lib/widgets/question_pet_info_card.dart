import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';

class QuestionPetInfoCard extends StatelessWidget {
  final String petName;
  final String specie;
  final String breed;
  final String gender;
  final DateTime bornDate;
  final bool castrated;
  final List<String> symptoms;

  const QuestionPetInfoCard({
    Key? key,
    required this.petName,
    required this.specie,
    required this.breed,
    required this.gender,
    required this.bornDate,
    required this.castrated,
    required this.symptoms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Informacion sobre $petName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Text('\u2022 Especie: $specie', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('\u2022 Raza: $breed', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('\u2022 Género: ${TextUtil.toUpperCaseFirstLetter(gender)}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('\u2022 Edad: ${DateUtil.getPetAge(bornDate)}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('\u2022 Castrado: ${TextUtil.yesOrNo(castrated)}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('\u2022 Sintomas: ${TextUtil.list(symptoms)}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
            ])
          ],
        ),
      ),
    );
  }
}
