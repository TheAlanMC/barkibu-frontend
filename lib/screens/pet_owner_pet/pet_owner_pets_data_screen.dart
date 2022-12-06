import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PetOwnerPetsDataScreen extends StatelessWidget {
  const PetOwnerPetsDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petCubit = BlocProvider.of<PetCubit>(context);
    final petInfoCubit = BlocProvider.of<PetInfoCubit>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: petCubit.getPet(petInfoCubit.state.petId!),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (petCubit.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                return _PetOwnerPetsData();
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

class _PetOwnerPetsData extends StatelessWidget {
  _PetOwnerPetsData({Key? key}) : super(key: key);
  final _petNameController = TextEditingController();
  final _petChipNumberController = TextEditingController();
  final _petBornDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final petCubit = BlocProvider.of<PetCubit>(context);
    _petNameController.text = petCubit.state.pet!.name;
    _petChipNumberController.text = petCubit.state.pet!.chipNumber ?? '';
    _petBornDateController.text = DateUtil.getSpanishDate(petCubit.state.pet!.bornDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de la mascota'),
        centerTitle: true,
      ),
      body: BlocConsumer<PetCubit, PetState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              customShowDialog(context: context, title: 'Conectando...', message: 'Por favor espere', isDismissible: false);
              break;
            case ScreenStatus.success:
              String message = state.result == 'Pet Deleted' ? 'Mascota eliminada correctamente' : 'Mascota actualizada correctamente';
              await customShowDialog(
                context: context,
                title: 'ÉXITO',
                message: message,
                textButton: "Aceptar",
                onPressed: () => SkipAnimation.pushAndRemoveUntil(context, '/pet_owner_pet_info_screen'),
              );
              break;
            case ScreenStatus.failure:
              if (state.statusCode == 'SCTY-2002') Logout.logout(context);
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
                            Expanded(child: _petRegisterForm(context, state)),
                          ],
                        ),
                      ),
                    ),
                    CustomMaterialButton(
                      text: 'Cancelar',
                      cancel: true,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 10),
                    CustomMaterialButton(
                      text: 'Guardar',
                      onPressed: () => petCubit.updatePet(
                        petId: petCubit.state.petId!,
                        name: _petNameController.text,
                        bornDate: _petBornDateController.text,
                        chipNumber: _petChipNumberController.text == '' ? null : _petChipNumberController.text,
                      ),
                    ),
                    CardContainer(
                      child: CustomTextButton(
                          icon: Icons.delete_forever,
                          text: 'Eliminar mascota',
                          color: AppTheme.alert,
                          onPressed: () => petCubit.deletePet(petId: petCubit.state.petId!)),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 0,
      ),
    );
  }

  Widget _petRegisterForm(BuildContext context, PetState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomCircleAvatar(
                  photoPath: state.photoPath ?? 'assets/default_pet.jpg',
                  size: 75,
                ),
                Positioned(
                  bottom: 0,
                  right: -25,
                  child: RawMaterialButton(
                    onPressed: () {
                      final picker = ImagePicker();
                      picker.pickImage(source: ImageSource.camera, imageQuality: 10).then((value) {
                        if (value == null) return;
                        BlocProvider.of<PetCubit>(context).changeImage(value.path);
                      });
                    },
                    elevation: 2.0,
                    fillColor: AppTheme.background,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(5.0),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppTheme.primary,
                      size: 30.0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: -25,
                  child: RawMaterialButton(
                    onPressed: () {
                      final picker = ImagePicker();
                      picker.pickImage(source: ImageSource.gallery, imageQuality: 10).then(
                        (value) {
                          if (value == null) return;
                          BlocProvider.of<PetCubit>(context).changeImage(value.path);
                        },
                      );
                    },
                    elevation: 2.0,
                    fillColor: AppTheme.background,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(5.0),
                    child: const Icon(
                      Icons.image_outlined,
                      color: AppTheme.primary,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
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
                BlocProvider.of<PetCubit>(context).changeSpecieValue(value);
              },
              initialValue: state.specieId ?? 0,
            ),
            CustomDropDownButtonFormField(
              list: DropDownMenu.getBreeds(state.breeds, state.specieId),
              label: 'Raza*',
              onChanged: (value) {
                BlocProvider.of<PetCubit>(context).changeBreedValue(value);
              },
              initialValue: state.breedId,
            ),
            CustomDropDownButtonFormField(
              list: Map<int, String>.from({0: 'Macho', 1: 'Hembra'}),
              label: 'Género*',
              onChanged: (value) {
                BlocProvider.of<PetCubit>(context).changeGender(value);
              },
              initialValue: 0,
            ),
            CustomDropDownButtonFormField(
              list: Map<int, String>.from({0: 'No', 1: 'Si'}),
              label: 'Castrado*',
              onChanged: (value) {
                BlocProvider.of<PetCubit>(context).changeCastrated(value);
              },
              initialValue: 0,
            ),
            TextFormField(
              readOnly: true,
              controller: _petBornDateController,
              decoration: const InputDecoration(labelText: 'Fecha de nacimiento*', suffixIcon: Icon(Icons.calendar_today)),
              onTap: () async {
                _petBornDateController.text = await DateUtil.selectDate(context) ?? _petBornDateController.text;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'Número de chip'),
              controller: _petChipNumberController,
            ),
          ],
        ),
      ),
    );
  }
}
