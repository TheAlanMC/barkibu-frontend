import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterPetVaccineScreen extends StatelessWidget {
  const RegisterPetVaccineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vacunas'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _petRegisterForm(context),
                const SizedBox(height: 20),
                CustomMaterialButton(
                  cancel: true,
                  text: 'Cancelar',
                  onPressed: (() => Navigator.of(context).popUntil((route) => route.isFirst)),
                ),
                const SizedBox(height: 10),
                CustomMaterialButton(
                  text: 'Guardar',
                  onPressed: (() => Navigator.of(context).popUntil((route) => route.isFirst)),
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
            const Text('Si su mascota no cuenta con alguna vacuna, deje el campo en blanco.',
                style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
            const Divider(),
            const SizedBox(height: 20),
            const Text('¿Cuándo vacunaste a trueno de la rabia por última vez?'),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: '', suffixIcon: Icon(Icons.calendar_today)),
              onTap: () async {
                String? date = await selectDate(context);
                print(date);
              },
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            const Text('¿Cuándo vacunaste a trueno de la polivalente por última vez?'),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: '', suffixIcon: Icon(Icons.calendar_today)),
              onTap: () async {
                String? date = await selectDate(context);
                print(date);
              },
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            const Text('¿Cuándo fue la última desparasitación interna de trueno?'),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: '', suffixIcon: Icon(Icons.calendar_today)),
              onTap: () async {
                String? date = await selectDate(context);
                print(date);
              },
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            const Text('Queremos ver esos bigotes'),
            const SizedBox(height: 10),
            Row(
              children: [
                const Image(
                  image: AssetImage('assets/no-image.png'),
                  width: 150,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  //TODO: Implement functionality
                  child: Column(
                    children: const [
                      CustomIconButton(
                        icon: Icons.camera_alt,
                        text: 'Tomar foto',
                      ),
                      CustomIconButton(
                        icon: Icons.photo,
                        text: 'Seleccionar foto',
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
  }
}
