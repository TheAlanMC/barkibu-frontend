import 'dart:async';
import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/theme/app_theme.dart';
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
  int tilt = 0;

  @override
  Widget build(BuildContext context) {
    final veterinarianInfoCubit = BlocProvider.of<VeterinarianInfoCubit>(context);
    final String name = veterinarianInfoCubit.state.veterinary!.name;
    final double latitude = veterinarianInfoCubit.state.veterinary!.latitude;
    final double longitude = veterinarianInfoCubit.state.veterinary!.longitude;

    CameraPosition initialLocation = CameraPosition(
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
          initialCameraPosition: initialLocation,
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
              backgroundColor: AppTheme.primary,
              onPressed: () {
                setState(() {
                  mapType = mapType == MapType.normal ? MapType.satellite : MapType.normal;
                });
              },
              child: const Icon(Icons.layers),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "Tilt",
              backgroundColor: AppTheme.primary,
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                CameraPosition nuevoPunto = CameraPosition(target: LatLng(latitude, longitude), zoom: 17.5, tilt: 45);
                if (tilt == 0) {
                  tilt = 45;
                  controller.animateCamera(CameraUpdate.newCameraPosition(nuevoPunto));
                } else {
                  tilt = 0;
                  controller.animateCamera(CameraUpdate.newCameraPosition(initialLocation));
                }
              },
              child: const Icon(Icons.map),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "Location",
              backgroundColor: AppTheme.cardColor,
              foregroundColor: AppTheme.primary,
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(initialLocation));
              },
              child: const Icon(Icons.my_location),
            ),
          ],
        ));
  }
}
