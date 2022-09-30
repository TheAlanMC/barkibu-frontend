import 'package:barkibu/theme/app_theme.dart';
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
              children: const [
                _PetRegisterForm(),
                SizedBox(height: 40),
                CustomMaterialButton(text: 'Continuar'),
              ],
            ),
          ),
        ));
  }
}

class _PetRegisterForm extends StatelessWidget {
  const _PetRegisterForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
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
                    value: 1,
                    child: Text('Si'),
                  ),
                  DropdownMenuItem(
                    value: 0,
                    child: Text('No'),
                  ),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 30),
              //TODO: Add date picker
              const Text('Fecha de nacimiento*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
              const SizedBox(height: 10),
              const Text('01/01/2021'),
              const SizedBox(height: 30),
              const Text('Raza*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                value: 1, //formValues['role'],
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Mestizo'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('No mestizo'),
                  ),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
