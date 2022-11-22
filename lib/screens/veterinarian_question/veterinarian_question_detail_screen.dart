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
    final questionId = ModalRoute.of(context)!.settings.arguments as int;
    final questionDetailCubit = BlocProvider.of<QuestionDetailCubit>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: questionDetailCubit.getQuestionDetail(questionId),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (questionDetailCubit.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                return _VeterinarianQuestionDetail();
              case ScreenStatus.failure:
                Future.microtask(() {
                  TokenSecureStorage.deleteTokens();
                  SkipAnimation.pushNamed(context, '/login_screen');
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
  final TextEditingController _answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final questionDetailCubit = BlocProvider.of<QuestionDetailCubit>(context);
    bool noAnswers = questionDetailCubit.state.questionAnswers!.isEmpty;
    QuestionAnswerDto? questionAnswerDto;
    for (QuestionAnswerDto questionAnswerDto in questionDetailCubit.state.questionAnswers!) {
      if (questionAnswerDto.answered == true) {
        questionAnswerDto = questionAnswerDto;
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preguntas'),
        centerTitle: true,
      ),
      body: BlocConsumer<QuestionDetailCubit, QuestionDetailState>(
        listener: (context, state) {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              break;
            case ScreenStatus.success:
              break;
            case ScreenStatus.failure:
              customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
              break;
            default:
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(child: _question(context, state.question!)),
                  Card(child: _questionPetInfo(context, state.questionPetInfo!)),
                  Card(child: _questionOwnAnswer(context, questionAnswerDto, noAnswers)),

                  // for (QuestionAnswerDto questionAnswerDto in state.questionAnswers!)
                  //   if (questionAnswerDto.answered = true)
                  //     Card(child: _questionOwnAnswer(questionAnswerDto))
                  //   else
                  //     Card(child: _questionAnswer(questionAnswerDto)),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _question(BuildContext context, QuestionDto questionDto) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              CustomCircleAvatar(
                photoPath: questionDto.photoPath ?? 'assets/default_pet.jpg',
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 100,
                child: Text(
                  questionDto.petName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  questionDto.problem,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Text(
                  questionDto.description,
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateUtil.getDateString(questionDto.postedDate)),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _questionPetInfo(BuildContext context, QuestionPetInfoDto questionPetInfoDto) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Informacion sobre tu mascota:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            Text('\u2022 Especie: ${questionPetInfoDto.specie}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('\u2022 Raza: ${questionPetInfoDto.breed}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('\u2022 Género: ${questionPetInfoDto.gender[0].toUpperCase() + questionPetInfoDto.gender.substring(1)}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('\u2022 Edad: ${DateUtil.getPetAge(questionPetInfoDto.bornDate)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('\u2022 Castrated: ${questionPetInfoDto.castrated ? 'Si' : 'No'}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text('\u2022 Sintomas:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            for (String symptom in questionPetInfoDto.symptoms)
              Text('                    - ${symptom[0].toUpperCase() + symptom.substring(1)}', style: const TextStyle(fontSize: 16)),
          ])
        ],
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
                          maxLines: 2,
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
                          onPressed: () {},
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${questionAnswerDto.veterinarianFirstName} ${questionAnswerDto.veterinarianLastName}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}
