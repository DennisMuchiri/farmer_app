import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';

abstract class FarmRespJModelConverterInterface {
  FarmRespJModel getFarmRespJModelFromEntity(Mrfarm mrfarm);

  List<FarmRespJModel> getFarmRespJModelListFromEntities(
      List<Mrfarm> mrfarmlist);

  MrfarmsCompanion getEntityCompFromFarmRespJModel(FarmRespJModel farmRespJModel);

  MrfarmsCompanion getEntityCompFromFarmRespJModelWId(FarmRespJModel farmRespJModel);

  List<MrfarmsCompanion> getEntitiesCompFromFarmRespJModelList(
      List<FarmRespJModel> farmRespJModelList);


}
