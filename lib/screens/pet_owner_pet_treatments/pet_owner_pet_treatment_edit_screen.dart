import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/pet_treatment_dto.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetOwnerPetTreatmentEditScreen extends StatelessWidget {
  PetOwnerPetTreatmentEditScreen({Key? key}) : super(key: key);
  final _treatmentNextDateController = TextEditingController();
  final _treatmentLastDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final petTreatmentCubit = BlocProvider.of<PetTreatmentCubit>(context);
    final petInfoCubit = BlocProvider.of<PetInfoCubit>(context);
    final PetTreatmentDto petTreatment =
        petTreatmentCubit.state.petTreatments!.firstWhere((element) => element.petTreatmentId == petTreatmentCubit.state.petTreatmentId);
    _treatmentNextDateController.text = DateUtil.dateTimeToString(petTreatment.treatmentNextDate);
    _treatmentLastDateController.text = DateUtil.dateTimeToString(petTreatment.treatmentLastDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar tratamiento'),
        centerTitle: true,
      ),
      body: BlocConsumer<PetTreatmentCubit, PetTreatmentState>(listener: (context, state) async {
        switch (state.status) {
          case ScreenStatus.loading:
            customShowDialog(context: context, title: 'Conectando...', message: 'Por favor espere', isDismissible: false);
            break;
          case ScreenStatus.success:
            await customShowDialog(
              context: context,
              title: 'ÉXITO',
              message: 'Tratamiento editado exitosamente',
              onPressed: () => SkipAnimation.pushAndRemoveUntil(context, '/pet_owner_pet_treatment_screen'),
              textButton: "Aceptar",
            );

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
                children: [
                  Expanded(
                    child: CardContainer(
                      child: Column(
                        children: [
                          Expanded(child: _treatmentRegisterForm(context, state, petTreatment)),
                        ],
                      ),
                    ),
                  ),
                  CardContainer(
                      child: CustomTextButton(icon: Icons.delete_forever, text: 'Eliminar tratamiento', color: AppTheme.alert, onPressed: (() {}))),
                  //   onPressed: () => petTreatmentCubit.deleteTreatment(petTreatmentId: petTreatment.petTreatmentId),
                  // )),

                  CustomMaterialButton(text: 'Cancelar', cancel: true, onPressed: () => Navigator.of(context).pop()),
                  const SizedBox(height: 20),
                  CustomMaterialButton(
                    text: 'Guardar',
                    onPressed: () {
                      petTreatmentCubit.updatePetTreatment(
                          petTreatmentId: petTreatment.petTreatmentId,
                          petId: petInfoCubit.state.petId!,
                          treatmentLastDate: _treatmentLastDateController.text,
                          treatmentNextDate: _treatmentNextDateController.text);
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 1,
      ),
    );
  }

  Widget _treatmentRegisterForm(BuildContext context, PetTreatmentState state, PetTreatmentDto petTreatment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomDropDownButtonFormField(
              list: DropDownMenu.getTreatment(state.treatments!),
              label: 'Tratamiento*',
              onChanged: (value) {
                BlocProvider.of<PetTreatmentCubit>(context).changeTreatmentId(value);
              },
              initialValue: petTreatment.treatmentId,
            ),
            Text(state.treatmentDescription!, style: const TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            if (petTreatment.treatmentNextDate.isBefore(DateTime.now()))
              TextFormField(
                readOnly: true,
                controller: _treatmentNextDateController,
                decoration: const InputDecoration(labelText: 'Fecha del proximo tratamiento*', suffixIcon: Icon(Icons.calendar_today)),
                onTap: () async {
                  _treatmentNextDateController.text =
                      await DateUtil.selectDate(context, limitFinalDate: true, initialDate: petTreatment.treatmentNextDate) ??
                          _treatmentNextDateController.text;
                },
              )
            else
              TextFormField(
                readOnly: true,
                controller: _treatmentNextDateController,
                decoration: const InputDecoration(labelText: 'Fecha del proximo tratamiento*', suffixIcon: Icon(Icons.calendar_today)),
                onTap: () async {
                  _treatmentNextDateController.text = await DateUtil.selectDate(context,
                          limitInitialDate: true, limitFinalDate: false, initialDate: petTreatment.treatmentNextDate) ??
                      _treatmentNextDateController.text;
                },
              ),
            if (petTreatment.treatmentNextDate.isBefore(DateTime.now()))
              TextFormField(
                readOnly: true,
                controller: _treatmentLastDateController,
                decoration: const InputDecoration(labelText: 'Fecha del último tratamiento*', suffixIcon: Icon(Icons.calendar_today)),
                onTap: () async {
                  _treatmentLastDateController.text =
                      await DateUtil.selectDate(context, limitFinalDate: true, initialDate: petTreatment.treatmentLastDate) ??
                          _treatmentLastDateController.text;
                },
              )
            else
              TextFormField(
                readOnly: true,
                controller: _treatmentLastDateController,
                decoration: const InputDecoration(labelText: 'Fecha del último tratamiento*', suffixIcon: Icon(Icons.calendar_today)),
                onTap: () async {
                  _treatmentLastDateController.text =
                      await DateUtil.selectDate(context, limitFinalDate: true, initialDate: petTreatment.treatmentLastDate) ??
                          _treatmentLastDateController.text;
                },
              ),
          ],
        ),
      ),
    );
  }
}
