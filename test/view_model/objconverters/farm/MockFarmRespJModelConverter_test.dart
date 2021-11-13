import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/view_model/objconverters/farm/FarmRespJModelConverterInterface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  setUp(() {});

  test('farm getEntityCompFromFarmRespJModel should return a converted companion object', () {
    configureInjection(Env.testenv);
    final farmRespJModelConverterInterface =
        getIt<FarmRespJModelConverterInterface>();
    MrfarmsCompanion exp_res = MrfarmsCompanion();
    //arrange
    when(farmRespJModelConverterInterface
            .getEntityCompFromFarmRespJModel(FarmRespJModel()))
        .thenReturn(exp_res);
    //act
    final result = farmRespJModelConverterInterface
        .getEntityCompFromFarmRespJModel(FarmRespJModel());

    //assert
    expect(result, exp_res);
    verify(farmRespJModelConverterInterface
            .getEntityCompFromFarmRespJModel(FarmRespJModel()))
        .called(1);
  });
}
