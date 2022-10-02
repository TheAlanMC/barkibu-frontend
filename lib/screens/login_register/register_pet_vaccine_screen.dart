import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPetVaccineScreen extends StatelessWidget {
  const RegisterPetVaccineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vacunas'),
      ),
      body: BlocListener<RegisterPetCubit, RegisterPetState>(
        listener: (context, state) {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              customShowDialog(context, 'Conectando...', 'Por favor espere', false);
              break;
            case ScreenStatus.success:
              // customShowDialog(context, 'Éxito', 'Registro exitoso', true);
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
              break;
            case ScreenStatus.failure:
              customShowDialog(context, 'Error', state.errorMessage ?? 'Error desconocido', true);
              break;
            default:
          }
        },
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(child: _petRegisterForm(context)),
                CustomMaterialButton(
                  cancel: true,
                  text: 'Cancelar',
                  onPressed: (() => Navigator.of(context).popUntil((route) => route.isFirst)),
                ),
                const SizedBox(height: 30),
                CustomMaterialButton(
                  text: 'Guardar',
                  //TODO: improve form sending data and validation
                  onPressed: () => BlocProvider.of<RegisterPetCubit>(context).registerPet(name: 'Trueno'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ]),
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
                const Text('Si su mascota no cuenta con alguna vacuna, deje el campo en blanco.',
                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                const Divider(),
                Text('¿Cuándo vacunaste a ${state.name} de la rabia por última vez?'),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: state.lastRabiesVaccineDate),
                  decoration: const InputDecoration(labelText: '', suffixIcon: Icon(Icons.calendar_today)),
                  onTap: () async {
                    String? date = await selectDate(context);
                    if (date != '') {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<RegisterPetCubit>(context).changeLastRabiesVaccineDate(date);
                    }
                  },
                ),
                const Divider(),
                Text('¿Cuándo vacunaste a ${state.name} de la polivalente por última vez?'),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: state.lastPolyvalentVaccineDate),
                  decoration: const InputDecoration(labelText: '', suffixIcon: Icon(Icons.calendar_today)),
                  onTap: () async {
                    String? date = await selectDate(context);
                    if (date != '') {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<RegisterPetCubit>(context).changeLastPolyvalentVaccineDate(date);
                    }
                  },
                ),
                const Divider(),
                Text('¿Cuándo fue la última desparasitación interna de ${state.name}?'),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: state.lastDewormingDate),
                  decoration: const InputDecoration(labelText: '', suffixIcon: Icon(Icons.calendar_today)),
                  onTap: () async {
                    String? date = await selectDate(context);
                    if (date != '') {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<RegisterPetCubit>(context).changeLastDewormingDate(date);
                    }
                  },
                ),
                const Divider(),
                const Text('Queremos ver esos bigotes'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    PetImage(
                      imagePath: state.photoPath,
                    ),
                    // const Image(
                    //   image: AssetImage('assets/no-image.png'),
                    //   width: 150,
                    //   fit: BoxFit.cover,
                    // ),
                    Expanded(
                      child: Column(
                        children: [
                          CustomIconButton(
                            icon: Icons.camera_alt,
                            text: 'Tomar foto',
                            onPressed: () {
                              final picker = ImagePicker();
                              picker.pickImage(source: ImageSource.camera, imageQuality: 100).then((value) {
                                if (value == null) return;
                                BlocProvider.of<RegisterPetCubit>(context).changeImage(value.path);
                              });
                            },
                          ),
                          CustomIconButton(
                            icon: Icons.photo,
                            text: 'Seleccionar foto',
                            onPressed: () {
                              final picker = ImagePicker();
                              picker.pickImage(source: ImageSource.gallery, imageQuality: 100).then((value) {
                                if (value == null) return;
                                BlocProvider.of<RegisterPetCubit>(context).changeImage(value.path);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
