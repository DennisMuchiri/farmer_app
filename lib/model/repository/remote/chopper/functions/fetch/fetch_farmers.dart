import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/repository/remote/chopper/setup/post_api_service.dart';
import 'package:farmer_app/utils/functions/common_functions.dart';
import 'package:farmer_app/view/screens/HomeScreen.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_bloc.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_event.dart';
import 'package:farmer_app/view_model/counter/CounterChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chopper/chopper.dart';

Future<List<FarmerRespJModel>?> req_fetch_farmers() async {
  PostApiService postApiService = getIt<PostApiService>();
  Response serviceresponse = await postApiService.get_farmers();
  int statusCode = serviceresponse.statusCode;

  if (isresponseSuccessfull(statusCode)) {
    try {
      var respBody = serviceresponse.body;
      List<FarmerRespJModel> farmerRespJModelList =
          (respBody as List).map((i) => FarmerRespJModel.fromJson(i)).toList();


      return farmerRespJModelList;
    } catch (error) {
      return null;
    }
  } else {
    return null;
  }
}
