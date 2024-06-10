import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'custom_markers_example.dart';

void main() {
  runApp(const MyApp());
}

const CameraPosition initialPosition = CameraPosition(
  target: LatLng(
    30.1798,
    66.9750,
  ),
  zoom: 18,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomMarkersExample(),
    );
  }
}
