import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordRecoverScreen2 extends StatelessWidget {
  PasswordRecoverScreen2({Key? key}) : super(key: key);
  final _secretCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordManagementCubit = BlocProvider.of<PasswordManagementCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
      ),
      body: BlocListener<PasswordManagementCubit, PasswordManagementState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.success:
              await customShowDialog(
                context: context,
                title: 'ÉXITO',
                message: 'Codigo de seguridad verificado',
                onPressed: () => Navigator.of(context).pushNamed('/password_recover_screen3'),
                textButton: "Aceptar",
              );
              _secretCodeController.clear();
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Se le envió un código al correo electrónico ingresado, por favor introduzca el mismo para reestablecer su contraseña.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                            onPressed: () => passwordManagementCubit.sendCode(secretCode: _secretCodeController.text),
                          ),
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
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Código de verificación'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese el código de verificación';
          }
          return null;
        },
        controller: _secretCodeController,
      ),
    );
  }
}
