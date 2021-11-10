import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:injectable/injectable.dart';
import 'package:moor/moor.dart' as moor;

import 'FarmRespJModelConverterInterface.dart';

@Injectable(as: FarmRespJModelConverterInterface)
class FarmRespJModelConverter implements FarmRespJModelConverterInterface {
  @override
  List<MrfarmsCompanion> getEntitiesCompFromFarmRespJModelList(
      List<FarmRespJModel> farmRespJModelList) {
    List<MrfarmsCompanion> compList = [];
    for (FarmRespJModel fresp in farmRespJModelList) {
      print("FarmRespJModelConverter farmer.farms3== ${fresp.farmer_online_id}");
      MrfarmsCompanion mfr = getEntityCompFromFarmRespJModel(fresp);
      compList.add(mfr);
    }
    return compList;
  }

  @override
  MrfarmsCompanion getEntityCompFromFarmRespJModel(
      FarmRespJModel farmRespJModel) {
    MrfarmsCompanion mrfarmsCompanion = MrfarmsCompanion(
      //id: moor.Value(farmRespJModel.id!),
      onlineid: moor.Value(farmRespJModel.onlineid),
      farm_name: moor.Value(farmRespJModel.farm_name),
      farm_size: moor.Value(farmRespJModel.farm_size),
      farmer: moor.Value(farmRespJModel.farmer),
      farmer_online_id: moor.Value(farmRespJModel.farmer_online_id),
      issettobeupdated: moor.Value(((farmRespJModel.issettobeupdated != null
          ? farmRespJModel.issettobeupdated!
          : false))),
      deleted: moor.Value(
          ((farmRespJModel.deleted != null ? farmRespJModel.deleted! : false))),
    );
    return mrfarmsCompanion;
  }

  @override
  FarmRespJModel getFarmRespJModelFromEntity(Mrfarm mrfarm) {
    FarmRespJModel farmRespJModel = FarmRespJModel();
    farmRespJModel.id = mrfarm.id;
    farmRespJModel.onlineid = mrfarm.onlineid;
    farmRespJModel.farm_name = mrfarm.farm_name;
    farmRespJModel.farm_size = mrfarm.farm_size;
    farmRespJModel.farmer = mrfarm.farmer;
    farmRespJModel.issettobeupdated = mrfarm.issettobeupdated;
    farmRespJModel.deleted = mrfarm.deleted;

    return farmRespJModel;
  }

  @override
  List<FarmRespJModel> getFarmRespJModelListFromEntities(
      List<Mrfarm> mrfarmlist) {
    List<FarmRespJModel> frmresplist = [];
    for (Mrfarm mf in mrfarmlist) {
      if (mf != null) {
        frmresplist.add(getFarmRespJModelFromEntity(mf));
      }
    }

    return frmresplist;
  }
}
