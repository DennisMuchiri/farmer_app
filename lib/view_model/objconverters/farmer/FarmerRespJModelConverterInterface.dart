import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';

abstract class FarmerRespJModelConverterInterface {
  FarmerRespJModel getFarmerRespJModelFromEntity(Mrfarmer mrfarmer);

  List<FarmerRespJModel> getFarmerRespJModelListFromEntities(
      List<Mrfarmer> mrfarmerlist);


  MrfarmersCompanion getEntityCompFromFarmerRespJModel(
      FarmerRespJModel farmRespJModel);

  MrfarmersCompanion getEntityCompFromFarmerRespJModelWId(
      FarmerRespJModel farmRespJModel);


  List<MrfarmersCompanion> getEntitiesCompFromFarmerRespJModelList(
      List<FarmerRespJModel> farmerRespJModelList);
}
