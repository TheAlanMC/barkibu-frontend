import 'dart:async';

import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/screens/screens.dart';
import 'package:barkibu/theme/app_theme.dart';
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
        listener: (context, state) {
          // TODO: implement listener
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
                      text: 'Guardar',
                      onPressed: () => Navigator.of(context).pushNamed('/register_pet_screen'),
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
          ),
          const Text('Ubicación de la clínica*', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
          Container(
            height: 200,
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
                          builder: (context) => const VeterinaryEditLocationScreen(),
                        ),
                      ),
                  text: 'Ver Mapa',
                  icon: Icons.map),
            ],
          ),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Descripción'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la descripción de la clínica';
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
