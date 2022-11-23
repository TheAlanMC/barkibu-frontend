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
                Logout.logout(context);
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
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                for (VeterinarianOwnAnswerDto veterinarianOwnAnswerDto in state.veterinarianOwnAnswers!)
                  PetQuestionCard(
                      question: veterinarianOwnAnswerDto.question,
                      detail: veterinarianOwnAnswerDto.answer,
                      petName: veterinarianOwnAnswerDto.petName,
                      postedDate: veterinarianOwnAnswerDto.answerDate,
                      likeVisible: true,
                      likes: veterinarianOwnAnswerDto.totalLikes,
                      photoPath: veterinarianOwnAnswerDto.photoPath),
                const SizedBox(height: 80),
              ],
            ),
          );
        }));
  }
}
