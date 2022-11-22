import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                Future.microtask(() {
                  TokenSecureStorage.deleteTokens();
                  SkipAnimation.pushAndRemoveUntil(context, '/login_screen');
                });
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
    final questionDetailCubit = BlocProvider.of<QuestionDetailCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preguntas'),
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
                  for (QuestionAnswerDto questionAnswerDto in state.questionAnswers!) Card(child: _questionAnswers(context, questionAnswerDto)),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _questionAnswers(BuildContext context, QuestionAnswerDto questionAnswerDto) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${questionAnswerDto.veterinarianFirstName} ${questionAnswerDto.veterinarianLastName}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.shadow),
                    color: AppTheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      questionAnswerDto.answer,
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      const Icon(Icons.thumb_up),
                      Text(
                        ' +${questionAnswerDto.totalLikes.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Text(DateUtil.getDateString(questionAnswerDto.answerDate)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: !questionAnswerDto.liked
                            ? () => BlocProvider.of<QuestionDetailCubit>(context).supportAnswer(questionAnswerDto.answerId)
                            : null,
                        child: const Text('Votar como util', textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
