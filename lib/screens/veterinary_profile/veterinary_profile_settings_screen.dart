import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class VeterinaryProfileSettingsScreen extends StatelessWidget {
  const VeterinaryProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Cuenta'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                  child: CardContainer(
                    child: Column(
                      children: [
                        Expanded(child: _userEditForm(context)),
                      ],
                    ),
                  ),
                ),
                CardContainer(child: _aboutMeEditForm()),
                CustomMaterialButton(
                  text: 'Guardar',
                  onPressed: () => Navigator.of(context).pushNamed('/register_pet_screen'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userEditForm(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const CustomCircleAvatar(
                border: AppTheme.secondary,
                path: 'assets/veterinary_profile.jpg',
                size: 75,
              ),
              Positioned(
                bottom: 0,
                right: -25,
                child: RawMaterialButton(
                  onPressed: () {},
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
                  onPressed: () {},
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
          ),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Ciudad-Estado*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su ciudad-estado';
              }
              return null;
            },
          ),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'País*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su país';
              }
              return null;
            },
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
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

Widget _aboutMeEditForm() {
  return Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(child: Text('Acerca de mi:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          SizedBox(height: 20),
          Text(
            //TODO: MAX 200 CHARACTERS
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          )
        ],
      ),
      Positioned(
        top: 0,
        right: -20,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: AppTheme.background,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(5.0),
          child: const Icon(
            Icons.edit_outlined,
            color: AppTheme.primary,
            size: 30.0,
          ),
        ),
      ),
    ],
  );
}
