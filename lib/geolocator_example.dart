// Geocoding is a package using which you can get the address of anywhere with coordinates(Lat lng).
// And vise versa you can get the coordinates (Lat lng) of anywhere if you give it the address.
//See example below

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GeoLocatorExample extends StatefulWidget {
  const GeoLocatorExample({super.key});

  @override
  State<GeoLocatorExample> createState() => _State();
}

class _State extends State<GeoLocatorExample> {
  String convertedAddress = "Empty";
  String convertedCoordinates = "Empty";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  static const TextStyle _style = TextStyle(
    fontSize: 18,
  );

  Widget sizeBox = const SizedBox(
    height: 10,
  );
  @override
  void dispose() {
    _addressController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GeoLocator Example",
          style: _style,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Enter Coordinates to convert",
                    style: _style,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _latController,
                          decoration: const InputDecoration(
                            hintText: "Lat",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _lngController,
                          decoration: const InputDecoration(
                            hintText: "Lng",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizeBox,
                  Text(
                    convertedCoordinates,
                    style: _style,
                  ),
                  sizeBox,
                  ElevatedButton(
                    onPressed: () async {
                      if (_latController.text.isNotEmpty) {
                        if (_lngController.text.isNotEmpty) {
                          final address = await placemarkFromCoordinates(
                            double.parse(_latController.text),
                            double.parse(_lngController.text),
                          );
                          setState(() {
                            convertedCoordinates = "${address.first.street},"
                                "${address.first.name},"
                                "${address.first.country}";
                          });
                        }
                      }
                    },
                    child: const Text(
                      "Convert coordinates",
                      style: _style,
                    ),
                  ),
                  sizeBox,
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      hintText: "Enter Address to convert to coordinates",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  sizeBox,
                  Text(
                    convertedAddress,
                    style: _style,
                  ),
                  sizeBox,
                  ElevatedButton(
                    onPressed: () async {
                      if (_addressController.text.isNotEmpty) {
                        final address = await locationFromAddress(
                            _addressController.text.toString());
                        setState(() {
                          convertedAddress =
                              "lat:${address.first.latitude.toString()} lng:${address.first.longitude.toString()}";
                        });
                      }
                    },
                    child: const Text(
                      "Convert",
                      style: _style,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
