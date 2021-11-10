import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/view_model/objconverters/farmer/FarmerRespJModelConverterInterface.dart';
import 'package:injectable/injectable.dart';
import 'package:moor/moor.dart' as moor;

@Injectable(as: FarmerRespJModelConverterInterface)
class FarmerRespJModelConverter implements FarmerRespJModelConverterInterface {
  @override
  FarmerRespJModel getFarmerRespJModelFromEntity(Mrfarmer mrfarmer) {
    FarmerRespJModel fresp = FarmerRespJModel();
    fresp.id = mrfarmer.id;
    fresp.onlineid = mrfarmer.onlineid;
    fresp.first_name = mrfarmer.first_name;
    fresp.last_name = mrfarmer.last_name;
    fresp.member_number = mrfarmer.member_number;
    fresp.gender = mrfarmer.gender;
    fresp.phone_number = mrfarmer.phone_number;
    fresp.email = mrfarmer.email;

    fresp.issettobeupdated = mrfarmer.issettobeupdated;
    fresp.deleted = mrfarmer.deleted;
    return fresp;
  }

  @override
  List<FarmerRespJModel> getFarmerRespJModelListFromEntities(
      List<Mrfarmer> mrfarmerlist) {
    List<FarmerRespJModel> frmresplist = [];
    for (Mrfarmer mf in mrfarmerlist) {
      if (mf != null) {
        frmresplist.add(getFarmerRespJModelFromEntity(mf));
      }
    }

    return frmresplist;
  }

  @override
  List<MrfarmersCompanion> getEntitiesCompFromFarmerRespJModelList(
    List<FarmerRespJModel> farmerRespJModelList,
  ) {
    List<MrfarmersCompanion> compList = [];
    for (FarmerRespJModel fresp in farmerRespJModelList) {
      MrfarmersCompanion mfr = getEntityCompFromFarmerRespJModel(fresp);
      compList.add(mfr);
    }
    return compList;
  }

  @override
  MrfarmersCompanion getEntityCompFromFarmerRespJModel(
      FarmerRespJModel farmRespJModel) {
    MrfarmersCompanion mrfarmer = MrfarmersCompanion(
      id: moor.Value(farmRespJModel.id!),
      onlineid: moor.Value(farmRespJModel.onlineid),
      first_name: moor.Value(farmRespJModel.first_name),
      last_name: moor.Value(farmRespJModel.last_name),
      member_number: moor.Value(farmRespJModel.member_number),
      gender: moor.Value(farmRespJModel.gender),
      phone_number: moor.Value(farmRespJModel.phone_number),
      email: moor.Value(farmRespJModel.email),
      issettobeupdated: moor.Value(((farmRespJModel.issettobeupdated != null
          ? farmRespJModel.issettobeupdated!
          : false))),
      deleted: moor.Value(
          ((farmRespJModel.deleted != null ? farmRespJModel.deleted! : false))),
    );

    return mrfarmer;
  }
}
