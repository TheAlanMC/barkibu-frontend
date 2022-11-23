import 'package:flutter/material.dart';
import 'package:barkibu/widgets/widgets.dart';

class PetOwnerAccountScreen extends StatelessWidget {
  PetOwnerAccountScreen({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController(text: '');
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi cuenta'),
        centerTitle: true,
      ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(
                    child: CardContainer(
                      child: Column(
                        children: [
                          Expanded(child: _userAccountForm(context)),
                        ],
                      ),
                    ),
                  ),
                  CustomMaterialButton(
                    text: 'Guardar',
                    onPressed: () => Navigator.of(context).pushNamed('/pet_owner_pet_info_screen'),
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

  Widget _userAccountForm(BuildContext context) {
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
            controller: _nameController,
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
          CardContainer(
              child: Column(
            children: [
              CustomTextButton(
                  icon: Icons.login,
                  text: 'Cerrar sesion',
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)),
              CustomTextButton(
                icon: Icons.key,
                text: 'Cambiar contraseña',
                onPressed: () => Navigator.of(context).pushNamed('/pet_owner_change_password_screen'),
              ),
              CustomTextButton(
                  icon: Icons.delete_forever,
                  text: 'Eliminar cuenta',
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)),
            ],
          )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
