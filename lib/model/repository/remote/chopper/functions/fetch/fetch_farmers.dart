import 'package:farmer_app/model/entities/moor/dao/MrfarmDao.dart';
import 'package:farmer_app/model/entities/moor/dao/MrfarmerDao.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/repository/local/db/farmers/FarmerDao.dart';
import 'package:farmer_app/model/repository/remote/chopper/setup/post_api_service.dart';
import 'package:farmer_app/utils/functions/common_functions.dart';
import 'package:farmer_app/view/screens/HomeScreen.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_bloc.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_event.dart';
import 'package:farmer_app/view_model/counter/CounterChangeNotifier.dart';
import 'package:farmer_app/view_model/objconverters/farm/FarmRespJModelConverterInterface.dart';
import 'package:farmer_app/view_model/objconverters/farmer/FarmerRespJModelConverter.dart';
import 'package:farmer_app/view_model/objconverters/farmer/FarmerRespJModelConverterInterface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chopper/chopper.dart';

import 'dart:math';

Future<List<FarmerRespJModel>?> req_fetch_farmers(
  bool savelocally,
  BuildContext buildContext,
) async {
  String TAG = "req_fetch_farmers:";
  print(TAG);
  PostApiService postApiService = PostApiService.create();
  Response serviceresponse = await postApiService.get_farmers();
  int statusCode = serviceresponse.statusCode;

  if (isresponseSuccessfull(statusCode)) {
    try {
      var respBody = serviceresponse.body;
      List<FarmerRespJModel> farmerRespJModelList =
          (respBody as List).map((i) => FarmerRespJModel.fromJson(i)).toList();

      if (savelocally) {
        //await insertBatch_FarmerRespJModel(farmerRespJModelList);
        //save to moor
        print(TAG + " frmerlist==${farmerRespJModelList.length}");
        MrfarmerDao mrfarmerDao =
            Provider.of<AppDatabase>(buildContext, listen: false).mrfarmerDao;
        print(TAG + " frmerlist mrfarmerDao");
        List<MrfarmersCompanion> frmerlist =
            getIt<FarmerRespJModelConverterInterface>()
                .getEntitiesCompFromFarmerRespJModelList(farmerRespJModelList);
        print(TAG + " frmerlist==");
        print(TAG + " frmerlist=" + '${frmerlist.length}');
        await mrfarmerDao.upsertAllMrfarmersByOnlineIdCompanion(frmerlist);

        //upsert farms
        List<FarmRespJModel> farmRespJModelList = [];
        for (FarmerRespJModel farmer in farmerRespJModelList) {
          if (farmer.farms != null) {
            farmRespJModelList.addAll(farmer.farms as Iterable<FarmRespJModel>);
          }
        }
        MrfarmDao mrfarmDao =
            Provider.of<AppDatabase>(buildContext, listen: false).mrfarmDao;
        //mrfarmDao.updateAllMrfarmsCompanion(onlineuserCompanionList)
        //end of upsert farms
      }
      return farmerRespJModelList;
    } catch (error) {
      return null;
    }
  } else {
    print(TAG + " !isresponseSuccessfull");
    print(serviceresponse.bodyString);
    return null;
  }
}

//json store
