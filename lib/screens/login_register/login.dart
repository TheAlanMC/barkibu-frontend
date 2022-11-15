import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    resetControllers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              customShowDialog(context, 'Conectando...', 'Por favor espere', false);
              break;
            case ScreenStatus.success:
              customShowDialog(context, 'Éxito', 'Inicio de sesión exitoso', true);
              Navigator.of(context).pop();
              // TODO: IDENTIFY IF USER IS PET OWNER, VET OR ADMIN
              Navigator.of(context).pushNamed('/pet_owner_pet_screen');
              break;
            case ScreenStatus.failure:
              customShowDialog(context, 'ERROR ${state.statusCode}', state.errorDetail ?? 'Error desconocido', true);
              break;
            default:
          }
          loginCubit.reset();
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardContainer(
                    child: Column(
                      children: [
                        const Image(image: AssetImage('assets/barkibu_logo.png'), height: 120),
                        _loginForm(context),
                      ],
                    ),
                  ),
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
                        onPressed: () => Navigator.of(context).pushNamed('/password_recover_screen1'),
                      ),
                    ],
                  )),
                  const SizedBox(height: 20),
                  CustomMaterialButton(
                      text: 'Ingresar',
                      onPressed: () {
                        loginCubit.login(
                          userName: _usernameController.text,
                          password: _passwordController.text,
                        );
                      }),
                  const SizedBox(height: 40),
                  //TODO: remove this button
                  CustomMaterialButton(
                    text: 'Ir a veterinario',
                    onPressed: () => Navigator.of(context).pushNamed('/veterinary_profile_screen'),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
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
          ],
        ),
      ),
    );
  }

  void resetControllers() {
    _usernameController.clear();
    _passwordController.clear();
  }
}
