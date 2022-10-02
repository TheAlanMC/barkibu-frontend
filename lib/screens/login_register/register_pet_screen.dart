import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterPetScreen extends StatelessWidget {
  const RegisterPetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro Mascota'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _petRegisterForm(context),
                const SizedBox(height: 40),
                CustomMaterialButton(
                  text: 'Continuar',
                  onPressed: (() => Navigator.of(context).pushReplacementNamed('/register_pet_vaccine_screen')),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ));
  }

  Widget _petRegisterForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'Nombre*'),
              onChanged: (value) {},
            ),
            const SizedBox(height: 30),
            const Text('Especie*', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 10),
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
            const SizedBox(height: 30),
            const Text('Sexo*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
            const SizedBox(height: 10),
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
            const SizedBox(height: 30),
            const Text('Castrado*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: 0,
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text('No'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('Si'),
                ),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 30),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Fecha de nacimiento*', suffixIcon: Icon(Icons.calendar_today)),
              onTap: () async {
                String? date = await selectDate(context);
                print(date);
              },
            ),
            const SizedBox(height: 30),
            const Text('Raza*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
            const SizedBox(height: 10),
            _dogBreeds(),
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<int> _dogBreeds() {
    return DropdownButtonFormField(
      value: 1, //formValues['role'],
      items: const [
        //TODO: Get breeds from API
        DropdownMenuItem(
          value: 1,
          child: Text('Mestizo de menos de 5 kg'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Mestizo de 5 a 10 kg'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Mestizo de 10 a 20 kg'),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('Mestizo de 20 a 40 kg'),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text('Mestizo de más de 40 kg'),
        ),
        DropdownMenuItem(
          value: 6,
          child: Text('Pastor Alemán'),
        ),
        DropdownMenuItem(
          value: 7,
          child: Text('Bulldog'),
        ),
        DropdownMenuItem(
          value: 8,
          child: Text('Labrador'),
        ),
        DropdownMenuItem(
          value: 9,
          child: Text('Beagle'),
        ),
        DropdownMenuItem(
          value: 10,
          child: Text('Pitbull'),
        ),
        DropdownMenuItem(
          value: 11,
          child: Text('Golden Retriever'),
        ),
        DropdownMenuItem(
          value: 12,
          child: Text('Rottweiler'),
        ),
        DropdownMenuItem(
          value: 13,
          child: Text('Chihuahua'),
        ),
        DropdownMenuItem(
          value: 14,
          child: Text('Dálmata'),
        ),
      ],
      onChanged: (value) {},
    );
  }
}
