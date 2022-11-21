import 'dart:async';
import 'package:barkibu/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VeterinaryProfileDisplayLocationScreen extends StatefulWidget {
  const VeterinaryProfileDisplayLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VeterinaryProfileDisplayLocationScreen> createState() => _VeterinaryProfileDisplayLocationScreenState();
}

class _VeterinaryProfileDisplayLocationScreenState extends State<VeterinaryProfileDisplayLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final veterinarianInfoCubit = BlocProvider.of<VeterinarianInfoCubit>(context);
    final String name = veterinarianInfoCubit.state.veterinary!.name;
    final double latitude = veterinarianInfoCubit.state.veterinary!.latitude;
    final double longitude = veterinarianInfoCubit.state.veterinary!.longitude;

    CameraPosition puntoInicial = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 17.5,
      tilt: 0,
    );

    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: MarkerId(name),
        position: LatLng(latitude, longitude),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          centerTitle: true,
        ),
        body: GoogleMap(
          markers: markers,
          myLocationButtonEnabled: false,
          mapType: mapType,
          initialCameraPosition: puntoInicial,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
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
        ));
  }
}
