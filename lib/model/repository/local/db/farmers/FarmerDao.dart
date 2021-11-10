import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/model/repository/local/db/farmers/FarmDao.dart';
import 'package:farmer_app/view_model/objconverters/farm/FarmRespJModelConverterInterface.dart';
import 'package:farmer_app/view_model/objconverters/farmer/FarmerRespJModelConverter.dart';
import 'package:farmer_app/view_model/objconverters/farmer/FarmerRespJModelConverterInterface.dart';
import 'package:flutter/material.dart';
import 'package:json_store/json_store.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:provider/provider.dart';

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

Future<List<FarmerRespJModel>> load_FarmerRespJModel_local(
    BuildContext buildContext) async {
  List<Mrfarmer> farmerlist =
      await Provider.of<AppDatabase>(buildContext, listen: false)
          .mrfarmerDao
          .getMrfarmersByActive();
  //.getAllMrfarmers();
  return getIt<FarmerRespJModelConverterInterface>()
      .getFarmerRespJModelListFromEntities(farmerlist);
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

Future<List<FarmerRespJModel>> search_FarmerRespJModel_local(
  String keyword,
  BuildContext buildContext,
) async {
  print("keyword ${keyword}");
  List<Mrfarmer> farmerlist =
      await Provider.of<AppDatabase>(buildContext, listen: false)
          .mrfarmerDao
          .getMrfarmersByName(keyword);
  return getIt<FarmerRespJModelConverterInterface>()
      .getFarmerRespJModelListFromEntities(farmerlist);
}

Future<bool> farmer_dao_updateFarmerlocal(
  FarmerRespJModel farmerRespJModel,
  BuildContext buildContext,
) async {
  MrfarmersCompanion farmlisfarmtcomp =
      getIt<FarmerRespJModelConverterInterface>()
          .getEntityCompFromFarmerRespJModelWId(farmerRespJModel);

  bool upserted = await Provider.of<AppDatabase>(buildContext, listen: false)
      .mrfarmerDao
      .updateMrfarmerById(farmlisfarmtcomp);
  return upserted;
}

Future<int> farmer_dao_insertFarmerlocal(
  FarmerRespJModel farmerRespJModel,
  BuildContext buildContext,
) async {
  MrfarmersCompanion farmlisfarmtcomp =
      getIt<FarmerRespJModelConverterInterface>()
          .getEntityCompFromFarmerRespJModel(farmerRespJModel);

  int insertedid = await Provider.of<AppDatabase>(buildContext, listen: false)
      .mrfarmerDao
      .insertMrfarmersCompanion(farmlisfarmtcomp);
  return insertedid;
}

Future<bool> farmer_dao_deleteFarmerlocal(
  int farmid,
  BuildContext buildContext,
) async {
  bool isdeleted = await Provider.of<AppDatabase>(buildContext, listen: false)
      .mrfarmerDao
      .softdeleteMrfarmersCompanion(farmid);
  return isdeleted;
}
