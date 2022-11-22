import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VeterinarianQuestionDetailScreen extends StatelessWidget {
  const VeterinarianQuestionDetailScreen({Key? key}) : super(key: key);

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
      bottomNavigationBar: const CustomBottomNavigationVeterinary(
        currentIndex: 1,
      ),
    );
  }
}

class _VeterinarianQuestionDetail extends StatelessWidget {
  final TextEditingController _answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final questionDetailCubit = BlocProvider.of<QuestionDetailCubit>(context);
    bool noAnswers = questionDetailCubit.state.questionAnswers!.isEmpty;
    QuestionAnswerDto? myQuestionAnswerDto;
    List<QuestionAnswerDto> otherQuestionAnswerDtos = [];
    for (QuestionAnswerDto questionAnswerDto in questionDetailCubit.state.questionAnswers!) {
      if (questionAnswerDto.answered == true) {
        myQuestionAnswerDto = questionAnswerDto;
      } else {
        otherQuestionAnswerDtos.add(questionAnswerDto);
      }
    }
    _answerController.text = myQuestionAnswerDto?.answer ?? '';
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
                  for (QuestionAnswerDto questionAnswerDto in otherQuestionAnswerDtos) Card(child: _questionAnswers(context, questionAnswerDto)),
                  Card(child: _questionOwnAnswer(context, myQuestionAnswerDto, noAnswers)),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _questionOwnAnswer(BuildContext context, QuestionAnswerDto? questionAnswerDto, bool noAnswers) {
    if (questionAnswerDto == null) {
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
                    noAnswers ? 'Aun no hay respuestas sobre esta pregunta, sea el primero en responder' : 'Responde esta pregunta',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.warning, color: AppTheme.alert),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Recuerda que no debes hacer diagnósticos ni tratamientos. Aconseja ir a la clínica cuando lo consideres necesario.',
                          textAlign: TextAlign.justify,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.shadow),
                      color: AppTheme.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          maxLines: 3,
                          autocorrect: false,
                          decoration: const InputDecoration(labelText: 'Escribe tu respuesta'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese una respuesta';
                            }
                            return null;
                          },
                          controller: _answerController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        child: OutlinedButton(
                          onPressed: () => BlocProvider.of<QuestionDetailCubit>(context).postQuestionAnswer(_answerController.text),
                          child: const Text(
                            'Publicar Respuesta',
                            style: TextStyle(fontSize: 14),
                          ),
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
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.shadow),
                    color: AppTheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        maxLines: 3,
                        autocorrect: false,
                        decoration: const InputDecoration(labelText: 'Respuesta'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese una respuesta';
                          }
                          return null;
                        },
                        controller: _answerController,
                      ),
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
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () => BlocProvider.of<QuestionDetailCubit>(context).updateQuestionAnswer(_answerController.text),
                        child: const Text('Editar Respuesta', textAlign: TextAlign.center),
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
