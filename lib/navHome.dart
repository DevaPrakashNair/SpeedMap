import 'dart:convert';

import 'package:MyMap/searchPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

import 'package:http/http.dart' as http;

import 'Model/DirectionModel.dart';
import 'drawer.dart';

class NavHome extends StatefulWidget {
  final Geometry start;
  final Geometry end;

  const NavHome({Key? key, required this.start, required this.end})
      : super(key: key);

  @override
  _NavHomeState createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> {
  Position? position;
  var marker = <LatLng>[];
  var polyPoint = <LatLng>[];
  var check = 1;
  DirectionModel? directionModel;

  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
    marker.add(
        LatLng(widget.start.coordinates![1], widget.start.coordinates![0]));
    marker.add(LatLng(widget.end.coordinates![1], widget.end.coordinates![0]));
    polyPoint=[];
    //print("--->" + marker.toString());
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
                Icons.drag_indicator,
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Search()));
              },
              minWidth: 3,
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot != null) {
            directionModel = snapshot.data as DirectionModel;
            //print("Error----------->" + snapshot.error.toString());
            if (directionModel == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              int n = directionModel!.routes![0].legs![0].steps!.length;
              for (int i = 0; i < n; i++) {
                int cordLength=directionModel!.routes![0].geometry!.coordinates!.length;
               // List<dynamic> cord=directionModel!.routes![0].geometry!.coordinates!;
                //
                //  print(cord);
                // for(int j=0;j<cordLength;j++){
                //   polyPoint.add(LatLng(cord[j].[0],cord[j][1] ));
                // }



                polyPoint.add(LatLng(
                    directionModel!
                        .routes![0].legs![0].steps![i].intersections![0]
                        .location![1],
                    directionModel!
                        .routes![0].legs![0].steps![i].intersections![0]
                        .location![0]));
              }
              polyPoint=polyPoint.toSet().toList(); //to remove all duplicate entries



              return Stack(
                children: [
                  SizedBox(
                    //height: MediaQuery.of(context).size.height/1.5,
                    child: FlutterMap(
                      options: MapOptions(
                          bounds: LatLngBounds.fromPoints(marker),
                          //center,
                          onLongPress: (value) {
                            setState(() {});
                            // print("here------------>"+marker[0].longitude.toString());
                          }),
                      layers: [
                        TileLayerOptions(
                            urlTemplate:
                                "https://api.mapbox.com/styles/v1/deva212001/cl5sav1sv000c15qyvxylb4t4/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYW04Z2QwbGNmM2puMDg2bnJpdGZnIn0.TOe4w5OaPTMvGant49e8cA",
                            additionalOptions: {
                              "accessToken":
                                  "pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYXEwZmUwNWp6M2NwM3BzcDF3YmhsIn0.HajoHUCaJ0N7iABkbR7QXg",
                              "id": "mapbox.mapbox-bathymetry-v2"
                            }),
                        MarkerLayerOptions(markers: [
                          for (int i = 0; i < 2; i++) ...[
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
                                          Fluttertoast.showToast(
                                              msg: "touched");
                                        },
                                      ),
                                    ))
                          ]
                        ]),
                          PolylineLayerOptions(polylines: [
                            Polyline(
                                borderColor: Colors.white10,
                                points: polyPoint,//.toSet().toList(),

                                // points: directionModel!.routes![0].geometry!.coordinates as List<LatLng>,
                                strokeWidth: 5.0,
                                color: Colors.red,
                                borderStrokeWidth: 0.1
                            )
                          ]
                          )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CarouselSlider.builder(
                        itemCount:
                            directionModel!.routes![0].legs![0].steps!.length,
                        options: CarouselOptions(
                            autoPlay: false,
                            // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            enableInfiniteScroll: false),
                        itemBuilder: (BuildContext context, int i, int index) =>
                            Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  shadowColor: Colors.black,
                                  child: (directionModel!
                                              .routes![0].legs![0].steps !=
                                          null)
                                      ? Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    directionModel!
                                                        .routes![0]
                                                        .legs![0]
                                                        .steps![index]
                                                        .maneuver!
                                                        .instruction!,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  if (index !=
                                                      directionModel!
                                                              .routes![0]
                                                              .legs![0]
                                                              .steps!
                                                              .length -
                                                          1) ...[
                                                    ((directionModel!
                                                                .routes![0]
                                                                .legs![0]
                                                                .steps![index]
                                                                .distance!) >
                                                            1000)
                                                        ? Text(
                                                            "Distance: ${(directionModel!.routes![0].legs![0].steps![index].distance! / 1000).toStringAsFixed(3)}km",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                          )
                                                        : (directionModel!
                                                                    .routes![0]
                                                                    .legs![0]
                                                                    .steps![
                                                                        index]
                                                                    .distance !=
                                                                0)
                                                            ? Text(
                                                                "Distance: ${(directionModel!.routes![0].legs![0].steps![index].distance!).toStringAsFixed(3)}m",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              )
                                                            : const SizedBox(),
                                                    Text(
                                                        "Duration:${(directionModel!.routes![0].legs![0].steps![index].duration! / 60).toStringAsFixed(2)}min"),
                                                    Text(
                                                        "Fuel consumption\nBike: ${(((directionModel!.routes![0].legs![0].steps![index].distance! / 1000) * 0.03)) < 0.001 ? (((directionModel!.routes![0].legs![0].steps![index].distance! / 1000) * 0.03).toStringAsFixed(5)) : (((directionModel!.routes![0].legs![0].steps![index].distance! / 1000) * 0.03).toStringAsFixed(2))} L\nCar: ${(((directionModel!.routes![0].legs![0].steps![index].distance! / 1000) * 0.1)) < 0.01 ? (((directionModel!.routes![0].legs![0].steps![index].distance! / 1000) * 0.1).toStringAsFixed(5)) : (((directionModel!.routes![0].legs![0].steps![index].distance! / 1000) * 0.1).toStringAsFixed(2))} L")
                                                  ]
                                                ],
                                              ),
                                              const Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Icon(
                                                  Icons.assistant_photo,
                                                  color: Colors.black,
                                                  size: 50,
                                                ),
                                              )
                                            ],
                                          ))
                                      : const SizedBox(),
                                ))),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
        future: getDirection(widget.start, widget.end),
      ),
    );
  }

  Future getDirection(var start, var end) async {
    var start_lat = start.coordinates![0].toString();
    var start_lon = start.coordinates![1].toString();
    var end_lat = end.coordinates![0].toString();
    var end_lon = end.coordinates![1].toString();
    DirectionModel? directionModel;

    String acc_token =
        "pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYW04Z2QwbGNmM2puMDg2bnJpdGZnIn0.TOe4w5OaPTMvGant49e8cA";
    var url =
        "https://api.mapbox.com/directions/v5/mapbox/driving/$start_lat%2C$start_lon%3B$end_lat%2C$end_lon?alternatives=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=$acc_token";

    final response = await http.get(Uri.parse(url));
    //print(response.body);
    if (response.statusCode == 200) {
      //print("-------->" + json.decode(response.body).toString());
      directionModel = DirectionModel.fromJson(json.decode(response.body));
    } else {}
    //print("uuid------------->" + directionModel!.uuid.toString());
    return directionModel;
  }
}
