import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:barkibu/dto/veterinary_dto.dart';

class VeterinaryDisplayLocationScreen extends StatefulWidget {
  final VeterinaryDto veterinaryDto;
  const VeterinaryDisplayLocationScreen({
    Key? key,
    required this.veterinaryDto,
  }) : super(key: key);

  @override
  State<VeterinaryDisplayLocationScreen> createState() => _VeterinaryDisplayLocationScreenState();
}

class _VeterinaryDisplayLocationScreenState extends State<VeterinaryDisplayLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    CameraPosition puntoInicial = CameraPosition(
      target: LatLng(widget.veterinaryDto.latitude, widget.veterinaryDto.longitude),
      zoom: 17.5,
      tilt: 0,
    );

    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: MarkerId(widget.veterinaryDto.name),
        position: LatLng(widget.veterinaryDto.latitude, widget.veterinaryDto.longitude),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.veterinaryDto.name),
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
                CameraPosition nuevoPunto =
                    CameraPosition(target: LatLng(widget.veterinaryDto.latitude, widget.veterinaryDto.longitude), zoom: 17.5, tilt: 45);
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
