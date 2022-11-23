import 'package:barkibu/cubit/cubit.dart';
import 'package:flutter/material.dart';

import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetOwnerRegisterPetScreen extends StatelessWidget {
  const PetOwnerRegisterPetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerPetCubit = BlocProvider.of<RegisterPetCubit>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: registerPetCubit.getSpeciesAndBreeds(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (registerPetCubit.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                return _PetOwnerRegisterPet();
              case ScreenStatus.failure:
                Future.microtask(() {
                  Logout.logout(context);
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

class _PetOwnerRegisterPet extends StatelessWidget {
  _PetOwnerRegisterPet({Key? key}) : super(key: key);
  final _petNameController = TextEditingController();
  final _petChipNumberController = TextEditingController();
  final _petBornDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final registerPetCubit = BlocProvider.of<RegisterPetCubit>(context);
    _petBornDateController.text = registerPetCubit.state.bornDate ?? DateUtil.currentDate();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Mascota'),
        centerTitle: true,
      ),
      body: BlocConsumer<RegisterPetCubit, RegisterPetState>(
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
                message: 'Mascota registrada exitosamente',
                textButton: "Aceptar",
                onPressed: () => Navigator.of(context).popAndPushNamed('/pet_owner_pet_info_screen'),
              );
              break;
            case ScreenStatus.failure:
              customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
              break;
            default:
          }
        },
        builder: (context, state) {
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
                            Expanded(child: _petRegisterForm(context)),
                          ],
                        ),
                      ),
                    ),
                    CustomMaterialButton(
                      text: 'Cancelar',
                      cancel: true,
                      onPressed: () => Logout.logout(context),
                    ),
                    const SizedBox(height: 10),
                    CustomMaterialButton(
                      text: 'Guardar',
                      onPressed: () => registerPetCubit.registerPet(
                        name: _petNameController.text,
                        chipNumber: _petChipNumberController.text == '' ? null : _petChipNumberController.text,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _petRegisterForm(BuildContext context) {
    return BlocBuilder<RegisterPetCubit, RegisterPetState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  autocorrect: false,
                  decoration: const InputDecoration(labelText: 'Nombre*'),
                  controller: _petNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                CustomDropDownButtonFormField(
                  list: DropDownMenu.getSpecies(state.species),
                  label: 'Especie*',
                  onChanged: (value) {
                    BlocProvider.of<RegisterPetCubit>(context).changeSpecieValue(value);
                  },
                  initialValue: 0,
                ),
                CustomDropDownButtonFormField(
                  list: DropDownMenu.getBreeds(state.breeds, state.specieId),
                  label: 'Raza*',
                  onChanged: (value) {
                    BlocProvider.of<RegisterPetCubit>(context).changeBreedValue(value);
                  },
                  initialValue: 0,
                ),
                CustomDropDownButtonFormField(
                  list: Map<int, String>.from({0: 'Macho', 1: 'Hembra'}),
                  label: 'Género*',
                  onChanged: (value) {
                    BlocProvider.of<RegisterPetCubit>(context).changeGender(value);
                  },
                  initialValue: 0,
                ),
                CustomDropDownButtonFormField(
                  list: Map<int, String>.from({0: 'No', 1: 'Si'}),
                  label: 'Castrado*',
                  onChanged: (value) {
                    BlocProvider.of<RegisterPetCubit>(context).changeCastrated(value);
                  },
                  initialValue: 0,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _petBornDateController,
                  decoration: const InputDecoration(labelText: 'Fecha de nacimiento*', suffixIcon: Icon(Icons.calendar_today)),
                  onTap: () async {
                    String? date = await DateUtil.selectDate(context);
                    if (date != '') {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<RegisterPetCubit>(context).changeBornDate(date);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
