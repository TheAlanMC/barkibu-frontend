import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerRegisterQuestionScreen extends StatelessWidget {
  const OwnerRegisterQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionFilterCubit = BlocProvider.of<QuestionFilterCubit>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: questionFilterCubit.getFilters(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (questionFilterCubit.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                return _OwnerRegisterQuestion();
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

class _OwnerRegisterQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questionFilterCubit = BlocProvider.of<QuestionFilterCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva consulta'),
        centerTitle: true,
      ),
      body: BlocConsumer<QuestionFilterCubit, QuestionFilterState>(listener: (context, state) async {
        switch (state.status) {
          case ScreenStatus.initial:
            break;
          case ScreenStatus.loading:
            customShowDialog(context: context, title: 'Conectando...', message: 'Por favor espere', isDismissible: false);
            break;
          case ScreenStatus.success:
            if (state.questionId == 0) {
              await customShowDialog(
                context: context,
                title: 'ÉXITO',
                message: 'A continuación se muestran las preguntas',
                onPressed: () => Navigator.of(context).pushNamed('/pet_owner_question_filter'),
                textButton: "Aceptar",
              );
            }
            break;
          case ScreenStatus.failure:
            if (state.statusCode == 'SCTY-2002') Logout.logout(context);
            customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
            break;
          default:
        }
      }, builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardContainer(child: _questionForm(context, state)),
                  const SizedBox(height: 20),
                  CustomMaterialButton(text: 'Publicar', onPressed: () => questionFilterCubit.getQuestionsOwner()),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 2,
      ),
    );
  }

  Widget _questionForm(BuildContext context, QuestionFilterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(child: Text('Nueva consulta:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(labelText: 'Problema'),
          onChanged: (value) {
            BlocProvider.of<QuestionFilterCubit>(context).changeKeyWord(value);
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(labelText: 'Descripcion detallada del problema'),
          maxLines: 6,
          onChanged: (value) {
            BlocProvider.of<QuestionFilterCubit>(context).changeKeyWord(value);
          },
        ),
        const SizedBox(height: 20),
        CustomDropDownButtonFormField(
          list: DropDownMenu.getSymptomFilter(state.symptom),
          label: 'Sintoma',
          onChanged: (value) {
            BlocProvider.of<QuestionFilterCubit>(context).changeCategory(value);
          },
          initialValue: 0,
        ),
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(labelText: 'Sintomas'),
          maxLines: 6,
          onChanged: (value) {
            BlocProvider.of<QuestionFilterCubit>(context).changeKeyWord(value);
          },
        ),
        const SizedBox(height: 20),
        CustomDropDownButtonFormField(
          list: DropDownMenu.getCategoriesFilter(state.categories),
          label: 'Categoría',
          onChanged: (value) {
            BlocProvider.of<QuestionFilterCubit>(context).changeCategory(value);
          },
          initialValue: 0,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
