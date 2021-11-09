// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../model/repository/local/counter/i_counter_repository.dart' as _i3;
import '../model/repository/local/counter/repositories/counter_repository.dart'
    as _i4;
import '../model/repository/local/counter/repositories/dev_counter_repository.dart'
    as _i5;
import '../model/repository/local/counter/repositories/mock_counter_repository.dart'
    as _i6;
import '../view_model/counter/CounterChangeNotifier.dart' as _i7;

const String _prod = 'prod';
const String _dev = 'dev';
const String _testenv = 'testenv';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ICounterRepository>(() => _i4.CounterRepository(),
      registerFor: {_prod});
  gh.factory<_i3.ICounterRepository>(() => _i5.DevCounterRepository(),
      registerFor: {_dev});
  gh.factory<_i3.ICounterRepository>(() => _i6.MockCounterRepository(),
      registerFor: {_testenv});
  gh.factory<_i7.CounterChangeNotifier>(
      () => _i7.CounterChangeNotifier(get<_i3.ICounterRepository>()));
  return get;
}
