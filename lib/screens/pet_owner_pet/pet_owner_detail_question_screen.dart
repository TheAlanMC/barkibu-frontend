import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barkibu/widgets/widgets.dart';

class PetOwnerDetailQuestionScreen extends StatelessWidget {
  const PetOwnerDetailQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionDetailCubit = BlocProvider.of<QuestionDetailCubit>(context);
    final ownerOwnQuestionCubit = BlocProvider.of<OwnerOwnQuestionCubit>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: questionDetailCubit.getQuestionDetail(ownerOwnQuestionCubit.state.questionId!),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (questionDetailCubit.state.status) {
              case ScreenStatus.initial:
                break;
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                return _VeterinarianQuestionDetail();
              case ScreenStatus.failure:
                Logout.logout(context);
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class _VeterinarianQuestionDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Respuestas'),
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
                message: '${state.question!.petName} le agradece su ayuda',
                onPressed: () {
                  SkipAnimation.pushReplacement(context, '/veterinarian_question_detail_screen');
                },
                textButton: "Aceptar",
              );
              break;
            case ScreenStatus.failure:
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
                      )
                    else
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
