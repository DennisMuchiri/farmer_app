import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/view_model/objconverters/farm/FarmRespJModelConverterInterface.dart';
import 'package:injectable/injectable.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:mockito/mockito.dart';

const testenv = Environment('testenv');
@testenv
@Injectable(as: FarmRespJModelConverterInterface)
class MockFarmRespJModelConverter extends Mock
    implements FarmRespJModelConverterInterface {

  @override
  List<MrfarmsCompanion> getEntitiesCompFromFarmRespJModelList(
      List<FarmRespJModel> farmRespJModelList) {
    return super
        .noSuchMethod(Invocation.getter(#getIncrement), returnValue: []);
  }

  @override
  MrfarmsCompanion getEntityCompFromFarmRespJModel(
      FarmRespJModel farmRespJModel) {
    return super
        .noSuchMethod(Invocation.getter(#getIncrement), returnValue: MrfarmsCompanion());
  }

  @override
  MrfarmsCompanion getEntityCompFromFarmRespJModelWId(
      FarmRespJModel farmRespJModel) {
    return super
        .noSuchMethod(Invocation.getter(#getIncrement), returnValue: MrfarmsCompanion());
  }

  @override
  FarmRespJModel getFarmRespJModelFromEntity(Mrfarm mrfarm) {
    return super
        .noSuchMethod(Invocation.getter(#getIncrement), returnValue: FarmRespJModel());
  }

  @override
  List<FarmRespJModel> getFarmRespJModelListFromEntities(
      List<Mrfarm> mrfarmlist) {
    return super
        .noSuchMethod(Invocation.getter(#getIncrement), returnValue: []);
  }
}
