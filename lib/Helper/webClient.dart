import 'dart:convert';

import 'package:http/http.dart' as http;


class WebClient {

  //static const ip = "https://parishprojects.herokuapp.com";
  //static const ip ="http://192.168.220.171:4000";
  // static const ip="http://192.168.228.171:4000";
  static const ip="http://192.168.43.58:5001";

  static Future<dynamic> post(url, data) async {
    Map? sendData = {};
    if (data?.isNotEmpty ?? false) {
      sendData.addAll(data);
    }
    print(sendData);

    var body = json.encode(sendData);

    var response = await http.post(

      Uri.parse(ip + url),
      headers: {"Content-Type": "application/json",},
      body: body,
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      var error = {
        "status": false,
        "msg": "Something went wrong",
      };
      return error;
    }
  }

  static Future<dynamic> get(url) async {
    var response = await http.get(Uri.parse(ip + url),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {

      var error = {
        "status": false,
        "msg": "Something went wrong",
      };
      return error;
    }
  }
}