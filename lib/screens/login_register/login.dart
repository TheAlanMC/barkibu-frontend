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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              customShowDialog(context: context, title: 'Conectando...', message: 'Por favor espere', isDismissible: false);
              break;
            case ScreenStatus.success:
              await loginCubit.getGroups();
              Function onPressed;
              if (state.groups.contains('ADMINISTRADOR') || (state.groups.contains('DUEÑO DE MASCOTA') && state.groups.contains('VETERINARIO'))) {
                await customAdminShowDialog(context: context);
              } else {
                if (state.groups.contains('DUEÑO DE MASCOTA')) {
                  onPressed = () => Navigator.of(context).pushNamed('/pet_owner_pet_screen');
                } else {
                  onPressed = () => Navigator.of(context).popAndPushNamed('/check_veterinarian_screen');
                }
                await customShowDialog(
                  context: context,
                  title: 'ÉXITO',
                  message: 'Inicio de sesión exitoso',
                  onPressed: onPressed,
                  textButton: "Aceptar",
                );
              }
              _resetControllers();
              break;
            case ScreenStatus.failure:
              customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
              break;
            default:
          }
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

  void _resetControllers() {
    _usernameController.clear();
    _passwordController.clear();
  }
}
