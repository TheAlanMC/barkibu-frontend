import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VeterinarianQuestionFilterScreen extends StatelessWidget {
  const VeterinarianQuestionFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionFilterCubit = BlocProvider.of<QuestionFilterCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preguntas'),
          centerTitle: true,
        ),
        body: BlocBuilder<QuestionFilterCubit, QuestionFilterState>(builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                for (VeterinarianQuestionFilterDto veterinarianQuestionFilterDto in state.questions!)
                  _veterinarianOwnAnswerCard(veterinarianQuestionFilterDto),
                const SizedBox(height: 80),
              ],
            ),
          );
        }));
  }

  Widget _veterinarianOwnAnswerCard(VeterinarianQuestionFilterDto veterinarianQuestionFilterDto) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                CustomCircleAvatar(
                  photoPath: veterinarianQuestionFilterDto.photoPath ?? 'assets/default_pet.jpg',
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: 100,
                    child: Text(
                      veterinarianQuestionFilterDto.petName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    veterinarianQuestionFilterDto.problem,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    veterinarianQuestionFilterDto.description,
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(DateUtil.getDateString(veterinarianQuestionFilterDto.postedDate)),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
