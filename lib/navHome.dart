import 'dart:convert';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:psychomap/Model/DirectionModel.dart';
import 'package:psychomap/drawer.dart';
import 'package:psychomap/searchPage.dart';
import 'package:http/http.dart' as http;

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
  var cord = [];
  DirectionModel? directionModel;

  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
    marker.add(
        LatLng(widget.start.coordinates![1], widget.start.coordinates![0]));
    marker.add(LatLng(widget.end.coordinates![1], widget.end.coordinates![0]));

    print("--->" + marker.toString());
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
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
              minWidth: 3,
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot != null) {
            directionModel = snapshot.data as DirectionModel;
            print("Error----------->" + snapshot.error.toString());
            if (directionModel == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              //print("route: "+directionModel!.routes![0].legs![0].steps![5].maneuver!.instruction!);
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
                        // PolylineLayerOptions(
                        //   polylines: [
                        //     Polyline(
                        //       points: marker,
                        //       strokeWidth: 5.0,
                        //       color: Colors.red,
                        //       borderStrokeWidth: 0.1
                        //     )
                        //   ]
                        // )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        child: const Text('Show maneuver'),
                        onPressed: () {
                          showFlexibleBottomSheet(
                            minHeight: 0,
                            initHeight: 0.8,
                            maxHeight: 0.8,
                            context: context,
                            builder: _buildBottomSheet,
                            isExpand: true,
                          );
                        },
                      )),
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

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Material(
      child: Container(
        height: 400,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                child: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            ListView.builder(
              controller: scrollController,
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: directionModel!.routes![0].legs![0].steps!.length,
              itemBuilder: (context, index) {
                if (directionModel!.routes![0].legs![0].steps != null) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                directionModel!.routes![0].legs![0]
                                    .steps![index].maneuver!.instruction!,
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          )),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            )
          ],
        ),
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
      print("-------->" + json.decode(response.body).toString());
      directionModel = DirectionModel.fromJson(json.decode(response.body));
    } else {}
    print("uuid------------->" + directionModel!.uuid.toString());
    return directionModel;
  }
}
