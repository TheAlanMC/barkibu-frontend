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
  final _symptomController = TextEditingController();
  final _problemController = TextEditingController();
  final _detailedDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final questionFilterCubit = BlocProvider.of<QuestionFilterCubit>(context);
    final petInfoCubit = BlocProvider.of<PetInfoCubit>(context);
    final String? petName = petInfoCubit.state.pets?.firstWhere((element) => element.petId == petInfoCubit.state.petId).name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva consulta para $petName'),
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
                title: '??XITO',
                message: 'Su consulta ha sido registrada exitosamente',
                onPressed: () => Navigator.popAndPushNamed(context, '/pet_owner_own_question'),
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
                  CustomMaterialButton(
                    text: 'Cancelar',
                    cancel: true,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 20),
                  CustomMaterialButton(
                      text: 'Publicar',
                      onPressed: () => questionFilterCubit.registerQuestion(
                            petId: petInfoCubit.state.petId!,
                            problem: _problemController.text,
                            detailedDescription: _detailedDescriptionController.text,
                          )),
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
        TextFormField(
          decoration: const InputDecoration(labelText: 'Problema'),
          controller: _problemController,
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Descripcion detallada del problema'),
          maxLines: 3,
          controller: _detailedDescriptionController,
        ),
        const SizedBox(height: 20),
        CustomDropDownButtonFormField(
          list: DropDownMenu.getSymptoms(state.symptom),
          label: 'S??ntoma',
          onChanged: (value) {
            BlocProvider.of<QuestionFilterCubit>(context).changeSymptomId(value);
          },
          initialValue: 0,
        ),
        const SizedBox(height: 20),
        CustomIconButton(
          icon: Icons.add,
          onPressed: () {
            BlocProvider.of<QuestionFilterCubit>(context).addSymptom();
            _symptomController.text = DropDownMenu.getSymptomsList(state.symptom, state.symptoms);
          },
          text: 'Agregar s??ntoma',
        ),
        CustomIconButton(
          icon: Icons.delete,
          onPressed: () {
            BlocProvider.of<QuestionFilterCubit>(context).deleteSymptom();
            _symptomController.text = DropDownMenu.getSymptomsList(state.symptom, state.symptoms);
          },
          text: 'Eliminar s??ntoma',
        ),
        TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(labelText: 'S??ntomas'),
          maxLines: 3,
          enabled: false,
          controller: _symptomController,
        ),
        const SizedBox(height: 20),
        CustomDropDownButtonFormField(
          list: DropDownMenu.getCategories(state.categories),
          label: 'Categor??a',
          onChanged: (value) {
            BlocProvider.of<QuestionFilterCubit>(context).changeCategoryId(value);
          },
          initialValue: 0,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
