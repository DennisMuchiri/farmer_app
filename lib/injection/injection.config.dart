// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../model/repository/local/counter/i_counter_repository.dart' as _i7;
import '../model/repository/local/counter/repositories/counter_repository.dart'
    as _i8;
import '../model/repository/local/counter/repositories/dev_counter_repository.dart'
    as _i9;
import '../model/repository/local/counter/repositories/mock_counter_repository.dart'
    as _i10;
import '../view_model/counter/CounterChangeNotifier.dart' as _i11;
import '../view_model/objconverters/farm/FarmRespJModelConverter.dart' as _i4;
import '../view_model/objconverters/farm/FarmRespJModelConverterInterface.dart'
    as _i3;
import '../view_model/objconverters/farmer/FarmerRespJModelConverter.dart'
    as _i6;
import '../view_model/objconverters/farmer/FarmerRespJModelConverterInterface.dart'
    as _i5;

const String _prod = 'prod';
const String _dev = 'dev';
const String _testenv = 'testenv';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.FarmRespJModelConverterInterface>(
      () => _i4.FarmRespJModelConverter());
  gh.factory<_i5.FarmerRespJModelConverterInterface>(
      () => _i6.FarmerRespJModelConverter());
  gh.factory<_i7.ICounterRepository>(() => _i8.CounterRepository(),
      registerFor: {_prod});
  gh.factory<_i7.ICounterRepository>(() => _i9.DevCounterRepository(),
      registerFor: {_dev});
  gh.factory<_i7.ICounterRepository>(() => _i10.MockCounterRepository(),
      registerFor: {_testenv});
  gh.factory<_i11.CounterChangeNotifier>(
      () => _i11.CounterChangeNotifier(get<_i7.ICounterRepository>()));
  return get;
}
