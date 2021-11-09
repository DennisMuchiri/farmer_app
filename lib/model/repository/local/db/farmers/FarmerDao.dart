import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/model/repository/local/db/farmers/FarmDao.dart';
import 'package:flutter/material.dart';
import 'package:json_store/json_store.dart';
import 'package:sqflite/sqlite_api.dart';

String farmer = "farmer";

Future<void> insertBatch_FarmerRespJModel(
    List<FarmerRespJModel> farmerRespJModelList) async {
  await JsonStore().clearDataBase();
  Batch batch = await JsonStore().startBatch();
  await Future.forEach(farmerRespJModelList, (FarmerRespJModel farmr) async {
    await JsonStore().setItem(
      '$farmer-${farmr.id}${farmr.first_name}${farmr.last_name}${farmr.gender}',
      farmr.toJson(),
      batch: batch,
      encrypt: true,
    );
    //set farms for farmer
    List<FarmRespJModel>? farmsforfarmer = farmr.farms;
    if (farmsforfarmer != null && farmsforfarmer.isNotEmpty) {
      for (FarmRespJModel farm in farmsforfarmer) {
        farm.farmer = farmr.id;
      }
      insertBatch_FarmRespJModel(farmsforfarmer);
    }
  });

  return await JsonStore().commitBatch(batch);
}

Future<List<FarmerRespJModel>> load_FarmerRespJModel() async {
  List<Map<String, dynamic>>? json = await JsonStore().getListLike('$farmer-%');

  List<FarmerRespJModel> _farmers = json != null
      ? json
          .map((messageJson) => FarmerRespJModel.fromJson(messageJson))
          .toList()
      : [];

  return _farmers;
}

Future<List<FarmerRespJModel>> search_FarmerRespJModel(String keyword) async {
  List<Map<String, dynamic>>? json = await JsonStore().getListLike(
    '%$keyword%',
  );

  List<FarmerRespJModel> _farmers = json != null
      ? json
          .map((messageJson) => FarmerRespJModel.fromJson(messageJson))
          .toList()
      : [];

  return _farmers;
}
