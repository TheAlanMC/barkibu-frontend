import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  //TODO: clear form after login
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
          //TODO: routing
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              customShowDialog(context, 'Conectando...', 'Por favor espere', false);
              break;
            case ScreenStatus.success:
              customShowDialog(context, 'Éxito', 'Inicio de sesión exitoso', true);
              break;
            case ScreenStatus.failure:
              customShowDialog(context, 'Error', state.errorMessage ?? 'Error desconocido', true);
              break;
            default:
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CardContainer(
                  child: Column(
                    children: [
                      const Image(image: AssetImage('assets/barkibu_logo.png'), height: 100),
                      _loginForm(context),
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
                const SizedBox(height: 30),
                CustomMaterialButton(
                    text: 'Ingresar',
                    onPressed: () => BlocProvider.of<LoginCubit>(context).login(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
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
