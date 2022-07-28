import 'package:flutter/material.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'homePage.dart';
import 'navHome.dart';

class Search2 extends StatefulWidget {
  final Geometry start;
  Search2({Key? key,required this.start}) : super(key: key);

  @override
  _Search2State createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  final _endPointController = TextEditingController();
  var end=Geometry();
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
              hintText: "Select ending point",
              textController: _endPointController,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapBoxAutoCompleteWidget(
                      apiKey: "pk.eyJ1IjoiZGV2YTIxMjAwMSIsImEiOiJjbDVzYXEwZmUwNWp6M2NwM3BzcDF3YmhsIn0.HajoHUCaJ0N7iABkbR7QXg",
                      hint: "Select ending point",
                      onSelect: (place) {
                        // TODO : Process the result gotten
                        _endPointController.text = place.placeName!;
                        end=place.geometry!;
                        return;
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
                  if(end.coordinates!=null){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavHome(end: end, start: widget.start,)));
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
