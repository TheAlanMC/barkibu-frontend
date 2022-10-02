import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PasswordRecoverScreen2 extends StatelessWidget {
  const PasswordRecoverScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Se le envió un código al correo electrónico ingresado, por favor introduzca el mismo para reestablecer su contraseña.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CardContainer(child: _buildForm())),
                        const SizedBox(height: 20),
                        CustomMaterialButton(
                          text: 'Enviar',
                          onPressed: () => Navigator.of(context).pushNamed('/password_recover_screen3'),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Código de verificación'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese el código de verificación';
          }
          return null;
        },
      ),
    );
  }
}
