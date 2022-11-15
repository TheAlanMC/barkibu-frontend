import 'package:barkibu/cubit/password_recovery/password_recovery_cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordRecoverScreen1 extends StatelessWidget {
  PasswordRecoverScreen1({Key? key}) : super(key: key);
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordRecoveryCubit = BlocProvider.of<PasswordRecoveryCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
      ),
      body: BlocListener<PasswordRecoveryCubit, PasswordRecoveryState>(
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
                message: 'Codigo de seguridad enviado a su correo',
                onPressed: () => Navigator.of(context).pushNamed('/password_recover_screen2'),
                textButton: "Aceptar",
              );
              _emailController.clear();
              break;
            case ScreenStatus.failure:
              customShowDialog(
                  context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
              break;
            default:
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Llene el siguiente campo para solicitar un código que le permitirá reestablecer su contraseña.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: CardContainer(child: _buildForm())),
                          const SizedBox(height: 20),
                          CustomMaterialButton(
                              text: 'Enviar',
                              onPressed: () {
                                passwordRecoveryCubit.sendEmail(email: _emailController.text);
                              }),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Correo electrónico'),
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
    );
  }
}
