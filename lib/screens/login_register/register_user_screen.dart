import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserScreen extends StatelessWidget {
  //TODO: clear form after register
  RegisterUserScreen({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController(text: '');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Registro'),
          ),
          body: BlocConsumer<RegisterUserCubit, RegisterUserState>(
            listener: (context, state) {
              //Todo: routing
              //TODO: return to initial state afeter failure
              switch (state.status) {
                case ScreenStatus.initial:
                  break;
                case ScreenStatus.loading:
                  customShowDialog(context, 'Conectando...', 'Por favor espere', false);
                  break;
                case ScreenStatus.success:
                  // customShowDialog(context, 'Éxito', 'Registro exitoso', true);
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/register_pet_screen');
                  break;
                case ScreenStatus.failure:
                  customShowDialog(context, 'Error', state.errorMessage ?? 'Error desconocido', true);
                  break;
                default:
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CardContainer(
                        child: Column(
                          children: [
                            const Image(image: AssetImage('assets/barkibu_logo.png'), height: 80),
                            _userRegisterForm(context),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomMaterialButton(
                        text: 'Registrarse',
                        onPressed: () => BlocProvider.of<RegisterUserCubit>(context).registerUser(
                          //TODO: all fields are required

                          // name: _nameController.text,
                          // lastName: _lastNameController.text,
                          userName: _userNameController.text,
                          // email: _emailController.text,
                          password: _passwordController.text,
                          // confirmPassword: _confirmPasswordController.text,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _userRegisterForm(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
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
            controller: _nameController,
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su contraseña';
                //TODO: change 6 to 12
              } else if (value.length < 6) {
                return 'La contraseña debe tener al menos 12 caracteres';
              }
              return null;
            },
            onChanged: (value) => BlocProvider.of<RegisterUserCubit>(context).passwordStrength(_passwordController.text),
            controller: _passwordController,
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 45),
          passwordStrengthIndicator(_passwordController.text),
        ],
      ),
    );
  }
}
