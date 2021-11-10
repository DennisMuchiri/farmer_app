import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/view_model/objconverters/farm/FarmRespJModelConverterInterface.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_store/json_store.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:provider/provider.dart';

String farmdb = "farmdb";
Future<void> insert_FarmRespJModel(FarmRespJModel farm) async {
  return await JsonStore().setItem(
    '$farmdb-${farm.id}${farm.farm_name}${farm.farm_size}',
    farm.toJson(),
    encrypt: true,
  );
}

Future<void> insertBatch_FarmRespJModel(
    List<FarmRespJModel> farmerRespJModelList) async {
  Batch batch = await JsonStore().startBatch();
  await Future.forEach(farmerRespJModelList, (FarmRespJModel farm) async {
    //await JsonStore().deleteItem('$farmdb-${farm.id}${farm.farm_name}${farm.farm_size}');
    await JsonStore().setItem(
      '$farmdb-${farm.id}${farm.farm_name}${farm.farm_size}',
      farm.toJson(),
      batch: batch,
      encrypt: true,
    );
  });
  return await JsonStore().commitBatch(batch);
}

Future<List<FarmRespJModel>> load_FarmRespJModel() async {
  List<Map<String, dynamic>>? json = await JsonStore().getListLike('$farmdb-%');

  List<FarmRespJModel> _farmers = json != null
      ? json.map((messageJson) => FarmRespJModel.fromJson(messageJson)).toList()
      : [];

  return _farmers;
}

Future<List<FarmRespJModel>> load_Farms_For_FarmerRespJModel(int id) async {
  List<Map<String, dynamic>>? json = await JsonStore().getListLike('$farmdb-%');
  print("id $id");

  List<FarmRespJModel> _farmers = json != null
      ? json.map((messageJson) => FarmRespJModel.fromJson(messageJson)).toList()
      : [];
  print("_farmers ${_farmers.length}");
  List<FarmRespJModel> _filteredfarms = _farmers;
  if (_farmers.length > 0) {
    _filteredfarms = _farmers.where(
      (obj) {
        return obj.farmer == id;
      },
    ).toList();
  }
  print("_filteredfarms ${_filteredfarms.length}");

  return _filteredfarms;
}

Future<List<FarmRespJModel>> load_Farms_For_FarmerRespJModel_local(
  int farmerid,
  BuildContext buildContext,
) async {
  List<Mrfarm> farmlist =
      await Provider.of<AppDatabase>(buildContext, listen: false)
          .mrfarmDao
          .getMrfarmsByFarmerId(farmerid);
  return getIt<FarmRespJModelConverterInterface>()
      .getFarmRespJModelListFromEntities(farmlist);
}

Future<bool> frm_dao_updateFarmlocal(
  FarmRespJModel farmRespJModel,
  BuildContext buildContext,
) async {
  MrfarmsCompanion farmlisfarmtcomp = getIt<FarmRespJModelConverterInterface>()
      .getEntityCompFromFarmRespJModelWId(farmRespJModel);

  bool upserted = await Provider.of<AppDatabase>(buildContext, listen: false)
      .mrfarmDao
      .updateMrfarmById(farmlisfarmtcomp);
  return upserted;
}

Future<int> frm_dao_insertFarmlocal(
  FarmRespJModel farmRespJModel,
  BuildContext buildContext,
) async {
  MrfarmsCompanion farmlisfarmtcomp = getIt<FarmRespJModelConverterInterface>()
      .getEntityCompFromFarmRespJModel(farmRespJModel);

  int insertedid = await Provider.of<AppDatabase>(buildContext, listen: false)
      .mrfarmDao
      .insertMrfarmsCompanion(farmlisfarmtcomp);
  return insertedid;
}
