import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'package:farmer_app/model/repository/local/counter/i_counter_repository.dart';

const testenv = Environment('testenv');
@testenv
@Injectable(as: ICounterRepository)
class MockCounterRepository extends Mock implements ICounterRepository{
  @override
  int getIncrement() {
    return super.noSuchMethod(
        Invocation.getter(#getIncrement), returnValue: 123);
  }
}