import 'dart:io';

import 'package:farmer_app/model/model/custom/NavigationData.dart';
import 'package:farmer_app/view_model/streams/navdata/NavigationDataBLoC.dart';
import 'package:farmer_app/view_model/streams/navdata/NavigationDataEvent.dart';
import 'package:connectivity/connectivity.dart';

Future<bool> common_wait_50ms() async {
  await Future<dynamic>.delayed(const Duration(milliseconds: 50));
  return true;
}

bool isresponseSuccessfull(int statusCode) {
  bool isSuccessfull = false;
  if (statusCode >= 200 && statusCode < 300) {
    isSuccessfull = true;
  }
  return isSuccessfull;
}

refresh_W_Data_IsValid_NavigationDataBLoC(
  bool isvalid,
  NavigationDataBLoC navigationDataBLoC,
  String? message,
) {
  if (navigationDataBLoC != null) {
    NavigationData navigationData = NavigationData();
    navigationData.isValid = isvalid;
    navigationData.message = message;
    navigationDataBLoC.dailySubTaskimages_event_sink
        .add(NavigationDataAddedEvent(navigationData));
  }
}

refresh_WO_Data_NavigationDataBLoC(
  NavigationDataBLoC navigationDataBLoC,
) {
  if (navigationDataBLoC != null) {
    NavigationData navigationData = NavigationData();
    navigationDataBLoC.dailySubTaskimages_event_sink
        .add(NavigationDataAddedEvent(navigationData));
  }
}


Future<bool> isNetworkConnectionActive() async {
  /*var connectivityResult = await (Connectivity().checkConnectivity());
  bool isConnected = false;
  if (connectivityResult != ConnectivityResult.none) {
    isConnected = true;
  }
  return isConnected;*/
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}