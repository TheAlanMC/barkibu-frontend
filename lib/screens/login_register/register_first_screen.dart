import 'package:flutter/material.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:password_strength/password_strength.dart';

class RegisterFirstScreen extends StatelessWidget {
  const RegisterFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
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
                      _UserRegisterForm(),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const CustomMaterialButton(text: 'Registrarse'),
              ],
            ),
          ),
        ));
  }
}

class _UserRegisterForm extends StatelessWidget {
  const _UserRegisterForm();

  @override
  Widget build(BuildContext context) {
    String password = '';
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Nombre*'),
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Apellido*'),
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Correo electrónico*'),
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña*'),
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Confirmar contraseña*'),
            onChanged: (value) {
              password = value;
            },
          ),
          const SizedBox(height: 45),
          _PasswordStrengthIndicator(password: password),
        ],
      ),
    );
  }
}

class _PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const _PasswordStrengthIndicator({Key? key, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strength = estimatePasswordStrength(password);
    return Column(
      children: [
        LinearProgressIndicator(
          value: strength,
          valueColor: AlwaysStoppedAnimation<Color>(strengthColor(strength)),
        ),
        const SizedBox(height: 10),
        Text(
          strengthText(strength),
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Color strengthColor(double strength) {
    if (strength < 0.3) {
      return Colors.red;
    } else if (strength < 0.6) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String strengthText(double strength) {
    if (strength < 0.3) {
      return 'Muy débil';
    } else if (strength < 0.7) {
      return 'Débil';
    } else {
      return 'Fuerte';
    }
  }
}
