import 'package:barkibu/cubit/cubit.dart';
import 'package:flutter/material.dart';

import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPetScreen extends StatelessWidget {
  const RegisterPetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Mascota'),
      ),
      //TODO: Validate no empty fields
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                  child: _petRegisterForm(context),
                ),
                const SizedBox(height: 30),
                CustomMaterialButton(
                  text: 'Continuar',
                  onPressed: (() => Navigator.of(context).pushNamed('/register_pet_vaccine_screen')),
                ),
                const SizedBox(height: 40),
              ],
            ),
          )
        ],
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
                  onChanged: (value) {
                    context.read<RegisterPetCubit>().nameChanged(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                const Text('Especie*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Perro'),
                        value: state.specie == 'Perro' ? true : false,
                        onChanged: (value) {
                          if (value == true) {
                            BlocProvider.of<RegisterPetCubit>(context).changeSpecie('Perro');
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Gato'),
                        value: state.specie == 'Gato' ? true : false,
                        onChanged: (value) {
                          if (value == true) {
                            BlocProvider.of<RegisterPetCubit>(context).changeSpecie('Gato');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const Text('Sexo*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Macho'),
                        value: state.gender == 'Macho' ? true : false,
                        onChanged: (value) {
                          if (value == true) {
                            BlocProvider.of<RegisterPetCubit>(context).changeGender('Macho');
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Hembra'),
                        value: state.gender == 'Hembra' ? true : false,
                        onChanged: (value) {
                          if (value == true) {
                            BlocProvider.of<RegisterPetCubit>(context).changeGender('Hembra');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                CustomDropDownButtonFormField(
                  list: const ['No', 'Si'],
                  label: 'Castrado*',
                  onChanged: (value) {
                    BlocProvider.of<RegisterPetCubit>(context).changeCastrated(value);
                  },
                ),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: state.bornDate ?? currentDate()),
                  decoration: const InputDecoration(labelText: 'Fecha de nacimiento*', suffixIcon: Icon(Icons.calendar_today)),
                  onTap: () async {
                    String? date = await selectDate(context);
                    if (date != '') {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<RegisterPetCubit>(context).changeBornDate(date);
                    }
                  },
                ),
                CustomDropDownButtonFormField(
                  list: _dogBreeds(),
                  initialValue: 1,
                  label: 'Raza*',
                  onChanged: (value) {
                    BlocProvider.of<RegisterPetCubit>(context).changeBreed(value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> _dogBreeds() {
    List<String> breeds = [
      'Meztizo de menos de 5 kg',
      'Mestizo de 5 a 10 kg',
      'Mestizo de 10 a 20 kg',
      'Mestizo de 20 a 40 kg',
      'Mestizo de más de 40 kg',
      'Pastor Alemán',
      'Bulldog',
      'Labrador',
      'Beagle',
      'Pitbull',
      'Golden Retriever',
      'Rottweiler',
      'Chihuahua',
      'Dálmata'
    ];
    return breeds;
  }
}
