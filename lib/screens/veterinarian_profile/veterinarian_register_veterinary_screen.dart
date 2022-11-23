import 'dart:async';

import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/screens/screens.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class VeterinarianRegisterVeterinaryScreen extends StatelessWidget {
  VeterinarianRegisterVeterinaryScreen({super.key});

  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  final _veterinaryNameController = TextEditingController();
  final _veterinaryAddressController = TextEditingController();
  final _veterinaryDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final veterinaryCubit = BlocProvider.of<VeterinaryCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Clínica Veterinaria'),
        centerTitle: true,
      ),
      body: BlocConsumer<VeterinaryCubit, VeterinaryState>(
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
                message: 'Clinica veterinaria registrada exitosamente',
                textButton: "Aceptar",
                onPressed: () => Navigator.of(context).popAndPushNamed('/veterinarian_profile_screen'),
              );
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
                            Expanded(child: _veterinaryEditForm(context, state)),
                          ],
                        ),
                      ),
                    ),
                    CustomMaterialButton(
                        text: 'Cancelar',
                        cancel: true,
                        onPressed: () {
                          TokenSecureStorage.deleteTokens();
                          Navigator.pushNamedAndRemoveUntil(context, '/login_screen', (route) => false);
                        }),
                    const SizedBox(height: 10),
                    CustomMaterialButton(
                      text: 'Guardar',
                      onPressed: () => veterinaryCubit.registerVeterinary(
                        name: _veterinaryNameController.text,
                        address: _veterinaryAddressController.text,
                        description: _veterinaryDescriptionController.text,
                      ),
                    ),
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

  Widget _veterinaryEditForm(BuildContext context, state) {
    CameraPosition kVeterinary = CameraPosition(
      target: LatLng(state.latitude, state.longitude),
      zoom: 16,
    );
    mapController?.animateCamera(CameraUpdate.newCameraPosition(kVeterinary));

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Nombre*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el nombre de la clínica';
              }
              return null;
            },
            controller: _veterinaryNameController,
          ),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Dirección Actual*'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la dirección de la clínica';
              }
              return null;
            },
            controller: _veterinaryAddressController,
          ),
          const Text('Ubicación de la clínica*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
          Container(
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.secondary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: kVeterinary,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  mapController = controller;
                },
                mapToolbarEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: {
                  Marker(
                    markerId: const MarkerId('Veterinaria'),
                    position: kVeterinary.target,
                  ),
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const VeterinaryRegisterLocationScreen(),
                        ),
                      ),
                  text: 'Ver Mapa',
                  icon: Icons.map),
            ],
          ),
          TextFormField(
            maxLines: 2,
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Descripción'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la descripción de la clínica';
              }
              return null;
            },
            controller: _veterinaryDescriptionController,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
