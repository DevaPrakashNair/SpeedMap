


import 'package:MyMap/Helper/webClient.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/enterReviewModel.dart';
import '../Model/viewReviewModel.dart';

class Repository{
  Future<EnterReviewModel> review({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final EnterReviewModel reviewModel = EnterReviewModel.fromJson(response);
    return reviewModel;
  }

  Future<ViewReviewModel> viewreview({required String url}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final ViewReviewModel viewModel = ViewReviewModel.fromJson(response);
    return viewModel;
  }
  
}