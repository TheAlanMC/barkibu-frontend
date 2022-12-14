import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class VeterinarianProfileSettingsScreen extends StatelessWidget {
  const VeterinarianProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userVeterinarianCubit = BlocProvider.of<UserVeterinarianCubit>(context);
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: userVeterinarianCubit.getUserVeterinarian(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (userVeterinarianCubit.state.status) {
              case ScreenStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case ScreenStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ScreenStatus.success:
                return _VeterinarianProfileSettings();
              case ScreenStatus.failure:
                Logout.logout(context);
                break;
            }
            return Container();
          }),
    ));
  }
}

class _VeterinarianProfileSettings extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userVeterinarianCubit = BlocProvider.of<UserVeterinarianCubit>(context);
    _firstNameController.text = userVeterinarianCubit.state.userVeterinarianDto!.firstName;
    _lastNameController.text = userVeterinarianCubit.state.userVeterinarianDto!.lastName;
    _userNameController.text = userVeterinarianCubit.state.userVeterinarianDto!.userName;
    _emailController.text = userVeterinarianCubit.state.userVeterinarianDto!.email;
    _descriptionController.text = userVeterinarianCubit.state.userVeterinarianDto!.description ?? '';
    final String currentUserName = userVeterinarianCubit.state.userVeterinarianDto!.userName;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuenta'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/veterinarian_profile_edit_veterinary_screen'),
            icon: const Icon(Icons.local_hospital),
          ),
        ],
      ),
      body: BlocConsumer<UserVeterinarianCubit, UserVeterinarianState>(
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
                  title: '??XITO',
                  message: 'Los datos se han actualizado exitosamente. Por favor, inicie sesi??n de nuevo',
                  onPressed: () => SkipAnimation.pushAndRemoveUntil(context, '/login_screen'),
                  textButton: "Aceptar",
                );
              } else {
                await customShowDialog(
                  context: context,
                  title: '??XITO',
                  message: 'Los datos se han actualizado exitosamente',
                  onPressed: () => SkipAnimation.pushAndRemoveUntil(context, '/veterinarian_profile_screen'),
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
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(child: CardContainer(child: _userEditForm(context, state.photoPath))),
                    CardContainer(child: _userLocationForm(context, state)),
                    CardContainer(child: _aboutMeEditForm()),
                    CustomMaterialButton(text: 'Cancelar', cancel: true, onPressed: () => Navigator.of(context).pop()),
                    const SizedBox(height: 20),
                    CustomMaterialButton(
                        text: 'Guardar',
                        onPressed: () {
                          userVeterinarianCubit.updateUserVeterinarian(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            userName: _userNameController.text,
                            email: _emailController.text,
                            description: _descriptionController.text,
                          );
                        }),
                    CardContainer(
                        child: Column(
                      children: [
                        CustomTextButton(
                          icon: Icons.logout,
                          text: 'Cerrar Sesi??n',
                          onPressed: () => Logout.logout(context),
                        ),
                        CustomTextButton(
                          icon: Icons.key,
                          text: 'Cambiar Contrase??a',
                          onPressed: () => Navigator.of(context).pushNamed('/change_password_screen'),
                        ),
                      ],
                    )),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationVeterinary(
        currentIndex: 0,
      ),
    );
  }

  Widget _userEditForm(BuildContext context, String? photoPath) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CustomCircleAvatar(
                photoPath: photoPath ?? 'assets/default_veterinarian_profile.png',
                size: 75,
              ),
              Positioned(
                bottom: 0,
                right: -25,
                child: RawMaterialButton(
                  onPressed: () {
                    final picker = ImagePicker();
                    picker.pickImage(source: ImageSource.camera, imageQuality: 10).then((value) {
                      if (value == null) return;
                      BlocProvider.of<UserVeterinarianCubit>(context).changeImage(value.path);
                    });
                  },
                  elevation: 2.0,
                  fillColor: AppTheme.background,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(5.0),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppTheme.primary,
                    size: 30.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: -25,
                child: RawMaterialButton(
                  onPressed: () {
                    final picker = ImagePicker();
                    picker.pickImage(source: ImageSource.gallery, imageQuality: 10).then(
                      (value) {
                        if (value == null) return;
                        BlocProvider.of<UserVeterinarianCubit>(context).changeImage(value.path);
                      },
                    );
                  },
                  elevation: 2.0,
                  fillColor: AppTheme.background,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(5.0),
                  child: const Icon(
                    Icons.image_outlined,
                    color: AppTheme.primary,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
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
            decoration: const InputDecoration(labelText: 'Correo electr??nico*'),
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su correo electr??nico';
              } else if (!regExp.hasMatch(value)) {
                return 'Por favor ingrese un correo electr??nico v??lido';
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

  Widget _userLocationForm(BuildContext context, UserVeterinarianState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(child: Text('Ubicaci??n:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const SizedBox(height: 10),
        CustomDropDownButtonFormField(
          list: DropDownMenu.getCountries(state.countries),
          label: 'Pa??s',
          onChanged: (value) {
            BlocProvider.of<UserVeterinarianCubit>(context).changeCountryValue(value);
          },
          initialValue: state.countryId ?? 0,
        ),
        CustomDropDownButtonFormField(
          list: DropDownMenu.getStates(state.states, state.countryId),
          label: 'Estado',
          onChanged: (value) {
            BlocProvider.of<UserVeterinarianCubit>(context).changeStateValue(value);
          },
          initialValue: state.stateId ?? 0,
        ),
        CustomDropDownButtonFormField(
          list: DropDownMenu.getCities(state.cities, state.stateId),
          label: 'Ciudad',
          onChanged: (value) {
            BlocProvider.of<UserVeterinarianCubit>(context).changeCityValue(value);
          },
          initialValue: state.cityId,
        ),
      ],
    );
  }

  Widget _aboutMeEditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(child: Text('Acerca de mi:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const SizedBox(height: 10),
        TextFormField(
          maxLines: 2,
          autocorrect: false,
          decoration: const InputDecoration(labelText: 'Descripci??n'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese su descripci??n';
            }
            return null;
          },
          controller: _descriptionController,
        ),
      ],
    );
  }
}
