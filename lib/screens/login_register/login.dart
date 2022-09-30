import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Iniciar Sesión'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CardContainer(
                    child: Column(
                  children: const [
                    Image(image: AssetImage('assets/barkibu_logo.png'), height: 100),
                    _LoginForm(),
                  ],
                )),
                const SizedBox(height: 20),
                const Text('¿No tienes una cuenta?'),
                const SizedBox(height: 20),
                const Text('¿Olvidaste tu contraseña?'),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Ingresar'),
                ),
              ],
            ),
          ),
        ));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Usuario'),
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
