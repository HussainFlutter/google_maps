import 'package:flutter/material.dart';
import 'package:flutter_projects/geolocator_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GeoLocatorExample(),
    );
  }
}
