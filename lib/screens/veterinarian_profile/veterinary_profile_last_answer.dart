import 'package:barkibu/cubit/veterinarian_own_answer/veterinarian_own_answer_cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VeterinaryProfileLastAnswerScreen extends StatelessWidget {
  const VeterinaryProfileLastAnswerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final veterinarianOwnAnswerCubit = BlocProvider.of<VeterinarianOwnAnswerCubit>(context);
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: veterinarianOwnAnswerCubit.getVeterinarianOwnAnswers(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (veterinarianOwnAnswerCubit.state.status) {
              case ScreenStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case ScreenStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ScreenStatus.success:
                return const _VeterinarianOwnAnswer();
              case ScreenStatus.failure:
                Future.microtask(() {
                  TokenSecureStorage.deleteTokens();
                  SkipAnimation.pushReplacement(context, '/login_screen');
                });
                break;
            }
            return Container();
          }),
    ));
  }
}

class _VeterinarianOwnAnswer extends StatelessWidget {
  const _VeterinarianOwnAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preguntas Respondidas'),
          centerTitle: true,
        ),
        body: BlocBuilder<VeterinarianOwnAnswerCubit, VeterinarianOwnAnswerState>(builder: (context, state) {
          if (state.veterinarianOwnAnswers!.isEmpty) {
            return const Center(child: Text('No hay preguntas respondidas', style: TextStyle(fontSize: 20)));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                for (VeterinarianOwnAnswerDto veterinarianOwnAnswerDto in state.veterinarianOwnAnswers!)
                  _veterinarianOwnAnswerCard(veterinarianOwnAnswerDto),
              ],
            ),
          );
        }));
  }

  Widget _veterinarianOwnAnswerCard(VeterinarianOwnAnswerDto veterinarianOwnAnswerDto) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                CustomCircleAvatar(
                  photoPath: veterinarianOwnAnswerDto.photoPath ?? 'assets/default_pet.jpg',
                ),
                const SizedBox(height: 10),
                // fit the text to the container
                SizedBox(
                    width: 100,
                    child: Text(
                      veterinarianOwnAnswerDto.petName,
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
                    veterinarianOwnAnswerDto.question,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    veterinarianOwnAnswerDto.answer,
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.thumb_up),
                          Text(
                            ' +${veterinarianOwnAnswerDto.totalLikes.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(DateUtil.getDateString(veterinarianOwnAnswerDto.answerDate)),
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
