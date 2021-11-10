import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/model/repository/local/db/farmers/FarmerDao.dart';
import 'package:farmer_app/model/repository/remote/chopper/functions/fetch/fetch_farmers.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_bloc.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_bloc_event.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:farmer_app/model/repository/local/counter/i_counter_repository.dart';

class FarmerListVM {
  FarmerListVM({
    this.farmerRespJModelBloc,
  });
  FarmerRespJModelBloc? farmerRespJModelBloc;

  Future<List<FarmerRespJModel>?> fetchFarmers(String? keyword) async {
    List<FarmerRespJModel>? _farmerRespJModelList =
        await load_FarmerRespJModel();

    if (_farmerRespJModelList != null) {
      farmerRespJModelBloc?.add(ObjChanged(_farmerRespJModelList));
    }
  }

  Future<List<FarmerRespJModel>?> fetchFarmerslocal(
      BuildContext buildContext) async {
    List<FarmerRespJModel>? _farmerRespJModelList =
        await load_FarmerRespJModel_local(buildContext);

    if (_farmerRespJModelList != null) {
      farmerRespJModelBloc?.add(ObjChanged(_farmerRespJModelList));
    }
  }

  Future<List<FarmerRespJModel>?> searchFarmers(String? keyword) async {
    List<FarmerRespJModel>? _farmerRespJModelList =
        await search_FarmerRespJModel(keyword!);

    if (_farmerRespJModelList != null) {
      farmerRespJModelBloc?.add(ObjChanged(_farmerRespJModelList));
    }
  }

  Future<List<FarmerRespJModel>?> searchFarmerslocal(
    String? keyword,
    BuildContext buildContext,
  ) async {
    List<FarmerRespJModel>? _farmerRespJModelList =
        await search_FarmerRespJModel_local(
      keyword!,
      buildContext,
    );

    if (_farmerRespJModelList != null) {
      farmerRespJModelBloc?.add(ObjChanged(_farmerRespJModelList));
    }
  }

  Future<bool> updateFarmerlocal(
      FarmerRespJModel farmerRespJModel, BuildContext buildContext) async {
    bool issaved =
        await farmer_dao_updateFarmerlocal(farmerRespJModel, buildContext);
    return issaved;
  }

  Future<int> insertFarmerlocal(
      FarmerRespJModel farmerRespJModel, BuildContext buildContext) async {
    int issavedid =
        await farmer_dao_insertFarmerlocal(farmerRespJModel, buildContext);
    return issavedid;
  }
}
