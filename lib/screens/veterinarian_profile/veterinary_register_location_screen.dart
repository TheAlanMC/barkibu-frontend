import 'dart:async';
import 'package:barkibu/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class VeterinaryLocationScreen extends StatefulWidget {
  const VeterinaryLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VeterinaryLocationScreen> createState() => _VeterinaryLocationScreenState();
}

class _VeterinaryLocationScreenState extends State<VeterinaryLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final veterinaryCubit = BlocProvider.of<VeterinaryCubit>(context);
    final double latitude = veterinaryCubit.state.veterinary?.latitude ?? veterinaryCubit.state.latitude;
    final double longitude = veterinaryCubit.state.veterinary?.longitude ?? veterinaryCubit.state.longitude;
    CameraPosition puntoInicial = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 17.5,
      tilt: 0,
    );

    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: const MarkerId('Veterinaria'),
        position: LatLng(latitude, longitude),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación de la Clínica'),
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Satellite",
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                mapType = mapType == MapType.normal ? MapType.satellite : MapType.normal;
              });
            },
            child: const Icon(Icons.layers),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "3D",
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              CameraPosition nuevoPunto = CameraPosition(target: LatLng(latitude, longitude), zoom: 17.5, tilt: 45);
              controller.animateCamera(CameraUpdate.newCameraPosition(nuevoPunto));
            },
            child: const Icon(Icons.map),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "2D",
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(puntoInicial));
            },
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
