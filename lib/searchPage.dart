import 'package:flutter/material.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:psychomap/searchPage2.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _startPointController = TextEditingController();
  var start=Geometry();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            CustomTextField(
              hintText: "Select starting point",
              textController: _startPointController,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapBoxAutoCompleteWidget(
                      apiKey: "pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYXEwZmUwNWp6M2NwM3BzcDF3YmhsIn0.HajoHUCaJ0N7iABkbR7QXg",
                      hint: "Select starting point",
                      onSelect: (place) {
                        // TODO : Process the result gotten
                        _startPointController.text = place.placeName!;
                        start=place.geometry!;
                        return;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Search2(start: place.geometry!)));

                      },
                      limit: 10,
                    ),
                  ),
                );

              },
              enabled: true,
            ),
            MaterialButton(
              child: Text("OK"),
              color: Colors.green,
                onPressed: (){
                if(start.coordinates!=null){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search2(start: start)));
                }
                else{
                  Fluttertoast.showToast(msg: "Empty search");
                }
            })
          ],
        ),
      ),
    );
  }
}
