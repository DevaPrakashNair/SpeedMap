import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'Model/WeatherModel.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  Position? position;
  List<Placemark>? place;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getLoc();
  }
  getLoc()async{
    Geolocator.requestPermission();
    position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {

    });
    if(position!=null){
      place = await placemarkFromCoordinates(position!.latitude, position!.longitude,localeIdentifier: "en");
      print(place);
    }

  }


  @override
  WeatherModel? _weather;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Weather information",style: TextStyle(color: Colors.white70),),
        backgroundColor: Colors.black,
      ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot != null) {
                  this._weather = snapshot.data as WeatherModel;
                  if (this._weather == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return  Align(
                      alignment: Alignment.bottomRight,
                        child: weatherBox(_weather!)
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
              future: getCurrentWeather(),
            ),
          ),
        )
    );
  }
  Widget weatherBox(WeatherModel _weather) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.orange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(

                ),
                Text(
                  _weather.name!,
                  style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.w700,
                      fontSize: 20
                  ),
                ),
                Row(
                  children: [

                    Text(
                      _weather.main!.temp.toString()+"°c",
                      style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.w700,
                        fontSize: 70
                      ),
                    ),
                    Image.network("http://openweathermap.org/img/wn/"+_weather.weather![0].icon!+"@2x.png")
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const SizedBox (
                  height: 10,
                ),
                const Text("Details",
                  style: TextStyle(color: Colors.black,
                    fontSize: 25,fontWeight: FontWeight.w700
                  ),),
                const Divider(
                  color: Colors.lightBlueAccent,
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Wind",
                    style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.w500
                    ),),
                    Text(_weather.wind!.speed.toString()+" m/s",style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.w500
                    ))
                  ],
                ),
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Presssure",
                      style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.w500
                      ),),
                    Text(_weather.main!.pressure.toString()+" hPa",style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.w500
                    ))
                  ],
                ),
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Humidity",
                      style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.w500
                      ),),
                    Text(_weather.wind!.speed.toString()+" %",style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.w500
                    ))
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Visibility",
                      style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.w500
                      ),),
                    Text(_weather.visibility.toString(),style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.w500
                    ))
                  ],
                )
              ],
            ),
          )
        ]
    );
  }
  Future getCurrentWeather() async {

    WeatherModel? weather;

    String lat=position!.latitude.toString();
    String lon=position!.longitude.toString();

    String apiKey = "5b6906720382e407972d75013849d0b7";
    var url = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(
      Uri.parse(url)
    );

    if (response.statusCode == 200) {
      weather = WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      // TODO: Throw error here
    }
    print(response.statusCode);
    return weather;
  }
}


