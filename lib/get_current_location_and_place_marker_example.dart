//Get current user's location and place a marker on it.
// Using Geo locator package.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_projects/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({super.key});

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  final googleMapController = GoogleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _controller.future.then((controller) async {
            await Geolocator.checkPermission().then(
              (value) async {
                if (value == LocationPermission.always) {
                  final position = await Geolocator.getCurrentPosition();
                  setState(() {
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                        ),
                      ),
                    );
                  });
                }
              },
            );
          });
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
