//In this example we will style our google map using a custom map style.
// Use this website to get styles jsons from https://mapstyle.withgoogle.com
//We will first create a assets folder and then create a json file named ANY_NAME.json and paste the style json in it.
//We will also write this file path in our pubspec yaml
import 'package:flutter/material.dart';
import 'package:flutter_projects/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleMapExample extends StatefulWidget {
  const StyleMapExample({super.key});

  @override
  State<StyleMapExample> createState() => _StyleMapExampleState();
}

class _StyleMapExampleState extends State<StyleMapExample> {
  List<String> mapThemeList = [];
  String mapTheme = "";
  int index = 0;
  static const List<String> mapJsons = [
    "assets/map_theme/standard_theme.json",
    "assets/map_theme/aubergine_theme.json",
    "assets/map_theme/dark_theme.json",
    "assets/map_theme/silver_theme.json",
    "assets/map_theme/night_theme.json",
    "assets/map_theme/retro_theme.json",
  ];
  @override
  void initState() {
    super.initState();
    for (final i in mapJsons) {
      DefaultAssetBundle.of(context).loadString(i).then((value) {
        setState(() {
          mapThemeList.add(value);
          mapTheme = mapThemeList[index];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Style map Example"),
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        style: mapTheme,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            if (index + 1 < mapThemeList.length) {
              setState(() {
                index = index + 1;
                mapTheme = mapThemeList[index];
              });
            } else {
              setState(() {
                index = 0;
                mapTheme = mapThemeList[index];
              });
            }
          },
          child: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
