import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetOwnerAccountScreen extends StatelessWidget {
  const PetOwnerAccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userPetOwnerCubit = BlocProvider.of<UserPetOwnerCubit>(context);
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: userPetOwnerCubit.getUserPetOwner(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (userPetOwnerCubit.state.status) {
              case ScreenStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case ScreenStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ScreenStatus.success:
                return _PetOwnerAccountScreen();
              case ScreenStatus.failure:
                Logout.logout(context);
                break;
            }
            return Container();
          }),
    ));
  }
}

class _PetOwnerAccountScreen extends StatelessWidget {
  _PetOwnerAccountScreen({Key? key}) : super(key: key);
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userPetOwnerCubit = BlocProvider.of<UserPetOwnerCubit>(context);
    _firstNameController.text = userPetOwnerCubit.state.userPetOwnerDto!.firstName;
    _lastNameController.text = userPetOwnerCubit.state.userPetOwnerDto!.lastName;
    _userNameController.text = userPetOwnerCubit.state.userPetOwnerDto!.userName;
    _emailController.text = userPetOwnerCubit.state.userPetOwnerDto!.email;
    final String currentUserName = userPetOwnerCubit.state.userPetOwnerDto!.userName;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi cuenta'),
        centerTitle: true,
      ),
      body: BlocListener<UserPetOwnerCubit, UserPetOwnerState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.loading:
              customShowDialog(context: context, title: 'Conectando...', message: 'Por favor espere', isDismissible: false);
              break;
            case ScreenStatus.success:
              if (currentUserName != _userNameController.text) {
                await TokenSecureStorage.deleteTokens();
                await customShowDialog(
                  context: context,
                  title: 'ÉXITO',
                  message: 'Los datos se han actualizado correctamente. Por favor, inicie sesión de nuevo',
                  onPressed: () => SkipAnimation.pushAndRemoveUntil(context, '/login_screen'),
                  textButton: "Aceptar",
                );
              } else {
                await customShowDialog(
                  context: context,
                  title: 'ÉXITO',
                  message: 'Los datos se han actualizado correctamente',
                  onPressed: () => SkipAnimation.pushAndRemoveUntil(context, '/pet_owner_pet_info_screen'),
                  textButton: "Aceptar",
                );
              }
              break;
            case ScreenStatus.failure:
              if (state.statusCode == 'SCTY-2002') Logout.logout(context);
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
                  CustomMaterialButton(text: 'Cancelar', cancel: true, onPressed: () => Navigator.of(context).pop()),
                  const SizedBox(height: 20),
                  CustomMaterialButton(
                    text: 'Guardar',
                    onPressed: () {
                      userPetOwnerCubit.updateUserPetOwner(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        userName: _userNameController.text,
                        email: _emailController.text,
                      );
                    },
                  ),
                  CardContainer(
                      child: Column(
                    children: [
                      CustomTextButton(
                        icon: Icons.login,
                        text: 'Cerrar sesion',
                        onPressed: () => Logout.logout(context),
                      ),
                      CustomTextButton(
                        icon: Icons.key,
                        text: 'Cambiar contraseña',
                        onPressed: () => Navigator.of(context).pushNamed('/change_password_screen'),
                      ),
                      CustomTextButton(
                          icon: Icons.delete_forever,
                          text: 'Eliminar cuenta',
                          color: AppTheme.alert,
                          //TODO: IMPLEMENT DELETE ACCOUNT
                          onPressed: (() => Logout.logout(context)) //() => userPetOwnerCubit.deleteUserPetOwner()),
                          )
                    ],
                  )),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 0,
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
