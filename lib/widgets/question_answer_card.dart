import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionAnswerCard extends StatelessWidget {
  final bool answered;
  final bool canBeAnswered;
  final bool answeredByMe;
  final int? answerId;
  final String? firstName;
  final String? lastName;
  final String? answer;
  final int? likes;
  final bool? liked;
  final DateTime? postedDate;
  final TextEditingController answerController = TextEditingController();

  QuestionAnswerCard({
    Key? key,
    this.answered = true,
    this.canBeAnswered = false,
    this.answeredByMe = false,
    this.answerId,
    this.firstName,
    this.lastName,
    this.answer,
    this.likes,
    this.liked,
    this.postedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionDetailCubit = BlocProvider.of<QuestionDetailCubit>(context);
    if (canBeAnswered) {
      answerController.text = answer ?? '';
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    !answered
                        ? 'Aun no hay respuestas sobre esta pregunta, sea el primero en responder'
                        : (canBeAnswered && !answeredByMe)
                            ? 'Responde esta pregunta'
                            : '$firstName $lastName',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  if (!answeredByMe && canBeAnswered)
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
                  if (canBeAnswered)
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
                            decoration: InputDecoration(
                                labelText: !answeredByMe
                                    ? 'Escribe tu respuesta'
                                    : 'Edita tu respuesta'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese una respuesta';
                              }
                              return null;
                            },
                            controller: answerController,
                          ),
                        ),
                      ),
                    )
                  else
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
                          answer!,
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  if (canBeAnswered && !answeredByMe)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 200,
                          child: OutlinedButton(
                            onPressed: () => questionDetailCubit
                                .postQuestionAnswer(answerController.text),
                            child: const Text(
                              'Publicar Respuesta',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!canBeAnswered || (answered && answeredByMe))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Icon(Icons.thumb_up),
                          Text(
                            ' +$likes',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                        Text(DateUtil.getDateString(postedDate!)),
                      ],
                    ),
                  if (!canBeAnswered || (answered && answeredByMe))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: OutlinedButton(
                            onPressed: !liked!
                                ? () =>
                                    questionDetailCubit.supportAnswer(answerId!)
                                : null,
                            child: const Text('Votar como util',
                                textAlign: TextAlign.center),
                          ),
                        ),
                        if (answeredByMe)
                          SizedBox(
                            width: 150,
                            child: OutlinedButton(
                              onPressed: () => questionDetailCubit
                                  .updateQuestionAnswer(answerController.text),
                              child: const Text('Editar Respuesta',
                                  textAlign: TextAlign.center),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
