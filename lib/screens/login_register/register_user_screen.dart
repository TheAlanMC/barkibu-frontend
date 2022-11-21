import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserScreen extends StatelessWidget {
  RegisterUserScreen({Key? key}) : super(key: key);
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController(text: '');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerUserCubit = BlocProvider.of<RegisterUserCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
          centerTitle: true,
        ),
        body: BlocConsumer<RegisterUserCubit, RegisterUserState>(
          listener: (context, state) async {
            switch (state.status) {
              case ScreenStatus.loading:
                customShowDialog(context: context, title: 'Conectando...', message: 'Por favor espere', isDismissible: false);
                break;
              case ScreenStatus.success:
                await customShowDialog(
                  context: context,
                  title: 'ÉXITO',
                  message: 'Cuenta creada exitosamente',
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  textButton: "Aceptar",
                );
                _resetControllers();
                break;
              case ScreenStatus.failure:
                customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
                break;
              default:
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: CardContainer(
                          child: Column(
                            children: [
                              const Image(image: AssetImage('assets/barkibu_logo.png'), height: 100),
                              Expanded(child: _userRegisterForm(context)),
                            ],
                          ),
                        ),
                      ),
                      CustomMaterialButton(
                        text: 'Registrarse',
                        onPressed: () => registerUserCubit.registerUser(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          userName: _userNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget _userRegisterForm(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Nombre*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su nombre';
              }
              return null;
            },
            controller: _firstNameController,
          ),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Apellido*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su apellido';
              }
              return null;
            },
            controller: _lastNameController,
          ),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Usuario*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su usuario';
              }
              return null;
            },
            controller: _userNameController,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Correo electrónico*'),
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
            controller: _emailController,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su contraseña';
              } else if (value.length < 12) {
                return 'La contraseña debe tener al menos 12 caracteres';
              }
              return null;
            },
            onChanged: (value) => BlocProvider.of<RegisterUserCubit>(context).passwordStrength(_passwordController.text),
            controller: _passwordController,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Confirmar contraseña*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor confirme su contraseña';
              } else if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 10),
          passwordStrengthIndicator(_passwordController.text),
        ],
      ),
    );
  }

  void _resetControllers() {
    _firstNameController.clear();
    _lastNameController.clear();
    _userNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
}
