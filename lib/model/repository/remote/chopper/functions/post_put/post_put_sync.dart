import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/to/farmer/FarmReqJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/to/farmer/FarmerReqJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/to/farmer/FarmerSyncReqJModel.dart';
import 'package:farmer_app/model/repository/local/db/farmers/FarmDao.dart';
import 'package:farmer_app/model/repository/local/db/farmers/FarmerDao.dart';
import 'package:farmer_app/model/repository/remote/chopper/setup/post_api_service.dart';
import 'package:chopper/chopper.dart';
import 'package:farmer_app/utils/statics/farmer_app_static_params.dart';
import 'dart:io';
import 'package:moor/moor.dart';
import 'dart:isolate';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:moor/isolate.dart';
import 'package:farmer_app/utils/functions/common_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as fpath;
import 'dart:isolate';

void post_put_sync(AppDatabase appDatabase) async {
  String TAG = "post_put_sync:";
  print(TAG);
  FarmerSyncReqJModel farmerSyncReqJModel = FarmerSyncReqJModel();
  //Query changes
  //Farmers
  List<FarmerRespJModel> newfarmerlist =
      await farmerdao_getNewFarmers(appDatabase);
  if (newfarmerlist != null && newfarmerlist.length > 0) {
    farmerSyncReqJModel.new_farmers =
        getFarmerReqJModelListFromFarmerRespJModelList(newfarmerlist);
  }

  List<FarmerRespJModel> updatedfarmerlist =
      await farmerdao_getUpdatedFarmers(appDatabase);
  if (updatedfarmerlist != null && updatedfarmerlist.length > 0) {
    farmerSyncReqJModel.updated_farmers =
        getFarmerReqJModelListFromFarmerRespJModelList(updatedfarmerlist);
  }

  List<FarmerRespJModel> deletedfarmerlist =
      await farmerdao_getDeletedFarmers(appDatabase);
  if (deletedfarmerlist != null && deletedfarmerlist.length > 0) {
    farmerSyncReqJModel.deleted_farmers =
        getFarmerReqJModelListFromFarmerRespJModelList(deletedfarmerlist);
  }
  //end of Farmers

  //Farms
  List<FarmRespJModel> newfarmlist = await farmdao_getNewFarms(appDatabase);
  if (newfarmlist != null && newfarmlist.length > 0) {
    farmerSyncReqJModel.new_farms =
        getFarmReqJModelListFromFarmRespJModelList(newfarmlist);
  }

  List<FarmRespJModel> updatedfarmlist =
      await farmdao_getUpdatedFarmers(appDatabase);
  if (updatedfarmlist != null && updatedfarmlist.length > 0) {
    farmerSyncReqJModel.updated_farms =
        getFarmReqJModelListFromFarmRespJModelList(updatedfarmlist);
  }
  List<FarmRespJModel> deletedfarmlist =
      await farmerdao_getDeletedFarms(appDatabase);
  if (deletedfarmlist != null && deletedfarmlist.length > 0) {
    farmerSyncReqJModel.delete_farms =
        getFarmReqJModelListFromFarmRespJModelList(deletedfarmlist);
  }
  //end of Farms
  //prepare json
  log("preparing to post==" +
      json.encode(farmerSyncReqJModel.toJson()).toString());
  //post
  if (farmerSyncReqJModel != null &&
      ((farmerSyncReqJModel.new_farms != null &&
              farmerSyncReqJModel.new_farms!.isNotEmpty) ||
          (farmerSyncReqJModel.updated_farms != null &&
              farmerSyncReqJModel.updated_farms!.isNotEmpty) ||
          (farmerSyncReqJModel.delete_farms != null &&
              farmerSyncReqJModel.delete_farms!.isNotEmpty) ||
          (farmerSyncReqJModel.new_farmers != null &&
              farmerSyncReqJModel.new_farmers!.isNotEmpty) ||
          (farmerSyncReqJModel.updated_farmers != null &&
              farmerSyncReqJModel.updated_farmers!.isNotEmpty) ||
          (farmerSyncReqJModel.deleted_farmers != null &&
              farmerSyncReqJModel.deleted_farmers!.isNotEmpty))) {
    print(TAG + " values to sync are present- continue");
  } else {
    print(TAG + " return-no values to sync");
    return;
  }
  print(TAG + " posting via chopper");
  PostApiService postApiService = PostApiService.create();
  Response response =
      await postApiService.post_farmers(farmerSyncReqJModel.toJson());
  int statusCode = response.statusCode;
  if (isresponseSuccessfull(statusCode)) {
    try {
      var respBody = response.body;
      log(TAG + " respBody==" + respBody.toString());
    } catch (error) {
      print(error.toString());
    }
  } else {
    print(response.body.toString());
    print(response.bodyString.toString());
  }
  print(TAG + ' SYNC DONE');
}

//isolates
//prepare isolate
//main
bool _isolaterunning = false;
post_put_sync_isolate() async {
  String TAG = "post_put_sync_isolate:";
  print(TAG);
  if (_isolaterunning) {
    print(TAG + " _isolaterunning RETURN");
    return;
  }
  var moorIsolate = await _createMoorIsolate();

  Map paramMap = Map();
  paramMap[FarmerAppStaticParams.moorIsolate] = moorIsolate;

  var receivePort_CallBack = ReceivePort();
  _IsolateStartRequest isolateStartRequestCallback =
      _IsolateStartRequest(receivePort_CallBack.sendPort, '');
  paramMap[FarmerAppStaticParams.isolateStartRequestCallback] =
      isolateStartRequestCallback;

  _isolaterunning = true;
  Isolate? syncAllDataInComputeIsolate =
      await Isolate.spawn(syncAllDataInCompute, paramMap);

  /*try {
    print(TAG + ' syncAllDataInComputeIsolate.kill==2');
    if (syncAllDataInComputeIsolate != null) {
      syncAllDataInComputeIsolate.kill(priority: 0);
      syncAllDataInComputeIsolate = null;
      _isolaterunning = false;
    }
  } catch (error) {
    print(TAG + ' syncAllDataInComputeIsolate.kill error==2');
    print(error.toString());
  }*/
}

Future<void> syncAllDataInCompute(Map paramMap) async {
  configureInjection(Env.dev);
  String TAG = "syncAllDataInCompute:";
  print(TAG);
  MoorIsolate moorIsolate = paramMap[FarmerAppStaticParams.moorIsolate];
  DatabaseConnection dbConnection = await moorIsolate.connect();
  AppDatabase database = AppDatabase.connect(dbConnection);
  Timer.periodic(Duration(hours: 1), (Timer t) {
    print(TAG + " timer periodic 1 hr firing");
    syncAllData_Isolate(
      paramMap,
      database,
    );
  });
}

syncAllData_Isolate(Map paramMap, AppDatabase database) async {
//run syncs
  post_put_sync(database);
}

//moor
Future<MoorIsolate> _createMoorIsolate() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final path = fpath.join(dbFolder.path, 'frmdb.sqlite');
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );
  return (await receivePort.first as MoorIsolate);
}

void _startBackground(_IsolateStartRequest request) {
  final executor = VmDatabase(File(request.targetPath), logStatements: true);
  final moorIsolate = MoorIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  request.sendMoorIsolate.send(moorIsolate);
}
//prepare isolate

//isolate class
class _IsolateStartRequest {
  final SendPort sendMoorIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendMoorIsolate, this.targetPath);
}
//end of isolate class

//end of isolates

FarmerReqJModel getFarmerReqJModelFromFarmerRespJModel(FarmerRespJModel frm) {
  FarmerReqJModel freq = FarmerReqJModel();
  freq.id = ((frm.onlineid != null ? frm.onlineid : null));
  freq.first_name = ((frm.first_name != null ? frm.first_name : null));
  freq.last_name = ((frm.last_name != null ? frm.last_name : null));
  freq.member_number = ((frm.member_number != null ? frm.member_number : null));
  freq.gender = ((frm.gender != null ? frm.gender : null));
  freq.phone_number = ((frm.phone_number != null ? frm.phone_number : null));
  freq.email = ((frm.email != null ? frm.email : null));
  return freq;
}

List<FarmerReqJModel> getFarmerReqJModelListFromFarmerRespJModelList(
    List<FarmerRespJModel> fresplist) {
  List<FarmerReqJModel> newfarmerReqlist = [];
  for (FarmerRespJModel frmr in fresplist) {
    if (frmr != null) {
      FarmerReqJModel freq = getFarmerReqJModelFromFarmerRespJModel(frmr);
      newfarmerReqlist.add(freq);
    }
  }
  return newfarmerReqlist;
}

List<FarmReqJModel> getFarmReqJModelListFromFarmRespJModelList(
    List<FarmRespJModel> fresplist) {
  List<FarmReqJModel> newfarmReqlist = [];
  for (FarmRespJModel frmr in fresplist) {
    if (frmr != null) {
      FarmReqJModel freq = getFarmReqJModelFromFarmRespJModel(frmr);
      newfarmReqlist.add(freq);
    }
  }
  return newfarmReqlist;
}

FarmReqJModel getFarmReqJModelFromFarmRespJModel(FarmRespJModel resp) {
  FarmReqJModel req = FarmReqJModel();

  req.id = ((resp.onlineid != null ? resp.onlineid : null));
  req.farm_name = ((resp.farm_name != null ? resp.farm_name : null));
  req.farm_size = ((resp.farm_size != null ? resp.farm_size : null));

  return req;
}
