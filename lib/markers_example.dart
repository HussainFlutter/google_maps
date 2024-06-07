//Using markers we can set markers on the map and show the info window of the marker on clicking it.
//Each marker id should be unique.
//See example below
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('marker_1'),
      position: LatLng(
        30.1799,
        66.9751,
      ),
      infoWindow: InfoWindow(
        title: "Hello",
        snippet: "HEHE",
      ),
    ),
    const Marker(
      markerId: MarkerId('marker_2'),
      position: LatLng(
        30.1699,
        66.9759,
      ),
      infoWindow: InfoWindow(
        title: "Hello2",
        snippet: "HEHE",
      ),
    ),
    const Marker(
      markerId: MarkerId('marker_3'),
      position: LatLng(
        30.1802,
        66.9755,
      ),
      infoWindow: InfoWindow(
        title: "Hello3",
        snippet: "HEHE",
      ),
    ),
  ];
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set.of(_markers),
        initialCameraPosition: initialPosition,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
