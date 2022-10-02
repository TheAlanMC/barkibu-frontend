import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PasswordRecoverScreen1 extends StatelessWidget {
  const PasswordRecoverScreen1({Key? key}) : super(key: key);

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
                    'Llene el siguiente campo para solicitar un código que le permitirá reestablecer su contraseña.',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                          onPressed: () => Navigator.of(context).pushNamed('/password_recover_screen2'),
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
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Correo electrónico'),
        validator: (value) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su correo electrónico';
          } else if (!regExp.hasMatch(value)) {
            return 'Por favor ingrese un correo electrónico válido';
          }
          return null;
        },
      ),
    );
  }
}
