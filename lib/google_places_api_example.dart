//In this example we will use google places api to search places
//I didn't test the code because my google maps account is giving me error but it's almost like this.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiExample extends StatefulWidget {
  const GooglePlacesApiExample({super.key});

  @override
  State<GooglePlacesApiExample> createState() => _GooglePlacesApiExampleState();
}

class _GooglePlacesApiExampleState extends State<GooglePlacesApiExample> {
  final TextEditingController _searchTextController = TextEditingController();
  List<dynamic> placesNames = [];
  @override
  void initState() {
    _searchTextController.addListener(() {
      searchPlaces(_searchTextController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Search Apo Example"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
                "This example is not working because my billing account is having issue in google console, You can also find the code for this on my github"),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(),
              ),
              controller: _searchTextController,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: placesNames.length,
                itemBuilder: (context, index) {
                  return Text(placesNames[index]["description"]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchPlaces(String placeName) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$placeName&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=AIzaSyDrQBX6vuO8ON-i3wk32WHstAZ30lbJ958';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        placesNames = jsonDecode(response.body.toString())["predictions"];
      });
    } else {
      debugPrint("Failed");
    }
  }
}
