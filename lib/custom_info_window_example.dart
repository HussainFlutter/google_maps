// In this example we added custom info window for showing pictures
// and details etc for a marker
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'main.dart';

class CustomInfoWindowExample extends StatefulWidget {
  const CustomInfoWindowExample({super.key});

  @override
  State<CustomInfoWindowExample> createState() =>
      _CustomInfoWindowExampleState();
}

class _CustomInfoWindowExampleState extends State<CustomInfoWindowExample> {
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

  final CustomInfoWindowController _controller = CustomInfoWindowController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    for (final i in _latlng) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: i,
          onTap: () {
            _controller.addInfoWindow!(
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Image.asset(
                        "assets/example.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(child: Text(i.toString())),
                  ],
                ),
              ),
              i,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onTap: (position) {
              _controller.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _controller.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              _controller.googleMapController = controller;
            },
            markers: Set<Marker>.of(_markers),
            initialCameraPosition: initialPosition,
          ),
          CustomInfoWindow(
            controller: _controller,
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ],
      ),
    );
  }
}
