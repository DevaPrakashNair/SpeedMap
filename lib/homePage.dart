
import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Title of the "),
        ),
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                Text("Home"),
                Divider(),
                Text("Review"),
                Divider(),
                Text("Map"),
                Divider(),
              ],
            ),
          ),
        ),
        body: GoogleMapsWidget(
          apiKey: "YOUR KEY HERE",
          sourceLatLng: LatLng(40.484000837597925, -3.369978368282318),
          destinationLatLng: LatLng(40.48017307700204, -3.3618026599287987),
        ),
      ),
    );
  }
}
