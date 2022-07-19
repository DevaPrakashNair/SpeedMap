import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:psychomap/drawer.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  Position? position;
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }
  getLoc()async{
    Geolocator.requestPermission();
    position!=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {

    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer_Tab().build(context, setState),
      appBar: AppBar(
        title: Text("Maps",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: FlutterMap(
          options: MapOptions(
              center: LatLng(9.528878, 76.823465  )),
          layers: [
            TileLayerOptions(
                urlTemplate:
                "https://api.mapbox.com/styles/v1/deva212001/cl5sav1sv000c15qyvxylb4t4/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYW04Z2QwbGNmM2puMDg2bnJpdGZnIn0.TOe4w5OaPTMvGant49e8cA",
                additionalOptions: {
                  "accessToken":"pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYXEwZmUwNWp6M2NwM3BzcDF3YmhsIn0.HajoHUCaJ0N7iABkbR7QXg",
                  "id":"mapbox.mapbox-bathymetry-v2"
    }),
            MarkerLayerOptions(markers: [
              Marker(
                  width: 45.0,
                  height: 45.0,
                  point: LatLng(40.73, -74.00),
                  builder: (context) => Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45.0,
                      onPressed: () {
                        print('Marker tapped');
                      },
                    ),
                  ))
            ])
          ]),
    );
  }
}
