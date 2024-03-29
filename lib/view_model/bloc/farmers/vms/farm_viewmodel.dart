import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/model/repository/local/db/farmers/FarmDao.dart';
import 'package:farmer_app/view_model/bloc/farms/bloc/farm_respjmodel_bloc.dart';
import 'package:farmer_app/view_model/bloc/farms/bloc/farm_respjmodel_bloc_event.dart';
import 'package:flutter/widgets.dart';

class FarmListVM {
  FarmListVM({
    this.farmRespJModelBloc,
  });
  FarmRespJModelBloc? farmRespJModelBloc;

  Future<List<FarmRespJModel>?> fetchFarmsFromFarm(
      FarmerRespJModel? farmerRespJModel) async {
    List<FarmRespJModel>? _farmRespJModelList = farmerRespJModel?.farms;

    if (_farmRespJModelList != null) {
      farmRespJModelBloc?.add(FarmObjChanged(_farmRespJModelList));
    }
  }

  Future<List<FarmRespJModel>?> fetchFarmsFromFarmer(int farmerid) async {
    List<FarmRespJModel>? _farmRespJModelList =
        await load_Farms_For_FarmerRespJModel(farmerid);

    if (_farmRespJModelList != null) {
      farmRespJModelBloc?.add(FarmObjChanged(_farmRespJModelList));
    }
  }

  Future<List<FarmRespJModel>?> fetchFarmsFromFarmerlocal(
    int farmerid,
    BuildContext buildContext,
  ) async {
    List<FarmRespJModel>? _farmRespJModelList =
        await load_Farms_For_FarmerRespJModel_local(farmerid, buildContext);

    if (_farmRespJModelList != null) {
      farmRespJModelBloc?.add(FarmObjChanged(_farmRespJModelList));
    }
  }

  Future<void> saveFarm(FarmRespJModel farmRespJModel) async {
    return await insert_FarmRespJModel(farmRespJModel);
  }



  Future<bool> updateFarmlocal(
      FarmRespJModel farmRespJModel, BuildContext buildContext) async {
    bool issaved = await frm_dao_updateFarmlocal(farmRespJModel, buildContext);
    return issaved;
  }

  Future<int> insertFarmlocal(
      FarmRespJModel farmRespJModel, BuildContext buildContext) async {
    int issavedid = await frm_dao_insertFarmlocal(farmRespJModel, buildContext);
    return issavedid;
  }

  Future<bool> deleteFarmlocal(
     int farmid, BuildContext buildContext) async {
    bool isdeleted = await frm_dao_deleteFarmlocal(farmid, buildContext);
    return isdeleted;
  }
}
