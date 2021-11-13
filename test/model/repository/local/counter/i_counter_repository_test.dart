// This is a basic Flutter widget test.

import 'package:farmer_app/model/repository/local/counter/i_counter_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:farmer_app/injection/injection.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  setUp(() {
  });


  test('should get increment no 1', () {
    configureInjection(Env.testenv);
    int incr = 1;

    final mockCounterRepository=getIt<ICounterRepository>();

    //arrange
    when(mockCounterRepository.
    getIncrement()).
    thenReturn(incr);

    //act
    final result=  mockCounterRepository.getIncrement();

    //assert
    expect(result, incr);
    verify(mockCounterRepository.getIncrement()).called(1);
  });
}
