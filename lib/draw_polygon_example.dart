// We will draw a polygon in this example

import 'package:flutter/material.dart';
import 'package:flutter_projects/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawPolygonExample extends StatefulWidget {
  const DrawPolygonExample({super.key});

  @override
  State<DrawPolygonExample> createState() => _DrawPolygonExampleState();
}

class _DrawPolygonExampleState extends State<DrawPolygonExample> {
  static const List<LatLng> _polygonPoints = <LatLng>[
    LatLng(
      30.1798,
      66.9750,
    ),
    LatLng(
      30.1788,
      66.9756,
    ),
    LatLng(
      30.1728,
      66.9759,
    ),
  ];
  final List<Polygon> _polygon = [
    Polygon(
      polygonId: const PolygonId("1"),
      points: _polygonPoints,
      fillColor: Colors.black.withOpacity(0.2),
      strokeWidth: 3,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        polygons: Set<Polygon>.of(_polygon),
      ),
    );
  }
}
