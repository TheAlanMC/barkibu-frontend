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
      body: BlocConsumer<QuestionFilterCubit, QuestionFilterState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.initial:
              Navigator.of(context).pop();
              break;
            case ScreenStatus.loading:
              break;
            case ScreenStatus.success:
              Navigator.of(context).pushNamed('/veterinarian_question_detail_screen');
              break;
            case ScreenStatus.failure:
              if (state.statusCode == 'SCTY-2002') Logout.logout(context);
              customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
              break;
            default:
          }
        },
        builder: (context, state) {
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
                      PetQuestionCard(
                        question: veterinarianQuestionFilterDto.problem,
                        detail: veterinarianQuestionFilterDto.description,
                        photoPath: veterinarianQuestionFilterDto.photoPath,
                        petName: veterinarianQuestionFilterDto.petName,
                        postedDate: veterinarianQuestionFilterDto.postedDate,
                        buttonText: 'Responder',
                        buttonVisible: true,
                        onPressed: () => veterinarianQuestionFilterDto.questionId == state.questionId
                            ? Navigator.of(context).pushNamed('/veterinarian_question_detail_screen')
                            : questionFilterCubit.setQuestionId(veterinarianQuestionFilterDto.questionId),
                      ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationVeterinary(
        currentIndex: 1,
      ),
    );
  }
}
