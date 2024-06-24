//In this example we are using network images as marker's icon

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_projects/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageAsMarkerExample extends StatefulWidget {
  const NetworkImageAsMarkerExample({super.key});

  @override
  State<NetworkImageAsMarkerExample> createState() =>
      _NetworkImageAsMarkerExampleState();
}

class _NetworkImageAsMarkerExampleState
    extends State<NetworkImageAsMarkerExample> {
  final List<LatLng> positions = const [
    LatLng(
      30.1799,
      66.9751,
    ),
    LatLng(
      30.1798,
      66.9750,
    ),
    LatLng(
      30.1699,
      66.9759,
    ),
    LatLng(
      30.1802,
      66.9755,
    ),
  ];
  final List<Marker> _markers = <Marker>[];

  loadMarkers() async {
    for (final position in positions) {
      final Uint8List bytes = await loadNetworkImage(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCqL-WCZx1PM6BvTbaA4AFor72rax3G-190Q&s");
      final ui.Codec markerImage = await ui.instantiateImageCodec(
        bytes.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );
      final ui.FrameInfo frameInfo = await markerImage.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List resizedImage = byteData!.buffer.asUint8List();

      _markers.add(Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          icon: BitmapDescriptor.fromBytes(resizedImage),
          infoWindow: InfoWindow(
            title: position.toString(),
            snippet: 'Click me!',
          )));
      setState(() {});
    }
  }

  Future<Uint8List> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    NetworkImage image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((image, _) => completer.complete(image)));
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Network image as marker Example"),
      ),
      body: GoogleMap(
        markers: Set.of(_markers),
        initialCameraPosition: initialPosition,
      ),
    );
  }
}
