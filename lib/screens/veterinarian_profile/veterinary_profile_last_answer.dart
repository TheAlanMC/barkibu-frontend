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
          title: const Text('Preguntas respondidas'),
          centerTitle: true,
        ),
        body: BlocBuilder<VeterinarianOwnAnswerCubit, VeterinarianOwnAnswerState>(builder: (context, state) {
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
                Text(veterinarianOwnAnswerDto.petName),
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
                      if (veterinarianOwnAnswerDto.totalLikes != 0)
                        Row(
                          children: [
                            const Icon(Icons.thumb_up),
                            Text(
                              ' +${veterinarianOwnAnswerDto.totalLikes.toString()}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      Text(getAnswerDateString(veterinarianOwnAnswerDto.answerDate)),
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

  String getAnswerDateString(DateTime answerDate) {
    final now = DateTime.now();
    final difference = now.difference(answerDate);
    if (difference.inDays > 0) {
      return 'Hace ${difference.inDays} días';
    } else if (difference.inHours > 0) {
      return 'Hace ${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return 'Hace ${difference.inMinutes} minutos';
    } else {
      return 'Hace un momento';
    }
  }
}
