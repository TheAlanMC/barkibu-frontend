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
      tilt: 50,
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
        ));
  }
}
