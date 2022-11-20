import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordRecoverScreen3 extends StatelessWidget {
  PasswordRecoverScreen3({Key? key}) : super(key: key);
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordRecoveryCubit = BlocProvider.of<PasswordRecoveryCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: BlocConsumer<PasswordRecoveryCubit, PasswordRecoveryState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.success:
              await customShowDialog(
                context: context,
                title: 'ÉXITO',
                message: 'Contraseña actualizada',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: CardContainer(
                        child: _passwordRecoverForm(context),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomMaterialButton(
                      cancel: true,
                      text: 'Cancelar',
                      onPressed: (() => Navigator.of(context).popUntil((route) => route.isFirst)),
                    ),
                    const SizedBox(height: 30),
                    CustomMaterialButton(
                        text: 'Guardar',
                        onPressed: () => passwordRecoveryCubit.updatePassword(
                              password: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text,
                            )),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _passwordRecoverForm(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Nueva contraseña*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la nueva contraseña';
              } else if (value.length < 12) {
                return 'La contraseña debe tener al menos 12 caracteres';
              }
              return null;
            },
            onChanged: (value) => BlocProvider.of<PasswordRecoveryCubit>(context).passwordStrength(_passwordController.text),
            controller: _passwordController,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Confirmar nueva contraseña*'),
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
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
}
