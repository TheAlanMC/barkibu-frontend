import 'package:flutter/material.dart';

import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';

class RegisterPetScreen extends StatelessWidget {
  const RegisterPetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Mascota'),
      ),
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
              onChanged: (value) {},
            ),
            const Text('Especie*', style: TextStyle(fontSize: 16, color: Colors.grey)),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Perro'),
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Gato'),
                    value: false,
                    onChanged: (value) {},
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
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Hembra'),
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            CustomDropDownButtonFormField(
              list: const ['No', 'Si'],
              label: 'Castrado*',
              onChanged: (value) {
                print(value);
              },
            ),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Fecha de nacimiento*', suffixIcon: Icon(Icons.calendar_today)),
              onTap: () async {
                String? date = await selectDate(context);
                print(date);
              },
            ),
            CustomDropDownButtonFormField(
              list: _dogBreeds(),
              initialValue: 1,
              label: 'Raza*',
              onChanged: (value) {
                print(value);
              },
            ),
          ],
        ),
      ),
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
