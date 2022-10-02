import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/custom_show_dialog.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          switch (state.status) {
            case PageStatus.initial:
              break;
            case PageStatus.loading:
              customShowDialog(context, 'Conectando...', 'Por favor espere', false);
              break;
            case PageStatus.success:
              customShowDialog(context, 'Éxito', 'Inicio de sesión exitoso', true);
              break;
            case PageStatus.failure:
              customShowDialog(context, 'Error', state.errorMessage ?? 'Error desconocido', true);
              break;
            default:
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CardContainer(
                  child: Column(
                    children: [
                      const Image(image: AssetImage('assets/barkibu_logo.png'), height: 100),
                      _loginForm(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CardContainer(
                    child: Column(
                  children: [
                    CustomTextButton(
                        icon: Icons.login,
                        text: '¿No tienes cuenta? Regístrate',
                        onPressed: () => Navigator.of(context).pushNamed('/register_user_screen')),
                    CustomTextButton(
                      icon: Icons.key,
                      text: '¿Olvidaste tu contraseña?',
                      onPressed: () {},
                    ),
                  ],
                )),
                const SizedBox(height: 40),
                CustomMaterialButton(
                    text: 'Ingresar',
                    onPressed: () => BlocProvider.of<LoginCubit>(context).login(_usernameController.text, _passwordController.text)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Usuario'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un usuario';
              }
              return null;
            },
            controller: _usernameController,
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una contraseña';
              }
              return null;
            },
            controller: _passwordController,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
