import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordManagementCubit = BlocProvider.of<PasswordManagementCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar contraseña'),
        centerTitle: true,
      ),
      body: BlocConsumer<PasswordManagementCubit, PasswordManagementState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              customShowDialog(context: context, title: 'Conectando...', message: 'Por favor espere', isDismissible: false);
              break;
            case ScreenStatus.success:
              await customShowDialog(
                context: context,
                title: 'ÉXITO',
                message: 'Contraseña actualizada',
                onPressed: () => Navigator.of(context).pop(),
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
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CardContainer(
                        child: _passwordChangeForm(context),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomMaterialButton(
                      cancel: true,
                      text: 'Cancelar',
                      onPressed: (() => Navigator.of(context).pop()),
                    ),
                    const SizedBox(height: 30),
                    CustomMaterialButton(
                        text: 'Guardar',
                        onPressed: () => passwordManagementCubit.changePassword(
                              currentPassword: _currentPasswordController.text,
                              newPassword: _newPasswordController.text,
                              confirmNewPassword: _confirmNewPasswordController.text,
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

  Widget _passwordChangeForm(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña actual*'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su contraseña actual';
                }
                return null;
              },
              onChanged: (value) => BlocProvider.of<PasswordManagementCubit>(context).passwordStrength(_newPasswordController.text),
              controller: _currentPasswordController),
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
            onChanged: (value) => BlocProvider.of<PasswordManagementCubit>(context).passwordStrength(_newPasswordController.text),
            controller: _newPasswordController,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Confirmar nueva contraseña*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor confirme su contraseña';
              } else if (value != _newPasswordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
            controller: _confirmNewPasswordController,
          ),
          const SizedBox(height: 10),
          passwordStrengthIndicator(_newPasswordController.text),
        ],
      ),
    );
  }

  void _resetControllers() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmNewPasswordController.clear();
  }
}
