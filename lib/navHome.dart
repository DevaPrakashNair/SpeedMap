import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:psychomap/drawer.dart';
import 'package:psychomap/searchPage.dart';
import 'package:http/http.dart' as http;


class NavHome extends StatefulWidget {
  final Geometry start;
  final Geometry end;
  const NavHome({Key? key,required this.start,required this.end}) : super(key: key);

  @override
  _NavHomeState createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> {
  Position? position;
  var marker=<LatLng>[];

  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
    marker.add(LatLng(widget.start.coordinates![1], widget.start.coordinates![0]));
    marker.add(LatLng(widget.end.coordinates![1], widget.end.coordinates![0]));

    print("--->"+marker.toString());
  }

  getLoc() async {
    Geolocator.requestPermission();
    position !=
        await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer_Tab().build(context, setState),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: Colors.white,
              icon: const Icon(
                Icons.drag_indicator ,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Maps",
              style: TextStyle(color: Colors.white),
            ),
            MaterialButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Search()));
              },
              child: Icon(Icons.search,color: Colors.white,size: 35,),
              minWidth: 3,
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if(snapshot != null){
            if(snapshot.data == null){
              return Text("Error");
            }
            else{
              return FlutterMap(
                options: MapOptions(
                  //zoom: LatLngBounds(marker[0]) as double,
                    center: marker[0],
                    onLongPress: (value){
                      setState(() {
                      });
                      // print("here------------>"+marker[0].longitude.toString());
                    }
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                      "https://api.mapbox.com/styles/v1/deva212001/cl5sav1sv000c15qyvxylb4t4/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYW04Z2QwbGNmM2puMDg2bnJpdGZnIn0.TOe4w5OaPTMvGant49e8cA",
                      additionalOptions: {
                        "accessToken":
                        "pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYXEwZmUwNWp6M2NwM3BzcDF3YmhsIn0.HajoHUCaJ0N7iABkbR7QXg",
                        "id": "mapbox.mapbox-bathymetry-v2"
                      }),
                  MarkerLayerOptions(
                      markers: [
                        for(int i=0;i<2;i++)...[
                          Marker(
                              width: 45.0,
                              height: 45.0,
                              point: marker[i],
                              builder: (context) => Container(
                                child: IconButton(
                                  icon: Icon(Icons.location_on),
                                  color: Colors.red,
                                  iconSize: 45.0,
                                  onPressed: () {
                                    Fluttertoast.showToast(msg: "touched");
                                  },
                                ),
                              ))
                        ]
                      ]
                  ),
                ],
              );
            }
          }
          else{
            return const CircularProgressIndicator();
          }
        },
        future: getDirection(widget.start,widget.end),
        ),
      );
  }

  Future getDirection(Geometry start,Geometry end) async{
    var a=start.coordinates;
    var b=end.coordinates;
    var url="https://api.mapbox.com/directions/v5/mapbox/driving/"+a![0].toString()+".%2C"+a![1].toString()+"%3B"+b![0].toString()+"%2C"+b![1].toString()+"?alternatives=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYW04Z2QwbGNmM2puMDg2bnJpdGZnIn0.TOe4w5OaPTMvGant49e8cA";

    final response= await http.get(
      Uri.parse(url)
    );

    print(response.body);
  }
}
