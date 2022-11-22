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
        body: BlocConsumer<QuestionFilterCubit, QuestionFilterState>(listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.success:
              //TODO: UNCOMENT THIS
              // Navigator.of(context).pop();
              break;
            case ScreenStatus.failure:
              customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
              break;
            default:
          }
        }, builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              questionFilterCubit.getMoreQuestions();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    for (VeterinarianQuestionFilterDto veterinarianQuestionFilterDto in state.questions!)
                      Card(child: _questionFilter(context, veterinarianQuestionFilterDto)),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget _questionFilter(BuildContext context, VeterinarianQuestionFilterDto veterinarianQuestionFilterDto) {
    return Padding(
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
                ),
              ),
              SizedBox(
                width: 100,
                child: OutlinedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/veterinarian_question_detail_screen', arguments: veterinarianQuestionFilterDto.questionId),
                  child: const Text(
                    'Responder',
                    style: TextStyle(fontSize: 12),
                  ),
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
    );
  }
}
