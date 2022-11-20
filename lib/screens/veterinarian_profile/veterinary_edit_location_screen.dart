import 'dart:async';
import 'package:barkibu/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VeterinaryEditLocationScreen extends StatefulWidget {
  const VeterinaryEditLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VeterinaryEditLocationScreen> createState() => _VeterinaryEditLocationScreenState();
}

class _VeterinaryEditLocationScreenState extends State<VeterinaryEditLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final veterinaryCubit = BlocProvider.of<VeterinaryCubit>(context);
    CameraPosition puntoInicial = CameraPosition(
      target: LatLng(veterinaryCubit.state.latitude, veterinaryCubit.state.longitude),
      zoom: 17.5,
    );

    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: const MarkerId('Veterinaria'),
        position: LatLng(veterinaryCubit.state.latitude, veterinaryCubit.state.longitude),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación de la Clínica'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(puntoInicial));
            },
          ),
        ],
      ),
      body: GoogleMap(
        markers: markers,
        myLocationButtonEnabled: false,
        mapType: mapType,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (LatLng location) {
          setState(() {
            markers.clear();
            markers.add(
              Marker(
                markerId: const MarkerId('Veterinaria'),
                position: location,
              ),
            );
            veterinaryCubit.updateLocation(location.latitude, location.longitude);
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
          });
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
