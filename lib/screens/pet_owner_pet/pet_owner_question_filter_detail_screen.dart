import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerQuestionDetailFilterScreen extends StatelessWidget {
  const OwnerQuestionDetailFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionDetailCubit = BlocProvider.of<QuestionDetailCubit>(context);
    final questionFilterCubit = BlocProvider.of<QuestionFilterCubit>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: questionDetailCubit.getQuestionDetail(questionFilterCubit.state.questionId),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (questionDetailCubit.state.status) {
              case ScreenStatus.initial:
                break;
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                return _OwnerQuestionDetailFilterScreen();
              case ScreenStatus.failure:
                Logout.logout(context);
                break;
            }
            return Container();
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 3,
      ),
    );
  }
}

class _OwnerQuestionDetailFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        centerTitle: true,
      ),
      body: BlocConsumer<QuestionDetailCubit, QuestionDetailState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              customShowDialog(context: context, title: 'Conectando...', message: 'Por favor espere', isDismissible: false);
              break;
            case ScreenStatus.success:
              await customShowDialog(
                context: context,
                title: 'ÉXITO',
                message: '${state.question!.petName} le agradece su apoyo',
                onPressed: () {
                  SkipAnimation.pushReplacement(context, '/pet_owner_filter_detail');
                },
                textButton: "Aceptar",
              );
              break;
            case ScreenStatus.failure:
              if (state.statusCode == 'SCTY-2002') Logout.logout(context);
              await customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
              break;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  PetQuestionCard(
                    question: state.question!.problem,
                    detail: state.question!.description,
                    photoPath: state.question!.photoPath,
                    petName: state.question!.petName,
                    postedDate: state.question!.postedDate,
                  ),
                  QuestionPetInfoCard(
                    petName: state.question!.petName,
                    specie: state.questionPetInfo!.specie,
                    breed: state.questionPetInfo!.breed,
                    gender: state.questionPetInfo!.gender,
                    bornDate: state.questionPetInfo!.bornDate,
                    castrated: state.questionPetInfo!.castrated,
                    symptoms: state.questionPetInfo!.symptoms,
                  ),
                  for (QuestionAnswerDto questionAnswerDto in state.questionAnswers!)
                    if (questionAnswerDto.answered == false)
                      QuestionAnswerCard(
                        answerId: questionAnswerDto.answerId,
                        firstName: questionAnswerDto.veterinarianFirstName,
                        lastName: questionAnswerDto.veterinarianLastName,
                        answer: questionAnswerDto.answer,
                        likes: questionAnswerDto.totalLikes,
                        liked: questionAnswerDto.liked,
                        postedDate: questionAnswerDto.answerDate,
                      ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
