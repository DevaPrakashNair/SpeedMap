import 'package:MyMap/weather_app.dart';
import 'package:flutter/material.dart';

import 'Review.dart';


class Drawer_Tab {
  Widget build(BuildContext context, setState) {
    return Drawer(
      child: Column(
        children:  [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Center(
                  child: Text(
                "Welcome",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ))),
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeatherPage()));
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Weather",style: TextStyle(fontSize: 25),),
                ],
              ),
            )
          ),
          Divider(),
          InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Review()));
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Review",style: TextStyle(fontSize: 25),),
                  ],
                ),
              )
          ),
          Divider(),
          InkWell(
              onTap: (){

              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("",style: TextStyle(fontSize: 25),),
                  ],
                ),
              )
          ),
          //Divider(),
          InkWell(
              onTap: (){

              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 5, 5, 10),
                      child: Text("",style: TextStyle(fontSize: 25),),
                    ),
                  ],
                ),
              )
          ),
          //Divider(),
        ],
      ),
    );
  }
}
