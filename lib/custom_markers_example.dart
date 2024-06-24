//In this example we will use custom markers for google map

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkersExample extends StatefulWidget {
  const CustomMarkersExample({super.key});

  @override
  State<CustomMarkersExample> createState() => _CustomMarkersExampleState();
}

class _CustomMarkersExampleState extends State<CustomMarkersExample> {
  final List<Marker> _markers = [];
  final List<LatLng> _latlng = [
    const LatLng(
      30.1798,
      66.9750,
    ),
    const LatLng(
      30.1799,
      66.9755,
    ),
  ];
  final List<String> _images = [
    "assets/sport_car.png",
    "assets/motorcycle.png",
  ];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    // initialize loadData method
    loadData();
  }

  // created method for displaying custom markers according to index
  loadData() async {
    for (int i = 0; i < _images.length; i++) {
      final Uint8List markIcons = await getImages(_images[i], 100);
      // makers added according to index
      _markers.add(Marker(
        // given marker id
        markerId: MarkerId(i.toString()),
        // given marker icon
        icon: BitmapDescriptor.fromBytes(markIcons),
        // given position
        position: _latlng[i],
        infoWindow: InfoWindow(
          // given title for marker
          title: 'Location: ${i + 1}',
        ),
      ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom markers Example"),
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        markers: Set<Marker>.of(_markers),
      ),
    );
  }
}
